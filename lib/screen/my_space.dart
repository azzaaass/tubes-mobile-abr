import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final db = FirebaseFirestore.instance;
  final uid = FirebaseAuth.instance.currentUser?.uid;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
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
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => Setting(),
                        ));
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
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                ImageProfile(),
                const SizedBox(
                  width: 10,
                ),
                UserProfile(),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              height: 1,
              width: MediaQuery.of(context).size.width,
              color: blue.withOpacity(0.3),
            ),
            Row(
              children: [
                StatusLangganan(),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        width: MediaQuery.of(context).size.width / 2.7,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [blue, blue.withAlpha(70)]),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            "Lihat paket",
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: white)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Paket berlangganan mulai dari Rp60.000",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                                fontSize: 11, color: white.withOpacity(0.7))),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class StatusLangganan extends StatelessWidget {
  StatusLangganan({super.key});
  final db = FirebaseFirestore.instance;
  final uid = FirebaseAuth.instance.currentUser?.uid;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      child: StreamBuilder(
          stream: db.collection("userData").doc(uid).snapshots(),
          builder: (context, snapshot) {
            var data = snapshot.data;

            if (data?['status'] != null) {
              return Text(
                "Anda adalah pengguna gratis",
                style: GoogleFonts.roboto(
                    textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: white)),
              );
            } else {
              return Text(
                "Anda sudah berlangganan",
                style: GoogleFonts.roboto(
                    textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: white)),
              );
            }
          }),
    );
  }
}

class UserProfile extends StatelessWidget {
  UserProfile({super.key});
  final db = FirebaseFirestore.instance;
  final uid = FirebaseAuth.instance.currentUser?.uid;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: db.collection("userData").doc(uid).snapshots(),
        builder: (context, snapshot) {
          var data = snapshot.data;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data?['username'] ?? '',
                style: const TextStyle(color: white),
              ),
              Text(
                data?['phone'] ?? '',
                style: const TextStyle(color: white),
              ),
            ],
          );
        });
  }
}

class ImageProfile extends StatelessWidget {
  ImageProfile({super.key});
  final db = FirebaseFirestore.instance;
  final uid = FirebaseAuth.instance.currentUser?.uid;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: db.collection("userData").doc(uid).snapshots(),
        builder: (context, snapshot) {
          var data = snapshot.data;

          print(data?['username'] ?? '');
          return CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(data?['image'] ?? ''),
          );
        });
  }
}
