import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../Utilitaries/Utilitaries.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Scaffold scaffold = new Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: 90,
          left: 40,
          right: 40,
        ),
        color: Colors.blue,
        child: ListView(
          children: <Widget>[
            Utilitaries.constructLogo(96, 'assets/logo/main.png'),
            Utilitaries.constructSpace(40),
            Utilitaries.createForm(true, false, TextInputType.number, "CPF",
                "Insira seu CPF", Colors.white, Icons.perm_identity),
            Utilitaries.constructSpace(15),
            Utilitaries.createForm(true, true, TextInputType.text, "Senha",
                "Informe sua senha", Colors.white, Icons.shield),
            Container(
              height: 40,
              width: 50,
              alignment: Alignment.topRight,
              child: FlatButton(
                child: Text(
                  "Recuperar Senha",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onPressed: () => {},
              ),
            ),
            Utilitaries.constructSpace(20),
            Container(
              height: 60,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(4.0),
                ),
              ),
              child: SizedBox.expand(
                child: FlatButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Entrar",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                        ),
                      ),
                      Icon(
                        Icons.account_box,
                        color: Colors.blue,
                        size: 30,
                      ),
                    ],
                  ),
                  onPressed: () => {},
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 40,
              child: FlatButton(
                child: Text(
                  "Não possui uma conta? Cadastre-se!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onPressed: () => {},
              ),
            ),
          ],
        ),
      ),
    );
    return scaffold;
  }
}
