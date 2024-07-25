import 'package:flutter/material.dart';
import 'package:myshop/auth/login.dart';
import 'package:myshop/auth/register.dart';
import 'package:myshop/screen/bottombar/homepage/category_page.dart';
import 'package:myshop/screen/bottombar/homepage/product_view_page.dart';
import 'package:myshop/screen/bottombar/profile/personal_info.dart';
import 'package:myshop/screen/dashboard.dart';
import 'package:myshop/service/provider.dart';
import 'package:provider/provider.dart';

void main() {
  MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],
      child: const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        dialogBackgroundColor: const Color.fromARGB(255, 134, 67, 241),
      ),
      initialRoute: '/loginpage',
      routes: {
        '/loginpage': (context) => const LogInPage(),
        '/registerpage': (context) => const Register(),
        '/DashBoard': (context) => const DashBoard(),
        '/productviewpage': (context) => const ProductViewPage(),
        '/personalinfopage':(context) =>  const PersonalInfoPage(),
        '/categorypage':(context) => const CategoryPage(),
      },
    );
  }
}
