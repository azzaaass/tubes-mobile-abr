import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:idlix/auth_service.dart';
import 'package:idlix/screen/home.dart';
import 'package:idlix/screen/register.dart';
import 'package:idlix/style/style.dart';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: dark,
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 30,
          horizontal: 20,
        ),
        width: mediaQuery.size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                opacity: 0.8,
                image: AssetImage("assets/images/login.png"),
                fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "IDLIX",
              style: GoogleFonts.bebasNeue(
                  textStyle: const TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.w600,
                color: red,
              )),
            ),
            const SizedBox(
              height: 25,
            ),
            Text(
              "Masuk atau daftar untuk melanjutkan",
              style: GoogleFonts.roboto(
                  textStyle: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w600, color: white)),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 50,
              width: mediaQuery.size.width,
              child: TextField(
                  controller: emailController,
                  style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                    fontSize: 16,
                    color: white.withOpacity(0.8),
                  )),
                  decoration: input1(text: "Email")),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 50,
              width: mediaQuery.size.width,
              child: TextField(
                  controller: passwordController,
                  onSubmitted: (value) async {
                    final message = await AuthService().login(
                      email: emailController.text,
                      password: passwordController.text,
                    );
                    if (message == 'Login Success') {
                      // Navigasi ke halaman setelah login berhasil
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Home(),
                          ));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(message ?? 'An error occurred'),
                        ),
                      );
                    }
                  },
                  obscureText: !isVisible,
                  style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                    fontSize: 16,
                    color: white.withOpacity(0.8),
                  )),
                  decoration: InputDecoration(
                    label: Text("Password"),
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
                    hintText: "Masukan password",
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
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isVisible = !isVisible;
                          });
                        },
                        icon: FaIcon(
                          isVisible
                              ? FontAwesomeIcons.eye
                              : FontAwesomeIcons.eyeSlash,
                          size: 15,
                          color: white.withOpacity(0.5),
                        )),
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  "Belum memiliki akun?",
                  style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                          fontSize: 13, color: white.withOpacity(0.7))),
                ),
                InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Register(),
                      )),
                  child: Text(
                    " Daftar",
                    style: GoogleFonts.roboto(
                        textStyle: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: blue)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
