import 'package:flutter/material.dart';

// Pages //
import 'package:medical_scheduling/pages/Consultas/ConsultasAgendadas.dart';
import 'package:medical_scheduling/pages/Consultas/MarcarConsultas.dart';

// Utilitaries //
import 'package:medical_scheduling/pages/Utilitaries/Utilitaries.dart';

class Inicio extends StatelessWidget {
  String name;

  Inicio(this.name);

  @override
  Widget build(BuildContext context) {
    Scaffold scaffold = new Scaffold(
      appBar: Utilitaries.createAppBar(false, 'Serviço de consulta médica', 25),
      body: ListView(
        children: [
          Container(
            child: initialUI(context),
          )
        ],
      ),
    );
    return scaffold;
  }

  Widget initialUI(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 60,
          alignment: Alignment.center,
          margin: EdgeInsets.all(15.0),
          child: Text(
            "Bem-vindo, " + name + "!",
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
          ),
        ),
        Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                right: 15,
                left: 15,
                bottom: 15,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: FlatButton(
                color: Colors.blue,
                padding: EdgeInsets.all(12.5),
                child: Row(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(right: 10),
                      child: Icon(
                        Icons.add,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Marcar consulta',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                onPressed: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MarcarConsultas(this.name)))
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                right: 15,
                left: 15,
                bottom: 15,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: FlatButton(
                color: Colors.blue,
                padding: EdgeInsets.all(12.5),
                child: Row(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(right: 10),
                      child: Icon(
                        Icons.schedule,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Consultas agendadas',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                onPressed: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ConsultasAgendadas(this.name)))
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
