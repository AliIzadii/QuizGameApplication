import "package:flutter/material.dart";
import "package:hive_flutter/hive_flutter.dart";
import "package:quickalert/quickalert.dart";

class welcomePage extends StatefulWidget {
  const welcomePage({super.key});

  @override
  State<welcomePage> createState() => _welcomePageState();
}

class _welcomePageState extends State<welcomePage> {
  @override
  var box = Hive.box('myBox');
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(230, 69, 201, 199),
              Color.fromARGB(255, 207, 73, 207)
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/quiz1.png', width: 250),
              SizedBox(
                height: 50,
              ),
              Text(
                'Welcome To Quiz Game App',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(
                height: 70,
              ),
              Image.asset('assets/quiz2.png', width: 250),
              SizedBox(
                height: 70,
              ),
              Container(
                decoration: ShapeDecoration(
                    shape: StadiumBorder(),
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 232, 207, 19),
                        const Color.fromARGB(255, 249, 143, 5),
                      ],
                    )),
                child: SizedBox(
                  width: 300,
                  height: 50,
                  child: MaterialButton(
                    onPressed: () {
                      if (box.get('heart') == 0) {
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.error,
                          title: 'Oops...',
                          text: "You Don't Have Heart",
                        );
                      } else {
                        Navigator.pushNamed(context, '/quiz');
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Play',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              SizedBox(
                width: 300,
                height: 50,
                child: ElevatedButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/help');
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'How To Play',
                      style: TextStyle(
                          color: Color.fromARGB(255, 154, 149, 149),
                          fontSize: 18),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
