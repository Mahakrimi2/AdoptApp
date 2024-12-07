import 'package:flutter/material.dart';
import 'screens/DogList.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AdoPet - Adoption de Chiens',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DogListScreen(),
    );
  }
}
