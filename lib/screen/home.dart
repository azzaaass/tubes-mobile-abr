import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:idlix/screen/film_search.dart';
import 'package:idlix/screen/homepage.dart';
import 'package:idlix/screen/my_space.dart';
import 'package:idlix/style/style.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;
  final List<Widget> page = [
    const Homepage(),
    const FilmSearch(),
    const MySpace(),
  ];

  final List<BottomNavigationBarItem> item = [
    const BottomNavigationBarItem(
      icon: Padding(
        padding: EdgeInsets.all(5.0),
        child: FaIcon(FontAwesomeIcons.house),
      ),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Padding(
        padding: EdgeInsets.all(5.0),
        child: FaIcon(FontAwesomeIcons.magnifyingGlass),
      ),
      label: 'Search',
    ),
    const BottomNavigationBarItem(
      icon: Padding(
        padding: EdgeInsets.all(5.0),
        child: FaIcon(FontAwesomeIcons.earthAsia),
      ),
      label: 'My space',
    )
  ];

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
          navy,
          dark,
        ])
      ),
        child: SafeArea(
          child: page[selectedIndex],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: item,
        type: BottomNavigationBarType.fixed,
        backgroundColor: dark,
        currentIndex: selectedIndex,
        unselectedItemColor: white.withOpacity(0.3),
        selectedItemColor: white,
        showUnselectedLabels: true,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        iconSize: 18,
        onTap: _onItemTapped,
      ),
    );
  }
}
