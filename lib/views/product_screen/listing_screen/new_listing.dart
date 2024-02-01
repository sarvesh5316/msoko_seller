// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msoko_seller/common/constant.dart';
import 'package:msoko_seller/common/plain_text.dart';
import 'package:msoko_seller/common/rounded_button.dart';
import 'package:msoko_seller/views/product_screen/listing_screen/check_categories.dart';

class ListingScreen extends StatefulWidget {
  final String email;

  const ListingScreen({super.key, required this.email});

  @override
  State<ListingScreen> createState() => _ListingScreenState();
}

class _ListingScreenState extends State<ListingScreen> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF08215E),
        title: PlainText(
          name: "Listing",
          fontsize: 20,
          color: whiteColor,
        ),
        leading: InkWell(
          onTap: () {
            // Get.back();
          },
          child: Icon(
            Icons.menu,
            color: whiteColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: h - 90,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: 60,
                width: w,
                color: appColor,
                child: TextFormField(
                  style: TextStyle(color: whiteColor),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search, color: whiteColor),
                    hintText: "Search a Brand, FSN, Product",
                    hintStyle: TextStyle(
                      color: whiteColor,
                      fontWeight: FontWeight.w400,
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: whiteColor),
                    ),
                  ),
                ),
              ),
              hSpacer(10),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Align(
                  alignment: Alignment.topRight,
                  child: PlainText(
                    name: "Clear All",
                    fontsize: 13,
                    color: blueColor,
                  ),
                ),
              ),
              hSpacer(10),
              buildListTile("Bag"),
              buildListTile("Book"),
              buildListTile("Pen"),
              buildListTile("Bottle"),
              Spacer(),
              PlainText(
                name: "OR",
                fontsize: 18,
                fontWeight: FontWeight.w400,
              ),
              hSpacer(10),
              Container(
                height: 50,
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: RoundedButton(
                  title: "Create New Listing",
                  onTap: () {
                    Get.to(() => CheckCategoriesScreen(
                          email: widget.email,
                        ));
                  },
                  radius: 0,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildListTile(String name) {
    return ListTile(
      leading: Icon(Icons.history),
      title: PlainText(
        name: name,
        fontsize: 16,
      ),
      trailing: Icon(Icons.close),
    );
  }
}
