import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:idlix/style/style.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class FilmAdd extends StatefulWidget {
  FilmAdd({super.key});

  @override
  State<FilmAdd> createState() => _FilmAddState();
}

class _FilmAddState extends State<FilmAdd> {
  final db = FirebaseFirestore.instance;
  final uid = FirebaseAuth.instance.currentUser?.uid;
  final email = FirebaseAuth.instance.currentUser?.email;
  TextEditingController nameController = TextEditingController();
  TextEditingController kategoriController = TextEditingController();
  TextEditingController tahunController = TextEditingController();
  TextEditingController bahasaController = TextEditingController();
  TextEditingController usiaController = TextEditingController();
  TextEditingController berlanggananController = TextEditingController();
  TextEditingController deskripsiController = TextEditingController();

  File? _image;
  final picker = ImagePicker();
  User? user = FirebaseAuth.instance.currentUser;
  final storage = FirebaseStorage.instance;

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<String> uploadImageToFirebase(String id) async {
    if (_image != null) {
      Reference ref = FirebaseStorage.instance.ref().child('product/$id');
      UploadTask uploadTask = ref.putFile(_image!);
      TaskSnapshot storageTaskSnapshot =
          await uploadTask.whenComplete(() => null);
      String imageURL = await storageTaskSnapshot.ref.getDownloadURL();
      print('Image URL: $imageURL');
      return imageURL;
    } else {
      print('No image selected.');
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
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
                  const FaIcon(
                    FontAwesomeIcons.angleLeft,
                    size: 20,
                    color: white,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Detail akun",
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
                child: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _image != null
                            ? InkWell(
                                onTap: () => getImage(),
                                child: Image.file(
                                  _image!,
                                  height: 200,
                                  width: 200,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : InkWell(
                                onTap: () => getImage(),
                                child: Text(
                                  'Select image',
                                  style: GoogleFonts.roboto(
                                      textStyle: TextStyle(
                                          fontSize: 13, color: white)),
                                )),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 50,
                          width: mediaQuery.size.width / 1.2,
                          child: TextField(
                              controller: nameController,
                              style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                fontSize: 16,
                                color: white.withOpacity(0.8),
                              )),
                              decoration: input1(text: "Nama")),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 50,
                          width: mediaQuery.size.width / 1.2,
                          child: TextField(
                              controller: kategoriController,
                              style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                fontSize: 16,
                                color: white.withOpacity(0.8),
                              )),
                              decoration: input1(text: "Kategori")),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 50,
                          width: mediaQuery.size.width / 1.2,
                          child: TextField(
                              controller: tahunController,
                              style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                fontSize: 16,
                                color: white.withOpacity(0.8),
                              )),
                              decoration: input1(text: "Tahun")),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 50,
                          width: mediaQuery.size.width / 1.2,
                          child: TextField(
                              controller: bahasaController,
                              style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                fontSize: 16,
                                color: white.withOpacity(0.8),
                              )),
                              decoration: input1(text: "Bahasa")),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 50,
                          width: mediaQuery.size.width / 1.2,
                          child: TextField(
                              controller: usiaController,
                              style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                fontSize: 16,
                                color: white.withOpacity(0.8),
                              )),
                              decoration: input1(text: "Usia")),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 50,
                          width: mediaQuery.size.width / 1.2,
                          child: TextField(
                              controller: berlanggananController,
                              style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                fontSize: 16,
                                color: white.withOpacity(0.8),
                              )),
                              decoration: input1(text: "Berlangganan")),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 50,
                          width: mediaQuery.size.width / 1.2,
                          child: TextField(
                              controller: deskripsiController,
                              style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                fontSize: 16,
                                color: white.withOpacity(0.8),
                              )),
                              decoration: input1(text: "Deskripsi")),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () async {
                            String filmId = const Uuid().v4();
                            if (true) {
                              String url = await uploadImageToFirebase(filmId);
                              final db = FirebaseFirestore.instance;
                              db.collection("film").doc(filmId).set({
                                "gambar": url,
                                "nama": nameController.text,
                                "kategori": kategoriController.text,
                                "tahun": tahunController.text,
                                "bahasa": bahasaController.text,
                                "usia": usiaController.text,
                                "berlangganan": berlanggananController.text,
                                "deskripsi": deskripsiController.text,
                              });
                              Navigator.pop(context);
                            }
                          },
                          child: Container(
                            height: 50,
                            width: mediaQuery.size.width / 1.2,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [blue, blue.withAlpha(70)]),
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text(
                                "Simpan",
                                style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: white)),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
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
