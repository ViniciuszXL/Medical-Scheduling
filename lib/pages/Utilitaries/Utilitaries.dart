import 'package:flutter/material.dart';

class Utilitaries {
  static SizedBox constructSpace(double size) {
    SizedBox box = new SizedBox(height: size);
    return box;
  }

  static SizedBox constructLogo(double widthAndHeight, String src) {
    SizedBox box = new SizedBox(
      width: widthAndHeight,
      height: widthAndHeight,
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
