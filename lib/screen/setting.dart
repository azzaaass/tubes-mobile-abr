import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:idlix/screen/login.dart';
import 'package:idlix/screen/setting_name.dart';
import 'package:idlix/style/style.dart';

class Setting extends StatelessWidget {
  Setting({super.key});
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                navy,
                dark,
              ]),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.angleLeft,
                    size: 20,
                    color: white,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Bantuan & Pengaturan",
                    style: GoogleFonts.roboto(
                        textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: white)),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                height: 1,
                width: MediaQuery.of(context).size.width,
                color: blue.withOpacity(0.3),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return ListTile(
                      minLeadingWidth: 20.0,
                      minVerticalPadding: 0.0,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 4.0),
                      onTap: () {
                        if (index == 0) {
                          Navigator.push(context, CupertinoPageRoute(builder: (context) => SettingName(),));
                        }
                      },
                      leading: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(
                            <IconData>[
                              FontAwesomeIcons.a,
                              FontAwesomeIcons.a,
                              FontAwesomeIcons.a,
                              FontAwesomeIcons.a,
                            ][index],
                            size: 20,
                            color: white,
                          ),
                        ],
                      ),
                      title: Text(
                        <String>[
                          "Pengaturan akun",
                          "Bahasa",
                          "Notifikasi",
                          "Pengawasan orang tua",
                          "Bantuan dan dukungan"
                        ][index],
                        style: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: white)),
                      ),
                      subtitle: Text(
                        <String>[
                          "Detail data pengguna",
                          "Bahasa aplikasi",
                          "Kendali orang tua",
                          "Pusat bantuan"
                        ][index],
                        style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: white.withOpacity(0.5))),
                      ),
                    );
                  },
                ),
              ),
              InkWell(
                onTap: () {
                  auth.signOut();
                  Navigator.pushReplacement(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => Login(),
                      ));
                },
                child: Text(
                  "Logout",
                  style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: blue)),
                ),
              ),
              const SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
