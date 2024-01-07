import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color dark = Color(0xFF0f1014);
const Color white = Color(0xFFffffff);
const Color red = Color(0xFFe6111a);
const Color blue = Color(0xFF4f8ad0);
const Color navy = Color.fromARGB(255, 3, 27, 68);


InputDecoration input1({required String text}) {
  return InputDecoration(
    label: Text(text),
    labelStyle: GoogleFonts.roboto(
        textStyle: TextStyle(
      fontSize: 16,
      color: white.withOpacity(0.5),
    )),
    floatingLabelStyle: GoogleFonts.roboto(
        textStyle: TextStyle(
      fontSize: 16,
      color: white.withOpacity(0.5),
    )),
    floatingLabelBehavior: FloatingLabelBehavior.auto,
    hintText: "Masukan ${text.toLowerCase()}",
    hintStyle: GoogleFonts.roboto(
        textStyle: TextStyle(
      fontSize: 16,
      color: white.withOpacity(0.3),
    )),
    contentPadding: const EdgeInsets.only(left: 15),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: white.withOpacity(0.5))),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: white.withOpacity(0.5))),
  );
}
