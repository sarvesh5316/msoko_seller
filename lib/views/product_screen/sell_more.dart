// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msoko_seller/auth/login_page.dart';
import 'package:msoko_seller/common/constant.dart';
import 'package:msoko_seller/common/nav_drawer.dart';
import 'package:msoko_seller/common/plain_text.dart';
import 'package:msoko_seller/common/utils.dart';
import 'package:msoko_seller/views/product_screen/product_home_screen.dart';

class SellMoreScreen extends StatefulWidget {
  final String email;
  const SellMoreScreen({super.key, required this.email});

  @override
  State<SellMoreScreen> createState() => _SellMoreScreenState();
}

class _SellMoreScreenState extends State<SellMoreScreen> {
  bool product = false;
  bool property = false;
  bool services = false;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final collection = await FirebaseFirestore.instance
          .collection('users')
          .where('Email', isEqualTo: widget.email)
          .get();

      if (collection.docs.isNotEmpty) {
        final doc = collection.docs.first;
        final userData = doc.data();

        setState(() {
          product = userData['Product'] ?? false;
          property = userData['Property'] ?? false;
          services = userData['Service'] ?? false;
        });

        logger.i("Document ID: ${doc.id}");
        logger.i("User Data: $userData");
        logger.i("Product: $product");
        logger.i("Property: $property");
        logger.i("Services: $services");
      } else {
        logger.i("No documents found in the 'users' collection.");
      }
    } catch (e) {
      Utils().toastMessage("Error fetching data: ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(email: widget.email),
      appBar: AppBar(
        backgroundColor: Color(0xFF08215E),
        title: PlainText(
          name: "Sell More",
          fontsize: 20,
          color: whiteColor,
        ),
        leading: Builder(builder: (BuildContext builderContext) {
          return InkWell(
            onTap: () {
              Scaffold.of(builderContext).openDrawer();
            },
            child: Icon(Icons.menu, color: whiteColor),
          );
        }),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Column(
          children: [
            sellerTypeStack(
                'Sell Your Product',
                'Create your seller account for Products',
                product,
                'assets/images/product.png'),
            sellerTypeStack(
                'Sell Your Property',
                'Create your seller account for Property',
                property,
                'assets/images/property.png'),
            sellerTypeStack(
                'Sell Your Service',
                'Create your seller account for Service',
                services,
                'assets/images/service.png'),
          ],
        ),
      ),
    );
  }

  Widget sellerTypeStack(
      String title, String description, bool status, String image) {
    return GestureDetector(
      onTap: () {
        if (title == 'Sell Your Product') {
          Get.offAll(() => ProductHomeScreen(email: widget.email));
        } else if (title == 'Sell Your Property') {
          Get.offAll(() => ProductHomeScreen(email: widget.email));
        } else if (title == 'Sell Your Services') {
          Get.offAll(() => ProductHomeScreen(email: widget.email));
        } else {
          Get.offAll(() => LoginPage());
        }
      },
      child: Center(
        child: Stack(
          children: [
            Container(
              width: 300.0,
              height: 160.0,
              margin: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: 300.0,
              height: 160.0,
              margin: const EdgeInsets.all(20.0),
              color: status
                  ? Colors.transparent
                  : const Color.fromARGB(209, 0, 0, 0),
            ),
            Positioned(
              top: 10.0,
              left: 20.0,
              child: Container(
                width: 150,
                height: 40,
                color: Colors.green,
                child: Center(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            if (!status)
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.lock,
                        color: Colors.white,
                        size: 30,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        description,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
