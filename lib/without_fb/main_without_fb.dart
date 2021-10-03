import 'package:flutter/material.dart';
import 'homepage_without_fb.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "voting app",
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
