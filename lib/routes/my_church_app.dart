import 'package:flutter/material.dart';
import 'package:proyek_akhir/routes/favorite_page.dart';
import 'package:proyek_akhir/routes/home_page.dart';
import 'package:proyek_akhir/routes/profil_page.dart';

class MyChurchApp extends StatefulWidget {
  const MyChurchApp({super.key});

  @override
  State<MyChurchApp> createState() => _MyChurchAppState();
}

class _MyChurchAppState extends State<MyChurchApp> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.amber,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          NavigationDestination(
            icon: Icon(Icons.messenger_sharp),
            label: 'Profile',
          ),
        ],
      ),
      body: <Widget>[
        /// Home page
        const HomePage(),

        /// Favorite page
        const FavoritePage(),

        /// Profil page
        const ProfilPage()
      ][currentPageIndex],
    );
  }
}
