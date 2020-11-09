import 'package:flutter/material.dart';

// Pages //
import 'package:medical_scheduling/pages/Login/Login.dart';
import 'package:medical_scheduling/pages/Registro/Registro.dart';

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
      routes: <String, WidgetBuilder>{
        '/homePage': (context) => new Login(),
        '/registerPage': (context) => new Registro(),
      },
    );

    return app;
  }
}
