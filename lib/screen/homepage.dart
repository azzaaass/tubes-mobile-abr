import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:idlix/style/style.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 250,
                width: mediaQuery.size.width,
                child: Image.network(
                  "https://res.cloudinary.com/upwork-cloud/image/upload/c_scale,w_1000/v1700795880/catalog/1600659718750367744/xiry6ufbjttckqxpfzrw.jpg",
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                padding: EdgeInsets.all(15),
                height: 250,
                width: mediaQuery.size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "IDLIX",
                      style: GoogleFonts.bebasNeue(
                          textStyle: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        color: red,
                      )),
                    ),
                    const FaIcon(
                      FontAwesomeIcons.chromecast,
                      size: 25,
                      color: white,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "Film populer",
              style: GoogleFonts.roboto(
                  textStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500, color: white)),
            ),
          ),
          Container(
            padding:const EdgeInsets.all(10),
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
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisExtent: 160,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  itemBuilder: (context, index) {
                    // return Text(data[index]['name']);
                    return InkWell(
                      onTap: () {},
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
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "Film populer",
              style: GoogleFonts.roboto(
                  textStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500, color: white)),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
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
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisExtent: 160,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  itemBuilder: (context, index) {
                    // return Text(data[index]['name']);
                    return InkWell(
                      onTap: () {},
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
              },
            ),
          ),
        ],
      ),
    );
  }
}
