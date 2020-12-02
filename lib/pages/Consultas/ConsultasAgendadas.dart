import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Utilitaries //
import 'package:medical_scheduling/pages/Utilitaries/Utilitaries.dart';
import 'dart:convert';

class Appointment {
  int id;
  String time;

  int clinicId;
  String clinicName;

  int doctorId;
  String doctorName;

  int specialtyId;
  String specialtyName;

  Appointment(this.id, this.time, this.clinicId, this.clinicName, this.doctorId,
      this.doctorName, this.specialtyId, this.specialtyName);

  String toString() {
    return "[id=" +
        this.id.toString() +
        ",time=" +
        this.time +
        ",clinicId=" +
        this.clinicId.toString() +
        ",clinicName=" +
        this.clinicName +
        ",doctorId=" +
        this.doctorId.toString() +
        ",doctorName=" +
        this.doctorName +
        ",specialtyId=" +
        this.specialtyId.toString() +
        ",specialtyName=" +
        this.specialtyName +
        "]";
  }
}

class ConsultasAgendadas extends StatefulWidget {
  String userName;

  ConsultasAgendadas(this.userName);

  @override
  _ConsultasAgendadasState createState() =>
      _ConsultasAgendadasState(this.userName);
}

class _ConsultasAgendadasState extends State<ConsultasAgendadas> {
  String userName;

  List<Appointment> appointmentList;

  _ConsultasAgendadasState(String userName) {
    this.userName = userName;
    this.appointmentList = new List<Appointment>();
    getAppointments();
  }

  void getAppointments() async {
    String url = Utilitaries.getUrl() + 'user?name=' + this.userName;
    final userResponse = await http.get(url);
    final userDecode = await json.decode(userResponse.body);
    String result = userDecode[0]['result'];
    if (result == 'error')
      return Utilitaries.createAlert(context, 'Erro!',
          'Ocorreu um erro ao buscar suas consultas. Tente novamente mais tarde!');

    int userId = userDecode[0]['id'];
    url = Utilitaries.getUrl() + 'appointment?id=' + userId.toString();
    final appointmentResponse = await http.get(url);
    final appointmentDecode = await json.decode(appointmentResponse.body);
    result = appointmentDecode[0]['result'];
    if (result == 'error')
      return Utilitaries.createAlert(context, 'Erro!',
          'Ocorreu um erro ao buscar suas consultas. Tente novamente mais tarde!');

    List<Appointment> cacheList = new List<Appointment>();
    for (int i = 0; i < appointmentDecode.length; i++) {
      var data = appointmentDecode[i];
      int id = data['id'];
      String time = data['time'];
      int clinicId = data['clinic_id'];
      final clinicResponse = await http
          .get(Utilitaries.getUrl() + 'clinics?id=' + clinicId.toString());
      final clinicDecode = await json.decode(clinicResponse.body);
      var result = clinicDecode[0]['result'];
      if (result == 'error' || result == 'failed') continue;

      var clinicName = clinicDecode[0]['name'];
      int doctorId = data['doctor_id'];
      final doctorResponse = await http.get(
          Utilitaries.getUrl() + 'doctors?doctorId=' + doctorId.toString());
      final doctorDecode = await json.decode(doctorResponse.body);
      result = doctorDecode[0]['result'];
      if (result == 'error' || result == 'failed') continue;

      var doctorName = doctorDecode[0]['name'];
      int specialtyId = data['specialty_id'];
      final specialtyResponse = await http.get(Utilitaries.getUrl() +
          'specialty?specialtyId=' +
          specialtyId.toString());
      final specialtyDecode = await json.decode(specialtyResponse.body);
      result = specialtyDecode[0]['result'];
      if (result == 'error' || result == 'failed') continue;

      var specialtyName = specialtyDecode[0]['name'];
      Appointment appointment = new Appointment(id, time, clinicId, clinicName,
          doctorId, doctorName, specialtyId, specialtyName);
      if (!cacheList.contains(appointment)) {
        cacheList.add(appointment);
      }
    }

    setState(() {
      cacheList.forEach((element) {
        this.appointmentList.add(element);
      });

      cacheList.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    Scaffold scaffold = new Scaffold(
      appBar: Utilitaries.createAppBar(true, 'Consultas agendadas', 25),
      body: ListView(
        children: showAppointments(),
      ),
    );
    return scaffold;
  }

  List<Widget> showAppointments() {
    List<Widget> widgetList = new List<Widget>();
    widgetList.add(Utilitaries.constructSpace(20));
    if (this.appointmentList.length == 0) {
      widgetList.add(
        Container(
          child: Text(
            "Não há consultas agendadas!",
            style: TextStyle(
              fontSize: 25,
            ),
          ),
        ),
      );
      return widgetList;
    }

    this.appointmentList.forEach((appointment) => widgetList.add(create(
        appointment.time,
        appointment.specialtyName,
        appointment.doctorName,
        appointment.clinicName)));
    return widgetList;
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
          Utilitaries.constructSpace(15),
        ],
      ),
    );
  }
}
