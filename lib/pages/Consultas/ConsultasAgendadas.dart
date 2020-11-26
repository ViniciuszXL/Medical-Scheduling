import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Utilitaries //
import 'package:medical_scheduling/pages/Utilitaries/Utilitaries.dart';

class ConsultasAgendadas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Scaffold scaffold = new Scaffold(
      appBar: Utilitaries.createAppBar(true, 'Consultas agendadas', 25),
      body: ListView(
        children: <Widget>[
          Container(
            child: Center(
              child: initialUI(),
            ),
          ),
        ],
      ),
    );
    return scaffold;
  }

  Widget initialUI() {
    return Column(
      children: <Widget>[
        Utilitaries.constructSpace(20),
        Container(
          child: Text(
            "Não há consultas agendadas!",
            style: TextStyle(
              fontSize: 25,
            ),
          ),
        ),
      ],
    );
  }

  Widget create(String date, String specialty, String doctor, String clinic) {
    return Container(
      margin: EdgeInsets.only(right: 15, left: 15, bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Container(
              padding: EdgeInsets.all(10),
              child: Text(
                date,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 8.0, top: 8.0),
            child: Text(
              'Especialidade: ' + specialty,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 8.0, top: 8.0),
            child: Text(
              'Doutor: ' + doctor,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 8.0, top: 8.0),
            child: Text(
              'Clínica: ' + clinic,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: FlatButton(
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Desmarcar',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    onPressed: () => {},
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
