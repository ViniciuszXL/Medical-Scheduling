import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Utilitaries //
import 'package:medical_scheduling/pages/Utilitaries/Utilitaries.dart';

class MarcarConsultas extends StatefulWidget {
  @override
  _MarcarConsultasState createState() => _MarcarConsultasState();
}

class _MarcarConsultasState extends State<MarcarConsultas> {
  // Especialidades //
  String specialtySelected = 'Selecionar especialidade';
  var _especialidades = [
    'Selecionar especialidade',
    'Urologista',
    'Clínico Geral',
    'Ultrasonografia',
  ];

  // Dates //
  String dateSelected = 'Nenhuma data selecionada';
  var _dateList = [
    'Nenhuma data selecionada',
    '10/11',
    '11/11',
    '12/11',
    '13/11',
    '14/11',
    '15/11',
    '16/11',
    '17/11',
    '18/11',
    '19/11',
    '20/11',
    '21/11',
    '22/11',
    '23/11',
    '24/11',
    '25/11',
    '26/11',
    '27/11',
    '28/11',
    '29/11',
    '30/11'
  ];

  // Médicos por especialidades //
  String doctorSelected = 'Nenhum doutor encontrado';
  var _doctorList = ['Nenhum doutor encontrado'];
  Map<String, List<String>> _doctorsPerSpecialty = new Map();

  _MarcarConsultasState() {
    _doctorsPerSpecialty.putIfAbsent(
        'Urologista', () => ['Drº Francisco Chaves', 'Drº Márcio Araújo']);

    _doctorsPerSpecialty.putIfAbsent('Clínico Geral',
        () => ['Drº Cleiton Neves', 'Drº Adalberto Nascimento']);

    _doctorsPerSpecialty.putIfAbsent(
        'Ultrasonografia', () => ['Drº Júlio Castro', 'Drº Alberto Costa']);
  }

  @override
  Widget build(BuildContext context) {
    Scaffold scaffold = new Scaffold(
      appBar: Utilitaries.createAppBar(true, 'Marcar consultas', 25),
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
        specialtyUI(),
        Utilitaries.constructSpace(10.0),
        doctorsPerSpecialtyUI(),
        Utilitaries.constructSpace(10.0),
        showDate(),
        Utilitaries.constructSpace(60.0),
        FlatButton(
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 30.0, right: 30.0),
            height: 60,
            decoration: BoxDecoration(
              color: Colors.blue,
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 15),
                  child: Text(
                    'Marcar consulta',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 15),
                  child: Icon(
                    Icons.add_box,
                    color: Colors.lightGreen,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
          onPressed: () => {},
        ),
        Utilitaries.constructSpace(15),
        FlatButton(
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 30.0, right: 30.0),
            height: 60,
            decoration: BoxDecoration(
              color: Colors.blue,
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 15),
                  child: Text(
                    'Apagar campos',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 15),
                  child: Icon(
                    Icons.delete,
                    color: Colors.redAccent,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
          onPressed: () => delete(),
        ),
      ],
    );
  }

  Widget createContainer(String text) {
    return Container(
      color: Colors.blue,
      height: 50,
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget specialtyUI() {
    return Container(
      child: Column(
        children: <Widget>[
          createContainer('Selecione a especialidade'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: DropdownButton<String>(
                  items: _especialidades.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String novoItem) {
                    setSpecialty(novoItem);
                  },
                  value: specialtySelected,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget doctorsPerSpecialtyUI() {
    return Container(
      child: Column(
        children: <Widget>[
          createContainer('Selecione o doutor'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 25.0, right: 25.0),
                child: DropdownButton<String>(
                  items: _doctorList.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String novoItem) {
                    setDoctor(novoItem);
                  },
                  value: doctorSelected,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget showDate() {
    return Container(
      child: Column(
        children: <Widget>[
          createContainer('Selecione a data para a consulta'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 25.0, right: 25.0),
                child: DropdownButton<String>(
                  items: _dateList.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String novoItem) {
                    setDate(novoItem);
                  },
                  value: dateSelected,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void delete() {
    setState(() {
      this.specialtySelected = 'Selecionar especialidade';
      this._doctorList = ['Nenhum doutor encontrado'];
      this.doctorSelected = 'Nenhum doutor encontrado';
      this.dateSelected = 'Nenhuma data selecionada';
    });
  }

  void setDate(String newDate) {
    setState(() => {this.dateSelected = newDate});
  }

  void setDoctor(String newDoctor) {
    setState(() => {this.doctorSelected = newDoctor});
  }

  void setSpecialty(String novoItem) {
    setState(() => {
          this.specialtySelected = novoItem,
          this._doctorList = getDoctorsPerSpecialty()
        });
  }

  List<String> getDoctorsPerSpecialty() {
    var _list = [specialtySelected];
    if (specialtySelected.contains('Selecionar especialidade'))
      _list = [doctorSelected];

    _doctorsPerSpecialty.forEach((key, value) {
      if (key.contains(specialtySelected)) {
        _list = ['Selecione um doutor'];
        this.doctorSelected = 'Selecione um doutor';
        value.forEach((element) => _list.add(element));
      }
    });

    return _list;
  }
}
