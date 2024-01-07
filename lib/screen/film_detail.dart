import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:idlix/style/style.dart';

class FilmDetail extends StatefulWidget {
  final String gambar;
  final String nama;
  final String katergori;
  final String tahun;
  final String bahasa;
  final String usia;
  final String berlangganan;
  final String deskripsi;
  FilmDetail(
      {super.key,
      required this.gambar,
      required this.nama,
      required this.katergori,
      required this.tahun,
      required this.bahasa,
      required this.usia,
      required this.berlangganan,
      required this.deskripsi});

  @override
  State<FilmDetail> createState() => _FilmDetailState();
}

class _FilmDetailState extends State<FilmDetail> {
  final db = FirebaseFirestore.instance;
  final uid = FirebaseAuth.instance.currentUser?.uid;

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: Container(
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: mediaQuery.size.height / 2,
                    width: mediaQuery.size.width,
                    child: Image.network(
                      widget.gambar,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 20.0),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          child: const FaIcon(
                            FontAwesomeIcons.arrowLeft,
                            size: 20,
                            color: white,
                          ),
                        ),
                        const Spacer(),
                        StreamBuilder(
                            stream:
                                db.collection("userData").doc(uid).snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              if (snapshot.hasError) {
                                return const Center(
                                  child: Text("Error"),
                                );
                              }
                              var data = snapshot.data!.data();
                              if (data?['role'] == "admin") {
                                return const Row(
                                  children: [
                                    InkWell(
                                        child: FaIcon(
                                      FontAwesomeIcons.solidPenToSquare,
                                      size: 18,
                                      color: white,
                                    )),
                                  ],
                                );
                              } else {
                                return const SizedBox();
                              }
                            }),
                        const SizedBox(
                          width: 15,
                        ),
                        const FaIcon(
                          FontAwesomeIcons.solidShareFromSquare,
                          size: 18,
                          color: white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.tahun,
                              style: GoogleFonts.roboto(
                                  textStyle: const TextStyle(
                                      fontSize: 13, color: white)),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              widget.bahasa,
                              style: GoogleFonts.roboto(
                                  textStyle: const TextStyle(
                                      fontSize: 13, color: white)),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              widget.usia,
                              style: GoogleFonts.roboto(
                                  textStyle: const TextStyle(
                                      fontSize: 13, color: white)),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          height: 40,
                          width: mediaQuery.size.width,
                          decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text(
                              widget.usia,
                              style: GoogleFonts.roboto(
                                  textStyle: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: navy)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.katergori,
                          style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: white)),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          widget.deskripsi,
                          style: GoogleFonts.roboto(
                              textStyle:
                                  const TextStyle(fontSize: 13, color: white)),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
