import'package:flutter/material.dart';
import'package:msoko_seller/common/plain_text.dart';
import 'package:msoko_seller/common/constant.dart';
import 'package:get/get.dart';
class Sell_More extends StatefulWidget {
  const Sell_More({super.key});

  @override
  State<Sell_More> createState() => _Sell_MoreState();
}

class _Sell_MoreState extends State<Sell_More> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF08215E),
        title: PlainText(
          name: "Sell More",
          fontsize: 20,
          color: whiteColor,
        ),
        leading: InkWell(
          onTap: () {
             Get.back();
          },
          child: Icon(
            Icons.menu,
            color: whiteColor,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Column(
          children: [
            categoryService(
                "assets/images/product.png", "Sell Your Products", () {}),
            categoryService(
                "assets/images/property.png", "Sell Your Property", () {}),
            categoryService("assets/images/service.png", "Sell Your Services",
                    () {
                //  Get.to(() => FilterScreen());
                }),
          ],
        ),
      ),
    );
  }

  Widget categoryService(
      String imageData, String heading, VoidCallback? onTap) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(),
            height: 172,
            child: Image.asset(
              imageData,
            ),
          ),
          Container(
            decoration: BoxDecoration(color: greenColor),
            height: 42,
            width: 180,
            child: Center(
              child: PlainText(
                name: heading,
                fontsize: 18,
                color: whiteColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
