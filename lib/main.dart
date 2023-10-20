import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/screen/Event.dart';

void main() async {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData().copyWith(
        scaffoldBackgroundColor: Colors.white,
        errorColor: Colors.red,
        colorScheme: ThemeData().colorScheme.copyWith(
          primary:  Colors.blue,
        ),
        primaryColor:   Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<MyHomePage> {


  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 2),
          () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>Eventspage())),

    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(

        decoration:  BoxDecoration(
          color:  Colors.blue,
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text('Snapwork Technologies Pvt Ltd',textAlign:TextAlign.center,style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.w500),),
          ),
        ),
      ),
    );
  }
}