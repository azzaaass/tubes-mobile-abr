import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:idlix/screen/film_detail.dart';
import 'package:idlix/style/style.dart';

import 'dart:developer';

class FilmSearch extends StatefulWidget {
  const FilmSearch({super.key});

  @override
  State<FilmSearch> createState() => _FilmSearchState();
}

class _FilmSearchState extends State<FilmSearch> {
  final db = FirebaseFirestore.instance;
  TextEditingController? searchController = TextEditingController();
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  var searchName = "";
  bool isGrid2 = true;

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 20),
            height: 40,
            decoration: BoxDecoration(
                color: white, borderRadius: BorderRadius.circular(10)),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchName = value;
                });
              },
              controller: searchController,
              // style: text14_6navy,
              decoration: InputDecoration(
                hintText: 'Search',
                border: InputBorder.none,
                prefixIcon: const FaIcon(
                  FontAwesomeIcons.magnifyingGlass,
                  size: 18,
                  color: navy,
                ),
                prefixIconConstraints: const BoxConstraints(
                  minWidth: 35,
                  minHeight: 15,
                ),
                suffixIcon: InkWell(
                  onTap: () => setState(() {
                    isGrid2 = !isGrid2;
                  }),
                  child: FaIcon(
                    isGrid2
                        ? FontAwesomeIcons.gripVertical
                        : FontAwesomeIcons.grip,
                    size: 18,
                    color: navy,
                  ),
                ),
                suffixIconConstraints: const BoxConstraints(
                  minWidth: 35,
                  minHeight: 15,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: StreamBuilder(
                stream: db
                    .collection("film")
                    .where("nama", isGreaterThanOrEqualTo: searchName)
                    .where("nama", isLessThanOrEqualTo: "$searchName\uf7ff")
                    .orderBy("nama", descending: true)
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
                    itemCount: data.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: isGrid2 ? 2 : 3,
                      mainAxisExtent: isGrid2 ? 230.0 : 180,
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
                          height: 150,
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
                }),
          ),
        ],
      ),
    );
  }
}
