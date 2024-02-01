// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msoko_seller/common/constant.dart';
import 'package:msoko_seller/common/plain_text.dart';
import 'package:msoko_seller/common/reusabletextformfield.dart';
import 'package:msoko_seller/common/rounded_button.dart';
import 'package:msoko_seller/views/product_screen/listing_screen/create_new_listing.dart';

class CheckBrandListing extends StatefulWidget {
  final String email;

  const CheckBrandListing({super.key, required this.email});

  @override
  State<CheckBrandListing> createState() => _CheckBrandListingState();
}

class _CheckBrandListingState extends State<CheckBrandListing> {
  TextEditingController brandController = TextEditingController();
  bool isTapped = false;
  String title = "";
  @override
  Widget build(BuildContext context) {
    // var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF08215E),
        title: PlainText(
          name: "New Listing",
          fontsize: 20,
          color: whiteColor,
        ),
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios_new,
            size: 20,
            color: whiteColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: h - 100,
          padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PlainText(
                name: "Check for the brand you want to sell",
                fontsize: 16,
                fontWeight: FontWeight.w500,
              ),
              hSpacer(10),
              SizedBox(
                height: 55,
                child: ReusableTextFormField(
                  // labelText: "Enter Brand Name",
                  hintText: "Enter Brand Name",
                  hintTextColor: greyColor,

                  controller: brandController,
                ),
              ),
              hSpacer(40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: isTapped
                    ? Container(
                        padding: EdgeInsets.all(10),
                        decoration:
                            BoxDecoration(color: greenColor.withOpacity(0.1)),
                        child: PlainText(
                          name: 'You can start selling under this brand.',
                          color: greenColor,
                          fontsize: 14,
                        ),
                      )
                    : null,
              ),
              Spacer(),
              SizedBox(
                height: 55,
                child: RoundedButton(
                  title: isTapped ? "Confirm and Next" : "Check Brand",
                  onTap: () {
                    if (brandController.text != "") {
                      setState(() {
                        isTapped = !isTapped;
                        title = "Confirm and Next";
                      });
                    } else {
                      setState(() {
                        isTapped = false;
                      });
                    }
                    if (title == "Confirm and Next") {
                      Timer(
                        Duration(seconds: 2),
                        () {
                          Get.to(() => CreateNewListing(
                                email: widget.email,
                              ));
                        },
                      );
                    }
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
}
