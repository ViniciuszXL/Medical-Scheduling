import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Utilitaries //
import 'package:medical_scheduling/pages/Utilitaries/Utilitaries.dart';

class Inicio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Scaffold scaffold = new Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'INICIO',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.normal,
            color: Colors.white,
          ),
        ),
      ),
    );
    return scaffold;
  }
}
