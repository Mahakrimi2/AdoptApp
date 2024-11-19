import 'package:flutter/material.dart';
import 'data/dog_data.dart'; 
import 'screens/mainscreen.dart'; 

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(dogs: dogList),
    );
  }
}