import "package:flutter/material.dart";

class helpPage extends StatelessWidget {
  const helpPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 177, 211, 239),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 177, 211, 239),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15, left: 30, right: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: screenHeight / 1.5,
              width: screenWidth / 1.19,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, right: 20.0, left: 20.0, bottom: 5.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset('assets/think.png'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 22.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'How You\nFeel World?',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 28),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 22.0, right: 22.0),
                      child: Text(
                        'Lorem, ipsum dolor sit am Tempore repudiandae gpfle aiurl architecto laboriosam odio laudantium cumque ducimus.',
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Read More About Us',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.blueAccent,
                      ),
                    ),
                    IconButton(
                        iconSize: 20,
                        onPressed: () async {
                          await showDialog(
                              barrierColor: Colors.black12.withOpacity(0.7),
                              context: context,
                              builder: (_) {
                                return Dialog(
                                  elevation: 0,
                                  backgroundColor: Colors.black54,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Container(
                                      child: Text(
                                        'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Tempore numquam repudiandae explicabo aut architecto laboriosam odio laudantium cumque ducimus cum nulla labore hic quam, beatae soluta debitis pariatur dicta consequatur a voluptas, distinctio amet molestiae? Blanditiis odio unde mollitia quos quis recusandae tenetur voluptates amet, aut officiis nihil atque cupiditate inventore est voluptatum ipsum modi nam magni? Neque quaerat amet fugit voluptas sed cupiditate alias quam modi cumque corporis hic, beatae, in eaque rem! Maiores veritatis aspernatur labore.',
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                );
                              });
                        },
                        icon: Icon(Icons.expand_more_sharp))
                  ]),
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              width: 300,
              height: 50,
              child: ElevatedButton(
                style: TextButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 12, 63, 232),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'START QUIZ',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
