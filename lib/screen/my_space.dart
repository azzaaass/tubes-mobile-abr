import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:idlix/screen/setting.dart';
import 'package:idlix/style/style.dart';

class MySpace extends StatefulWidget {
  const MySpace({super.key});

  @override
  State<MySpace> createState() => _MySpaceState();
}

class _MySpaceState extends State<MySpace> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "IDLIX",
                style: GoogleFonts.bebasNeue(
                    textStyle: const TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.w600,
                  color: red,
                )),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context, CupertinoPageRoute(builder: (context) => Setting(),));
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.settings_outlined,
                      color: white,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      "Bantuan & Pengaturan",
                      style: GoogleFonts.roboto(
                          textStyle: TextStyle(fontSize: 13, color: white)),
                    )
                  ],
                ),
              ),
            ],
          ),
          StreamBuilder(
            stream: null,
            builder: (context, snapshot) {
              return Row(
                children: [
                  
                  Text(
                    "Anda adalah pengguna gratis",
                  )
                ],
              );
            }
          )
        ],
      ),
    );
  }
}
