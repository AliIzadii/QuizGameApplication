import 'package:flutter/material.dart';

class resultPage extends StatelessWidget {
  const resultPage({super.key});

  @override
  Widget build(BuildContext context) {
    var data;
    data = ModalRoute.of(context)!.settings.arguments;
    double screenHeight = MediaQuery.of(context).size.height;
    if ((int.parse(data['correct']) / int.parse(data['total'])) * 100 >= 70) {
      return mainWidget(screenHeight: screenHeight, data: data, bgColor: Color.fromARGB(255, 2, 179, 76), mainText: 'Well Done!', belowText: 'Excellent!',);
    } else {
      return mainWidget(screenHeight: screenHeight, data: data, bgColor:  Color.fromARGB(255, 179, 37, 2), mainText: 'Not Bad!', belowText: 'Better Luck Next Time!',);
    }
  }
}

class mainWidget extends StatelessWidget {
  final double screenHeight;
  final data;
  final Color bgColor;
  final String mainText;
  final String belowText;

  const mainWidget({
    super.key,
    required this.screenHeight,
    required this.data,
    required this.bgColor,
    required this.mainText,
    required this.belowText,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(
          width: double.infinity,
          height: screenHeight / 2,
          color: bgColor,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(
              height: 15,
            ),
            Text(
              mainText,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Color.fromARGB(255, 219, 247, 230)),
            ),
            Text(
              'You Complete The Questions',
              style: TextStyle(
                  fontSize: 12, color: Color.fromARGB(255, 219, 247, 230)),
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: Image.asset(
                'assets/Trophy.png',
                width: 250,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              belowText,
              style: TextStyle(
                  fontSize: 18, color: Color.fromARGB(255, 219, 247, 230)),
            ),
            SizedBox(
              height: 5,
            ),
            Icon(Icons.check,
                color: Color.fromARGB(255, 219, 247, 230), size: 18),
          ]),
        ),
        Expanded(
          child: Container(
            color: Color.fromARGB(255, 219, 224, 226),
            height: screenHeight / 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Your Statistics',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Correct Answer: ',
                      style: TextStyle(fontSize: 15, color: Colors.green),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      data['correct'],
                      style: TextStyle(fontSize: 15, color: Colors.green),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Wrong Answer: ',
                      style: TextStyle(fontSize: 15, color: Colors.red),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      data['wrong'],
                      style: TextStyle(fontSize: 15, color: Colors.red),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: 300,
                  height: 50,
                  child: ElevatedButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 93, 12, 232),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/home');
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Back To Home',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: 300,
                  height: 50,
                  child: ElevatedButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 93, 12, 232),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/quiz');
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Start Again',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}