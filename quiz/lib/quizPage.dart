import "dart:async";
import "dart:convert";
import "dart:math";
import "package:flutter/material.dart";
import "package:flutter_countdown_timer/index.dart";
import "package:hive/hive.dart";
import 'package:quickalert/quickalert.dart';
import 'package:http/http.dart' as http;

class quizPage extends StatefulWidget {
  const quizPage({super.key});

  @override
  State<quizPage> createState() => _quizPageState();
}

class _quizPageState extends State<quizPage> {
  var question = [];
  int index = 0;
  int quesionNO = 0;
  int correctAnswer = 0;
  int wrongAnswer = 0;
  var response;
  bool full = true;
  bool absorb = false;
  late Timer _timer;
  var box = Hive.box('myBox');

  Future<http.Response> getData() async {
    var result = await http.get(
      Uri.parse("https://ali-izadi.ir/Quiz/questions.json"),
    );
    question = jsonDecode(result.body)["result"];
    index = Random().nextInt(question.length);
    return result;
  }

  incrementHeart() async {
    while (box.get('heart') <= 4) {
      await Future.delayed(const Duration(minutes: 2), () {
        setState(() {
          box.put('heart', box.get('heart') + 1);
        });
      });
      box.put('heart', box.get('heart'));
    }
  }

  @override
  void initState() {
    if (box.get('heart') == null) {
      box.put('heart', 5);
    }
    response = getData();
    startTimer();
    super.initState();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 15), (timer) {
      setState(() {
        index++;
        quesionNO++;
        wrongAnswer++;
        box.put('heart', box.get('heart') - 1);
      });

      if (index == question.length) {
        index = 0;
      }

      if (quesionNO == 9) {
        Navigator.pushNamed(context, '/result', arguments: {
          'correct': correctAnswer.toString(),
          'wrong': wrongAnswer.toString(),
          'total': '10',
        });
      }

      if (box.get('heart') == 0) {
        QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: 'Oops...',
            text: "You Don't Have Heart",
            onConfirmBtnTap: () {
              Navigator.pushNamed(context, '/home');
            });
        _timer.cancel();
      }

      if (box.get('time') == null) {
        box.put('time', DateTime.now().millisecondsSinceEpoch + 1000 * 1800);
      }
    });
  }

  void resetTimer() {
    _timer.cancel();
    startTimer();
  }

  refreshTimer() {
    if (box.get('heart') == 5) {
      box.put('time', null);
    }
  }

  validate(i) {
    if (question[index]['answer'] == i.toString()) {
      correctAnswer++;
    } else {
      wrongAnswer++;
      box.put('heart', box.get('heart') - 1);
    }

    if (box.get('time') == null && box.get('heart') <= 4) {
      box.put('time', DateTime.now().millisecondsSinceEpoch + 1000 * 1800);
    } else if (box.get('heart') == 5) {
      box.put('time', null);
    }

    if (box.get('heart') == 0 && quesionNO == 9) {
      _timer.cancel();
      Navigator.pushNamed(context, '/result', arguments: {
        'correct': correctAnswer.toString(),
        'wrong': wrongAnswer.toString(),
        'total': '10',
      });
    }

    if (box.get('heart') == 0) {
      QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Oops...',
          text: "You Don't Have Heart",
          onConfirmBtnTap: () {
            Navigator.pushNamed(context, '/home');
          });
      _timer.cancel();
    }

    if (box.get('heart') == 5) {
      full = true;
    }

    if (box.get('heart') >= 0 && box.get('heart') <= 4 && full == true) {
      full = false;
      incrementHeart();
    }

    if (index == question.length - 1) {
      index = -1;
    }

    if (quesionNO < 9) {
      setState(() {
        index++;
        quesionNO++;
      });
    } else {
      _timer.cancel();
      Navigator.pushNamed(context, '/result', arguments: {
        'correct': correctAnswer.toString(),
        'wrong': wrongAnswer.toString(),
        'total': '10',
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: FutureBuilder(
          future: response,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Column(children: [
                Container(
                  width: double.infinity,
                  height: screenHeight / 2,
                  color: Colors.yellow,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Icon(
                                Icons.favorite,
                                size: 40,
                                color: Color.fromARGB(255, 249, 84, 72),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 4),
                                child: Text(
                                  box.get('heart').toString(),
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Center(
                            child: (box.get('time') != null) &&
                                    (box.get('heart') != 5)
                                ? CountdownTimer(
                                    endTime: box.get('time'),
                                    onEnd: () {
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                        setState(() {
                                          box.put(
                                              'time',
                                              DateTime.now()
                                                      .millisecondsSinceEpoch +
                                                  1000 * 1800);
                                        });
                                      });
                                    },
                                    widgetBuilder:
                                        (_, CurrentRemainingTime? time) {
                                      if (time == null) {
                                        return Text('');
                                      }
                                      return Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 4.0),
                                          child: (time.min == null)
                                              ? (time.sec! < 10)
                                                  ? Text(
                                                      '00:0${time.sec}',
                                                      style: TextStyle(
                                                          fontSize: 20),
                                                    )
                                                  : Text(
                                                      '00:${time.sec}',
                                                      style: TextStyle(
                                                          fontSize: 20),
                                                    )
                                              : (time.sec! < 10)
                                                  ? Text(
                                                      '${time.min}:0${time.sec}',
                                                      style: TextStyle(
                                                          fontSize: 20),
                                                    )
                                                  : Text(
                                                      '${time.min}:${time.sec}',
                                                      style: TextStyle(
                                                          fontSize: 20),
                                                    ));
                                    },
                                  )
                                : refreshTimer(),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Center(
                          child: Text(
                            question[index]['title'],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 25),
                          ),
                        ),
                      ),
                      Text((quesionNO + 1).toString())
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.black,
                    height: screenHeight / 2,
                    child: Column(
                      children: [
                        SizedBox(
                          height: screenHeight / 8,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              options(0),
                              SizedBox(
                                width: 10,
                              ),
                              options(1),
                              SizedBox(
                                width: 10,
                              ),
                            ]),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            options(2),
                            SizedBox(
                              width: 10,
                            ),
                            options(3),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ]);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  Expanded options(int option) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          resetTimer();
          validate(option);
        },
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            question[index]['options'][option],
            style: TextStyle(
              fontSize: 18.0,
              color: Color.fromARGB(255, 252, 252, 252),
            ),
          ),
        ),
        style: ElevatedButton.styleFrom(
          minimumSize: Size(150, 50),
          backgroundColor: Color.fromARGB(171, 28, 28, 59),
        ),
      ),
    );
  }
}