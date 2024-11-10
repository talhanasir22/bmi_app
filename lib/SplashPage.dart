import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class SplashPage extends StatefulWidget{
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const MyHomePage(title: 'BMI Calculator',)));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.white,
      child: Center(child: Container(
          height: 100,
          width: 100,
          child: Image.asset('assets/Images/BMI logo.png',
          ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(21)
        ),
      )),
    );
  }
}