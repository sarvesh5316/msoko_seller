// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:msoko_seller/common/constant.dart';
import 'package:msoko_seller/common/plain_text.dart';
import 'package:msoko_seller/common/reusabletextformfield.dart';
import 'package:msoko_seller/common/rounded_button.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  TextEditingController skuController = TextEditingController();
  bool isActiveSelected = false;
  bool isInactiveSelected = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 40, left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildHeading("Listing info"),
            hSpacer(10),
            buildRichHeading("Seller SKU ID "),
            hSpacer(10),
            SizedBox(
              height: 45,
              child: ReusableTextFormField(
                controller: skuController,
                hintText: "",
              ),
            ),
            hSpacer(10),
            buildHeading("Status Details"),
            hSpacer(10),
            buildRichHeading("Listing Status "),
            hSpacer(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 150,
                  child: RoundedButton(
                    title: "Active",
                    onTap: () {
                      setState(() {
                        isActiveSelected = true;
                        isInactiveSelected = false;
                      });
                    },
                    radius: 0,
                    borderColor: greyColor,
                    textColor: isInactiveSelected ? greyColor : whiteColor,
                    buttonColor: isActiveSelected ? blueColor : whiteColor,
                  ),
                ),
                SizedBox(
                  width: 150,
                  child: RoundedButton(
                    title: "Inactive",
                    onTap: () {
                      setState(() {
                        isActiveSelected = false;
                        isInactiveSelected = true;
                      });
                    },
                    radius: 0,
                    borderColor: greyColor,
                    textColor: isActiveSelected ? greyColor : whiteColor,
                    buttonColor: isInactiveSelected ? blueColor : whiteColor,
                  ),
                ),
              ],
            ),
            hSpacer(10),
            buildHeading("Price Details"),
            hSpacer(10),
            buildRichHeading("MRP "),
            hSpacer(10),
            SizedBox(
              height: 45,
              child: ReusableTextFormField(
                controller: skuController,
                hintText: "",
              ),
            ),
            hSpacer(10),
            buildRichHeading("Your Selling Price "),
            hSpacer(10),
            SizedBox(
              height: 45,
              child: ReusableTextFormField(
                controller: skuController,
                hintText: "",
              ),
            ),
            hSpacer(10),
            buildHeading("Stock Details"),
            hSpacer(10),
            buildRichHeading("Stock "),
            hSpacer(10),
            SizedBox(
              height: 45,
              child: ReusableTextFormField(
                controller: skuController,
                hintText: "Add Numbers of Stocks",
              ),
            ),
            hSpacer(10),
            buildRichHeading("Stock available for buyers "),
            hSpacer(10),
            SizedBox(
              height: 45,
              child: ReusableTextFormField(
                controller: skuController,
                hintText: "Add number of stocks available",
              ),
            ),
            hSpacer(10),
            buildHeading("Delivery Charge Details"),
            hSpacer(10),
            buildRichHeading("Delivery Charge to customer(Local)"),
            hSpacer(10),
            SizedBox(
              height: 45,
              child: ReusableTextFormField(
                controller: skuController,
                hintText: "Price",
              ),
            ),
            hSpacer(10),
            buildRichHeading("Delivery Charge to customer(Zonal)"),
            hSpacer(10),
            SizedBox(
              height: 45,
              child: ReusableTextFormField(
                controller: skuController,
                hintText: "Price",
              ),
            ),
            hSpacer(10),
            buildRichHeading("Delivery Charge to customer(National)"),
            hSpacer(10),
            SizedBox(
              height: 45,
              child: ReusableTextFormField(
                controller: skuController,
                hintText: "Price",
              ),
            ),
            hSpacer(10),
            buildHeading("Packaging Details"),
            hSpacer(10),
            buildRichHeading("Package weight(KG)"),
            hSpacer(10),
            SizedBox(
              height: 45,
              child: ReusableTextFormField(
                controller: skuController,
                hintText: "",
              ),
            ),
            hSpacer(10),
            buildRichHeading("Package Length(CM)"),
            hSpacer(10),
            SizedBox(
              height: 45,
              child: ReusableTextFormField(
                controller: skuController,
                hintText: "",
              ),
            ),
            hSpacer(10),
            buildHeading("Tax Details"),
            hSpacer(10),
            buildRichHeading("HSN"),
            hSpacer(10),
            SizedBox(
              height: 45,
              child: ReusableTextFormField(
                controller: skuController,
                hintText: "",
              ),
            ),
            hSpacer(10),
            buildRichHeading("Tax Code"),
            hSpacer(10),
            SizedBox(
              height: 45,
              child: ReusableTextFormField(
                controller: skuController,
                hintText: "",
              ),
            ),
            hSpacer(10),
            buildHeading("Manufacturing Details"),
            hSpacer(10),
            buildRichHeading("Country Origin"),
            hSpacer(10),
            SizedBox(
              height: 45,
              child: ReusableTextFormField(
                controller: skuController,
                hintText: "",
              ),
            ),
            hSpacer(10),
            buildRichHeading("Manufacture Details"),
            hSpacer(10),
            SizedBox(
              height: 45,
              child: ReusableTextFormField(
                controller: skuController,
                hintText: "",
              ),
            ),
            hSpacer(10),
            buildRichHeading("Packer Details"),
            hSpacer(10),
            SizedBox(
              height: 45,
              child: ReusableTextFormField(
                controller: skuController,
                hintText: "",
              ),
            ),
            hSpacer(10),
            buildRichHeading("Importer Details"),
            hSpacer(10),
            SizedBox(
              height: 45,
              child: ReusableTextFormField(
                controller: skuController,
                hintText: "",
              ),
            ),
            hSpacer(10),
            buildRichHeading("Title"),
            hSpacer(10),
            SizedBox(
              height: 45,
              child: ReusableTextFormField(
                controller: skuController,
                hintText: "",
              ),
            ),
            hSpacer(10),
            buildHeading("In the box"),
            hSpacer(10),
            buildRichHeading("Sales Package"),
            hSpacer(10),
            SizedBox(
              height: 45,
              child: ReusableTextFormField(
                controller: skuController,
                hintText: "",
              ),
            ),
            hSpacer(10),
            buildHeading("Key Word"),
            hSpacer(10),
            buildRichHeading("Add Keywords"),
            hSpacer(10),
            SizedBox(
              height: 45,
              child: ReusableTextFormField(
                controller: skuController,
                hintText: "",
              ),
            ),
            hSpacer(20),
            RoundedButton(
              title: "Send to QC",
              onTap: () {},
              radius: 0,
            )
          ],
        ),
      ),
    ));
  }

  Widget buildHeading(String title) {
    return PlainText(
      name: title,
      fontsize: 16,
      color: greyColor,
    );
  }

  Widget buildRichHeading(
    String title,
  ) {
    return RichText(
      text: TextSpan(
        text: title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: blackColor,
        ),
        children: [
          TextSpan(
            text: "*",
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
