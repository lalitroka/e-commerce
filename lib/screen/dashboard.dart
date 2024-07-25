import 'package:flutter/material.dart';
import 'package:myshop/screen/bottombar/profile/profile_page.dart';
import 'package:myshop/screen/bottombar/homepage/homepage.dart';
import 'package:myshop/screen/bottombar/savefile/saved_page.dart';
import 'package:myshop/screen/bottombar/shop/shop_page.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _HomePageState();
}

class _HomePageState extends State<DashBoard> {
  int index = 0;
  List pages = [
    const Homepage(),
    const ShopPage(),
    const SavedPage(),
    const ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedIconTheme: const IconThemeData(size: 30),
          currentIndex: index,
          selectedItemColor: Colors.black,
          onTap: (value) {
            setState(() {
              index = value;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_bag), label: 'Shop'),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: 'favorite'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_2), label: 'Account'),
          ]),
    );
  }
}
