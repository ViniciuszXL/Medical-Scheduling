import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Utilitaries //
import 'package:medical_scheduling/pages/Utilitaries/Utilitaries.dart';
import 'dart:convert';

class MarcarConsultas extends StatefulWidget {
  String userName;

  MarcarConsultas(this.userName);

  @override
  _MarcarConsultasState createState() => _MarcarConsultasState(this.userName);
}

class _MarcarConsultasState extends State<MarcarConsultas> {
  String userName;

  // Clinicas //
  String clinicSelected = 'Selecionar clinica';
  List<String> clinicList;

  // Especialidades //
  String specialtySelected = 'Selecionar especialidade';
  List<String> specialtyList;

  // Doutores//
  String doctorSelected = 'Nenhum doutor selecionado';
  List<String> doctorList;

  // Dates //
  String dateSelected = 'Nenhuma data selecionada';
  var _dateList = [
    'Nenhuma data selecionada',
    '10/12',
    '11/12',
    '12/12',
    '13/12',
    '14/12',
    '15/12',
    '16/12',
    '17/12',
    '18/12',
    '19/12',
    '20/12',
    '21/12',
    '22/12',
    '23/12',
    '24/12',
    '25/12',
    '26/12',
    '27/12',
    '28/12',
    '29/12',
    '30/12'
  ];

  _MarcarConsultasState(String userName) {
    this.userName = userName;
    clinicList = new List<String>();
    clinicList.add('Selecionar clinica');
    searchClinics();

    specialtyList = new List<String>();
    specialtyList.add('Selecionar especialidade');

    doctorList = new List<String>();
    doctorList.add('Nenhum doutor selecionado');
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
        clinicsUI(),
        Utilitaries.constructSpace(10.0),
        specialtyUI(),
        Utilitaries.constructSpace(10.0),
        doctorsUI(),
        Utilitaries.constructSpace(10.0),
        showDate(),
        Utilitaries.constructSpace(25.0),
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
          onPressed: () => createAppointment(),
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

  Widget clinicsUI() {
    return Container(
      child: Column(
        children: <Widget>[
          createContainer('Selecione a clínica'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: DropdownButton<String>(
                    items: clinicList.map((String item) {
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
                      selectClinic(novoItem);
                    },
                    value: clinicSelected),
              ),
            ],
          ),
        ],
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
                  items: specialtyList.map((String item) {
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

  Widget doctorsUI() {
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
                  items: doctorList.map((String item) {
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

  void searchClinics() async {
    String url = Utilitaries.getUrl() + 'clinics';
    final response = await http.get(url);
    final jsonDecode = await json.decode(response.body);
    if (Utilitaries.isError(jsonDecode)) ;

    setState(() {
      for (int i = 0; i < jsonDecode.length; i++) {
        final data = jsonDecode[i];
        final name = data['name'];
        if (!clinicList.contains(name)) {
          clinicList.add(name);
        }
      }
    });
  }

  void selectClinic(String newClinic) {
    setState(() => {
          this.clinicSelected = newClinic,
          searchSpecialty(newClinic),
        });
  }

  void searchSpecialty(String clinicName) async {
    String url = Utilitaries.getUrl() + 'clinics?name=' + clinicName;
    final clinicResponse = await http.get(url);
    final clinicDecode = await json.decode(clinicResponse.body);
    if (Utilitaries.isError(clinicDecode)) return;

    int clinicId = clinicDecode[0]['id'];
    url = Utilitaries.getUrl() + 'specialty?clinicId=' + clinicId.toString();
    final specialtyResponse = await http.get(url);
    final specialtyDecode = await json.decode(specialtyResponse.body);
    if (Utilitaries.isError(specialtyDecode)) return;

    setState(() {
      specialtyList.clear();
      specialtyList.add('Selecionar especialidade');
      for (int i = 0; i < specialtyDecode.length; i++) {
        final data = specialtyDecode[i];
        final name = data['specialty'];
        if (!specialtyList.contains(name)) {
          specialtyList.add(name);
        }
      }
    });
  }

  void setSpecialty(String newSpecialty) {
    setState(() => {
          this.specialtySelected = newSpecialty,
          searchDoctor(newSpecialty),
        });
  }

  void searchDoctor(String specialty) async {
    String url = Utilitaries.getUrl() + 'specialty?specialtyName=' + specialty;
    final specialtyResponse = await http.get(url);
    final specialtyDecode = await json.decode(specialtyResponse.body);
    if (Utilitaries.isError(specialtyDecode)) return;

    int specialtyId = specialtyDecode[0]['id'];
    url =
        Utilitaries.getUrl() + 'doctors?specialtyId=' + specialtyId.toString();
    final doctorResponse = await http.get(url);
    final doctorDecode = await json.decode(doctorResponse.body);
    if (Utilitaries.isError(doctorDecode)) return;

    setState(() {
      doctorList.clear();
      doctorList.add('Nenhum doutor selecionado');
      for (int i = 0; i < doctorDecode.length; i++) {
        final data = doctorDecode[i];
        final name = data['name'];
        if (!doctorList.contains(name)) {
          doctorList.add(name);
        }
      }
    });
  }

  void createAppointment() async {
    String url =
        Utilitaries.getUrl() + 'markappointment?time=' + this.dateSelected;
    url += '&clinicName=' + this.clinicSelected;
    url += '&userName=' + this.userName;
    url += '&doctorName=' + this.doctorSelected;
    print(url);
    final response = await http.put(url);
    final decode = await json.decode(response.body);
    print(decode);
    if (Utilitaries.isError(decode)) {
      Utilitaries.createAlert(context, 'Ocorreu um erro', decode[0]['message']);
      return;
    }

    String message = decode[0]['message'];
    Utilitaries.createAlert(context, 'Sucesso!', message);
    delete();
  }

  void setDate(String newDate) {
    setState(() => {this.dateSelected = newDate});
  }

  void setDoctor(String newDoctor) {
    setState(() => {this.doctorSelected = newDoctor});
  }

  void delete() {
    setState(() {
      this.clinicSelected = 'Selecionar clinica';
      this.specialtySelected = 'Selecionar especialidade';
      this.doctorSelected = 'Nenhum doutor selecionado';
      this.dateSelected = 'Nenhuma data selecionada';

      this.specialtyList.clear();
      this.specialtyList.add('Selecionar especialidade');

      this.doctorList.clear();
      this.doctorList.add('Nenhum doutor selecionado');
    });
  }
}
