import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msoko_seller/views/Service%20Section/home_page.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

splashServices() {
  Timer(const Duration(seconds: 2), () {
    Get.offAll(() => const ServiceHomeScreen());
  });
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: const Text("helo world"),
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            Get.to(() => const ServiceHomeScreen());
          },
          child: const Text("Home"),
        ),
      ),
    );
  }
}
