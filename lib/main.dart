import 'package:flutter/material.dart';
import 'package:medical_scheduling/pages/Login/Login.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MaterialApp app = new MaterialApp(
      title: 'Medical Scheduling',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Login(),
    );

    return app;
  }
}
