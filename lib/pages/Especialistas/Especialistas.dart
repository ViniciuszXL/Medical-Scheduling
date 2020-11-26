import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Utilitaries //
import 'package:medical_scheduling/pages/Utilitaries/Utilitaries.dart';

class Especialistas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Scaffold scaffold = new Scaffold(
      appBar: Utilitaries.createAppBar(true, 'Especialistas', 24),
      body: ListView(
        children: <Widget>[
          Container(
            child: Center(
              child: specialistsUI(),
            ),
          ),
        ],
      ),
    );
    return scaffold;
  }

  Widget specialistsUI() {
    return Column(
      children: <Widget>[
        Utilitaries.constructSpace(20),
        Container(
          margin: EdgeInsets.only(right: 15, left: 15, bottom: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: <Widget>[
              Container(
                child: Utilitaries.constructLogo(
                    100, 'assets/specialists/Alberto_Costa.png'),
              )
            ],
          ),
        ),
      ],
    );
  }
}
