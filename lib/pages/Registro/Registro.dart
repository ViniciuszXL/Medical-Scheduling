import 'package:flutter/material.dart';
import '../Utilitaries/Utilitaries.dart';

class Registro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Scaffold scaffold = new Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: 90,
          left: 40,
          right: 40,
        ),
        color: Colors.blue,
        child: ListView(
            Utilitaries.constructLogo(96, 'assets/logo/main.png'),
            Utilitaries.constructSpace(20),
            Utilitaries.createForm(true, false, TextInputType.number, "CPF",
                "Insira seu CPF", Colors.white, Icons.perm_identity
      ),
    );

    return scaffold;
  }
}
