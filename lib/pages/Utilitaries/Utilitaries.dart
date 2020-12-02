import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class Utilitaries {
  static String urlApi = 'http://10.0.0.167:9090/';

  static String getUrl() {
    return urlApi;
  }

  static void createAlert(BuildContext context, String title, String content) {
    Widget okButton = FlatButton(
      child: Text('Fechar'),
      onPressed: () => Navigator.of(context, rootNavigator: true).pop('dialog'),
    );

    AlertDialog alerta = AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }

  static bool isError(final jsonDecode) {
    String result = jsonDecode[0]['result'];
    if (result != null && result == 'error') return true;
    return false;
  }

  static String buildRegisterUrl(
      String name, String email, String cpf, String password) {
    String initial = urlApi + 'register?name=' + name;
    initial = initial + '&email=' + email;
    initial = initial + '&cpf=' + cpf;
    initial = initial + '&password=' + password;
    return initial;
  }

  static String buildLoginUrl(String cpf, String password) {
    String initial = urlApi + 'login?cpf=' + cpf;
    initial = initial + '&password=' + password;
    return initial;
  }

  static AppBar createAppBar(bool returns, String title, double fontSize) {
    AppBar appBar = AppBar(
      automaticallyImplyLeading: returns,
      title: Text(
        title,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w700,
          fontStyle: FontStyle.normal,
          color: Colors.white,
        ),
      ),
    );
    return appBar;
  }

  static SizedBox constructSpace(double size) {
    SizedBox box = new SizedBox(height: size);
    return box;
  }

  static SizedBox constructLogo(double width, String src) {
    SizedBox box = new SizedBox(
      width: width,
      child: Image.asset(src),
    );
    return box;
  }

  static OutlineInputBorder createOutline(Color borderColor) {
    OutlineInputBorder outline = new OutlineInputBorder(
      borderSide: BorderSide(
        color: borderColor,
      ),
    );

    return outline;
  }

  static TextFormField createForm(
      bool autoFocus,
      bool obscureText,
      TextInputType type,
      String text,
      String hintText,
      Color color,
      IconData icon) {
    TextFormField form = new TextFormField(
      enableSuggestions: false,
      autofocus: autoFocus,
      keyboardType: type,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: text,
        hintText: hintText,
        hintStyle: TextStyle(color: color),
        labelStyle: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 18,
          decorationColor: color,
        ),
        enabledBorder: createOutline(color),
        focusedBorder: createOutline(color),
        prefixIcon: Padding(
          padding: EdgeInsets.all(0.0),
          child: Icon(icon, color: color),
        ),
      ),
      style: TextStyle(fontSize: 20, color: color),
    );

    return form;
  }
}
