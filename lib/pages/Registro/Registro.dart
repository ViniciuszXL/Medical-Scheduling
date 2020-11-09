import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medical_scheduling/pages/Utilitaries/Utilitaries.dart';

class Registro extends StatefulWidget {
  @override
  _RegistroState createState() => _RegistroState();
}

class _RegistroState extends State<Registro> {
  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;
  String email, name, cpf, senha;
  Color color = Colors.white;

  @override
  Widget build(BuildContext context) {
    Scaffold scaffold = new Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: 55,
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

  Widget formUI() {
    return new Column(
      children: <Widget>[
        Utilitaries.constructLogo(192, 'assets/logo/main.png'),
        Utilitaries.constructSpace(20),
        TextFormField(
          autofocus: true,
          keyboardType: TextInputType.text,
          obscureText: true,
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
          validator: isNome,
          onSaved: (String val) {
            name = val;
          },
          onChanged: (String val) {
            name = val;
          },
          style: TextStyle(fontSize: 20, color: color),
        ),
        Utilitaries.constructSpace(15),
        TextFormField(
          autofocus: true,
          keyboardType: TextInputType.text,
          obscureText: true,
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
          validator: isMail,
          onSaved: (String val) {
            email = val;
          },
          onChanged: (String val) {
            email = val;
          },
          style: TextStyle(fontSize: 20, color: color),
        ),
        Utilitaries.constructSpace(15),
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
          onSaved: (String val) {
            cpf = val;
          },
          onChanged: (String val) {
            cpf = val;
          },
          style: TextStyle(fontSize: 20, color: color),
        ),
        Utilitaries.constructSpace(15),
        TextFormField(
          autofocus: true,
          keyboardType: TextInputType.text,
          obscureText: false,
          enableSuggestions: false,
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
              child: Icon(Icons.perm_identity, color: color),
            ),
          ),
          validator: isSenha,
          onSaved: (String val) {
            senha = val;
          },
          onChanged: (String val) {
            senha = val;
          },
          style: TextStyle(fontSize: 20, color: color),
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
                  Text("Registrar", style: TextStyle(color: Colors.blue, fontSize: 20)),
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
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/homePage');
            },
          ),
        ),
      ],
    );
  }

  String isNome(String value) {
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) return "Informe o nome";
    if (!regExp.hasMatch(value)) return "O nome deve conter caracteres de a-z ou A-Z";
    return null;
  }

  String isMail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) return "Informe o Email";
    if (!regExp.hasMatch(value)) return "Email inválido";
    return null;
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

  void register() {
    if (_key.currentState.validate()) {
      _key.currentState.save();

      // HTTP Request //
    } else {
      setState(() {
        _validate = true;
      });
    }
  }
}
