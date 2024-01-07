import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:idlix/screen/film_detail.dart';
import 'package:idlix/screen/setting.dart';
import 'package:idlix/style/style.dart';
import 'package:image_picker/image_picker.dart';

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
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            const SizedBox(
              height: 20,
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
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              "Riwayat menonton",
              style: GoogleFonts.roboto(
                  textStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500, color: white)),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 200,
              child: StreamBuilder(
                stream: db.collection("film").limit(3).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text("Error"),
                    );
                  }
                  var data = snapshot.data!.docs;
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: data.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisExtent: 160,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                    ),
                    itemBuilder: (context, index) {
                      // return Text(data[index]['name']);
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FilmDetail(
                                    gambar: data[index]['gambar'],
                                    nama: data[index]['nama'],
                                    katergori: data[index]['kategori'],
                                    tahun: data[index]['tahun'],
                                    bahasa: data[index]['bahasa'],
                                    usia: data[index]['usia'],
                                    berlangganan: data[index]['berlangganan'],
                                    deskripsi: data[index]['deskripsi']),
                              ));
                        },
                        child: Container(
                          width: mediaQuery.size.width / 2,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(data[index]['gambar']),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Saran untuk anda",
              style: GoogleFonts.roboto(
                  textStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500, color: white)),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 200,
              child: StreamBuilder(
                stream: db
                    .collection("film")
                    .limit(3)
                    .orderBy("nama", descending: false)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text("Error"),
                    );
                  }
                  var data = snapshot.data!.docs;
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: data.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisExtent: 160,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                    ),
                    itemBuilder: (context, index) {
                      // return Text(data[index]['name']);
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FilmDetail(
                                    gambar: data[index]['gambar'],
                                    nama: data[index]['nama'],
                                    katergori: data[index]['kategori'],
                                    tahun: data[index]['tahun'],
                                    bahasa: data[index]['bahasa'],
                                    usia: data[index]['usia'],
                                    berlangganan: data[index]['berlangganan'],
                                    deskripsi: data[index]['deskripsi']),
                              ));
                        },
                        child: Container(
                          width: mediaQuery.size.width / 2,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(data[index]['gambar']),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
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
                style: GoogleFonts.roboto(
                    textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: white)),
              ),
              Text(
                data?['phone'] ?? '',
                style: GoogleFonts.roboto(
                    textStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: white)),
              ),
            ],
          );
        });
  }
}

class ImageProfile extends StatefulWidget {
  ImageProfile({super.key});

  @override
  State<ImageProfile> createState() => _ImageProfileState();
}

class _ImageProfileState extends State<ImageProfile> {
  final db = FirebaseFirestore.instance;
  final uid = FirebaseAuth.instance.currentUser?.uid;
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

  Future uploadImageToFirebase() async {
    String uid = user?.uid ?? '';
    if (_image != null) {
      Reference ref =
          FirebaseStorage.instance.ref().child('profile_image/$uid');
      UploadTask uploadTask = ref.putFile(_image!);
      TaskSnapshot storageTaskSnapshot =
          await uploadTask.whenComplete(() => null);
      String imageURL = await storageTaskSnapshot.ref.getDownloadURL();
      db.collection("userData").doc(uid).set({
        "image": imageURL,
      }, SetOptions(merge: true));
      print('Image URL: $imageURL');
    } else {
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onDoubleTap: () async {
        await getImage();
        await uploadImageToFirebase();
      },
      child: StreamBuilder(
          stream: db.collection("userData").doc(uid).snapshots(),
          builder: (context, snapshot) {
            var data = snapshot.data;

            print(data?['username'] ?? '');
            return CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(data?['image'] ?? ''),
            );
          }),
    );
  }
}
