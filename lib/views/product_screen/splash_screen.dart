// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msoko_seller/auth/login_page.dart';
import 'package:msoko_seller/common/constant.dart';
import 'package:msoko_seller/views/product_screen/product_home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

// splashServices() {
//   Timer(Duration(seconds: 2), () {
//     Get.offAll(() => LoginPage());
//   });
// }

class _SplashScreenState extends State<SplashScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  late String email = auth.currentUser!.email.toString();
  @override
  void initState() {
    super.initState();
    if (auth.currentUser != null) {
      Timer(Duration(seconds: 3), () {
        Get.offAll(() => ProductHomeScreen(email: email));
      });
    } else {
      Timer(Duration(seconds: 3), () {
        Get.offAll(() => LoginPage());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColor,
      body: Center(child: Image.asset("assets/images/logo.png")),
    );
  }
}
