import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

// Utilitaries //
import 'package:medical_scheduling/pages/Utilitaries/Utilitaries.dart';
import 'dart:convert';

class LoginResult {
  final String result;
  final String message;
  final bool isSuccess;

  LoginResult({this.result, this.message, this.isSuccess});

  factory LoginResult.fromJson(Map<String, dynamic> json) {
    return LoginResult(
        result: json['result'],
        message: json['message'],
        isSuccess: json['result'] == 'error' ? false : true);
  }
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> _key = new GlobalKey();
  LoginResult result;
  bool _validate = false;
  String cpf, senha;
  Color color = Colors.white;

  @override
  Widget build(BuildContext context) {
    Scaffold scaffold = new Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: 50,
          left: 40,
          right: 40,
        ),
        color: Colors.blue,
        child: Form(
          key: _key,
          autovalidate: _validate,
          child: formUI(),
        ),
      ),
      resizeToAvoidBottomPadding: false,
    );
    return scaffold;
  }

  Widget showNotification() {
    if (result == null) return Utilitaries.constructSpace(30);

    return Container(
      height: 50,
      margin: EdgeInsets.only(top: 10, bottom: 25),
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
        Utilitaries.constructLogo(160, 'assets/logo/main.png'),
        showNotification(),
        TextFormField(
          autofocus: true,
          keyboardType: TextInputType.number,
          obscureText: false,
          enableSuggestions: false,
          maxLength: 11,
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
          validator: isCPF,
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
          maxLength: 16,
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
              child: Icon(Icons.shield, color: color),
            ),
          ),
          validator: isSenha,
          onChanged: (String val) {
            senha = val;
            if (result != null) setState(() => result = null);
          },
          style: TextStyle(fontSize: 20, color: color),
        ),
        Container(
          height: 40,
          alignment: Alignment.bottomRight,
          child: FlatButton(
            child: Text(
              "Recuperar Senha",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
            onPressed: () => {},
          ),
        ),
        Utilitaries.constructSpace(10),
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
                  Text("Entrar",
                      style: TextStyle(color: Colors.blue, fontSize: 20)),
                  Icon(Icons.account_box, color: Colors.blue, size: 30),
                ],
              ),
              onPressed: sendForm,
            ),
          ),
        ),
        Utilitaries.constructSpace(10),
        Container(
          height: 40,
          child: FlatButton(
            child: Text(
              "Não possui uma conta? Cadastre-se!",
              textAlign: TextAlign.center,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/registerPage');
            },
          ),
        ),
      ],
    );
  }

  String isCPF(String value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) return 'Informe seu CPF';
    if (value.length != 11) return 'O CPF deve conter 11 números';
    if (!regExp.hasMatch(value)) return 'O CPF só deve conter números';
    return null;
  }

  String isSenha(String value) {
    if (value.length == 0) return 'Informe sua senha';
    if (value.length > 16) return 'Sua senha é maior que 16 caracteres!';
    if (value.length < 5) return 'Sua senha é menor que 5 caracteres!';
    return null;
  }

  void sendForm() async {
    if (!_key.currentState.validate()) {
      setState(() => _validate = true);
      return;
    }

    _key.currentState.save();

    String url = Utilitaries.buildLoginUrl(cpf, senha);
    final response = await http.get(url);
    final jsonDecode = await json.decode(response.body);
    setState(() => result = LoginResult.fromJson(jsonDecode));

    if (result.isSuccess)
      Timer.periodic(new Duration(seconds: 3),
          (timer) => {Navigator.pushNamed(context, '/home'), timer.cancel()});
  }
}
