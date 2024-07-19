import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quiz/helpPage.dart';
import 'package:quiz/quizPage.dart';
import 'package:quiz/resultPage.dart';
import 'package:quiz/welcomePage.dart';

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

void main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox('myBox');
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: welcomePage(),
        routes: {
          '/help': (context) => helpPage(),
          '/home': (context) => welcomePage(),
          '/quiz': (context) => quizPage(),
          '/result': (context) => resultPage(),
        },
      ),
    );
  }
}