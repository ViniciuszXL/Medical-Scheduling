import 'package:flutter/material.dart';

// Pages //
import 'package:medical_scheduling/pages/Inicio/Inicio.dart';
import 'package:medical_scheduling/pages/Login/Login.dart';
import 'package:medical_scheduling/pages/Registro/Registro.dart';

// Especialistas //
import 'package:medical_scheduling/pages/Especialistas/Especialistas.dart';

// Consultas //
import 'package:medical_scheduling/pages/Consultas/ConsultasAgendadas.dart';

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
      home: Inicio("Marcus Mendonça"),
      routes: <String, WidgetBuilder>{
        '/homePage': (context) => new Login(),
        '/registerPage': (context) => new Registro(),
        '/especialistasPage': (context) => new Especialistas(),
        '/consultasAgendadas': (context) => new ConsultasAgendadas(),
      },
    );

    return app;
  }
}
