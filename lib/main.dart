import 'package:flutter/material.dart';
import 'package:flutter_food_2/pages/home/home_pagew11.dart';
import 'package:flutter_food_2/pages/home/login.dart';
import 'package:flutter_food_2/pages/home/home_pagew12.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Food',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: Login(),
    );
  }
}



