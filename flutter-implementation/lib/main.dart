import 'package:fashionetti/routes/homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Welcome To Phones Galore",
      theme: ThemeData(primarySwatch: Colors.green),
      home: PhonesPage(),
    );
  }
}
