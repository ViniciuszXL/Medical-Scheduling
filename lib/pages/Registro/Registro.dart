import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

// Utilitaries //
import 'package:medical_scheduling/pages/Utilitaries/Utilitaries.dart';
import 'dart:convert';

class RegistroResult {
  final String result;
  final String message;
  final bool isSuccess;

  RegistroResult({this.result, this.message, this.isSuccess});

  factory RegistroResult.fromJson(Map<String, dynamic> json) {
    return RegistroResult(
        result: json['result'],
        message: json['message'],
        isSuccess: json['result'] == 'error' ? false : true);
  }
}

class Registro extends StatefulWidget {
  @override
  _RegistroState createState() => _RegistroState();
}

class _RegistroState extends State<Registro> {
  RegistroResult result;
  String email, name, cpf, senha;
  Color color = Colors.white;

  @override
  Widget build(BuildContext context) {
    Scaffold scaffold = new Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: 25,
          left: 40,
          right: 40,
        ),
        color: Colors.blue,
        child: ListView(
          children: [
            Container(
              child: formUI(),
            ),
          ],
        ),
      ),
      resizeToAvoidBottomPadding: false,
    );
    return scaffold;
  }

  Widget showNotification() {
    if (result == null) return Utilitaries.constructSpace(20);

    return Container(
      height: 50,
      margin: EdgeInsets.only(top: 10, bottom: 20),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: result.isSuccess ? Colors.green : Colors.red,
        borderRadius: BorderRadius.circular(7.0),
      ),
      child: Text(
        result.message,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
      ),
    );
  }

  Widget formUI() {
    return new Column(
      children: <Widget>[
        Utilitaries.constructLogo(128, 'assets/logo/main.png'),
        showNotification(),
        TextFormField(
          autofocus: true,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: 'Nome',
            hintText: 'Informe seu nome',
            hintStyle: TextStyle(color: color),
            labelStyle: TextStyle(
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: 18,
              decorationColor: Colors.white,
            ),
            enabledBorder: Utilitaries.createOutline(color),
            focusedBorder: Utilitaries.createOutline(color),
            prefixIcon: Padding(
              padding: EdgeInsets.all(0.0),
              child: Icon(Icons.account_box_rounded, color: color),
            ),
          ),
          onChanged: (String val) {
            name = val;
            if (result != null) setState(() => result = null);
          },
          style: TextStyle(fontSize: 20, color: color),
        ),
        Utilitaries.constructSpace(15),
        TextFormField(
          autofocus: true,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: 'E-mail',
            hintText: 'Informe seu e-mail',
            hintStyle: TextStyle(color: color),
            labelStyle: TextStyle(
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: 18,
              decorationColor: Colors.white,
            ),
            enabledBorder: Utilitaries.createOutline(color),
            focusedBorder: Utilitaries.createOutline(color),
            prefixIcon: Padding(
              padding: EdgeInsets.all(0.0),
              child: Icon(Icons.mail, color: color),
            ),
          ),
          onChanged: (String val) {
            email = val;
            if (result != null) setState(() => result = null);
          },
          style: TextStyle(fontSize: 20, color: color),
        ),
        Utilitaries.constructSpace(15),
        TextFormField(
          autofocus: true,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'CPF',
            hintText: 'Informe seu CPF',
            hintStyle: TextStyle(color: color),
            labelStyle: TextStyle(
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: 18,
              decorationColor: Colors.white,
            ),
            enabledBorder: Utilitaries.createOutline(color),
            focusedBorder: Utilitaries.createOutline(color),
            prefixIcon: Padding(
              padding: EdgeInsets.all(0.0),
              child: Icon(Icons.perm_identity, color: color),
            ),
          ),
          onChanged: (String val) {
            cpf = val;
            if (result != null) setState(() => result = null);
          },
          style: TextStyle(fontSize: 20, color: color),
        ),
        Utilitaries.constructSpace(15),
        TextFormField(
          autofocus: true,
          keyboardType: TextInputType.text,
          obscureText: true,
          enableSuggestions: false,
          decoration: InputDecoration(
            labelText: 'Senha',
            hintText: 'Informe sua senha',
            hintStyle: TextStyle(color: color),
            labelStyle: TextStyle(
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: 18,
              decorationColor: Colors.white,
            ),
            enabledBorder: Utilitaries.createOutline(color),
            focusedBorder: Utilitaries.createOutline(color),
            prefixIcon: Padding(
              padding: EdgeInsets.all(0.0),
              child: Icon(Icons.perm_identity, color: color),
            ),
          ),
          onChanged: (String val) {
            senha = val;
            if (result != null) setState(() => result = null);
          },
          style: TextStyle(fontSize: 20, color: color),
        ),
        Utilitaries.constructSpace(25),
        Container(
          height: 60,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
          child: SizedBox.expand(
            child: FlatButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Registrar",
                      style: TextStyle(color: Colors.blue, fontSize: 20)),
                  Icon(Icons.account_box, color: Colors.blue, size: 30),
                ],
              ),
              onPressed: register,
            ),
          ),
        ),
        Utilitaries.constructSpace(10),
        Container(
          height: 40,
          child: FlatButton(
            child: Text(
              "Você já possui uma conta? Logue-se!",
              textAlign: TextAlign.center,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/homePage');
            },
          ),
        ),
      ],
    );
  }

  String isName(String value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern,
        caseSensitive: true, unicode: true, multiLine: true);
    if (value == null || value.length == 0) return "Informe seu nome!";
    if (regExp.hasMatch(value))
      return "Nome informado está inválido! Só deve conter caracteres a-z ou A-Z";
    return null;
  }

  String isMail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value == null || value.length == 0) return "Informe seu e-mail!";
    if (!regExp.hasMatch(value)) return "E-mail informado é inválido!";
    return null;
  }

  String isCPF(String value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value == null || value.length == 0) return 'Informe seu CPF!';
    if (value.length != 11) return 'CPF deve conter 11 números!';
    if (!regExp.hasMatch(value)) return 'CPF só deve conter números!';
    return null;
  }

  String isSenha(String value) {
    if (value == null || value.length == 0) return 'Informe sua senha!';
    if (value.length > 16) return 'Sua senha é maior que 16 caracteres!';
    if (value.length < 5) return 'Sua senha é menor que 5 caracteres!';
    return null;
  }

  void register() async {
    String valName = isName(name);
    if (valName != null)
      return setState(() => result = new RegistroResult(
          result: 'error', message: valName, isSuccess: false));

    String valEmail = isMail(email);
    if (valEmail != null)
      return setState(() => result = new RegistroResult(
          result: 'error', message: valEmail, isSuccess: false));

    print(cpf);
    String valCPF = isCPF(cpf);
    if (valCPF != null)
      return setState(() => result = new RegistroResult(
          result: 'error', message: valCPF, isSuccess: false));

    String valSenha = isSenha(senha);
    if (valSenha != null)
      return setState(() => result = new RegistroResult(
          result: 'error', message: valSenha, isSuccess: false));

    String url = Utilitaries.buildRegisterUrl(name, email, cpf, senha);
    print(url);
    final response = await http.put(url);
    final jsonDecode = await json.decode(response.body);
    result = RegistroResult.fromJson(jsonDecode);
    if (!result.isSuccess) return setState(() => result = result);

    setState(() => result = new RegistroResult(
        result: 'success',
        message: 'Cadastro realizado com sucesso!',
        isSuccess: true));
    Timer.periodic(new Duration(seconds: 5),
        (timer) => {Navigator.pushNamed(context, '/homePage'), timer.cancel()});
  }
}
