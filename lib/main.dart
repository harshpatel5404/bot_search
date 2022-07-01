
import 'package:bot_search/screens/Home/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bot Search',
      theme: ThemeData(  
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

 