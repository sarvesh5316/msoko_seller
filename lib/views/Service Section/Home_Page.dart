import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msoko_seller/views/Service%20Section/Notification.dart';
import 'package:msoko_seller/views/Service%20Section/drawer_page.dart';
import 'package:msoko_seller/common/plain_text.dart';
import 'package:msoko_seller/common/constant.dart';
import 'package:msoko_seller/common/bold_text.dart';

class ServiceHomeScreen extends StatefulWidget {
  const ServiceHomeScreen({super.key});

  @override
  State<ServiceHomeScreen> createState() => _ServiceHomeScreenState();
}

class _ServiceHomeScreenState extends State<ServiceHomeScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      key: scaffoldKey,
      drawer: const NavDrawer(),
      appBar: AppBar(
        backgroundColor: const Color(0xFF08215E),
        title: Row(
          children: [
            SizedBox(
              height: 35,
              width: 36,
              child: Image.asset("assets/images/logo.png"),
            ),
            const SizedBox(width: 10),
            PlainText(
              name: "SOKONI",
              fontsize: 20,
              color: whiteColor,
            ),
          ],
        ),
        leading: InkWell(
          onTap: () {
            scaffoldKey.currentState?.openDrawer();
          },
          child: Icon(
            Icons.menu,
            color: whiteColor,
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              Get.to(() => const Notification_page());
            },
            child: Icon(
              Icons.notifications,
              color: whiteColor,
            ),
          ),
          const SizedBox(width: 15),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 150,
              width: w,
              child: Image.asset(
                "assets/images/Home_service_section.png",
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      color: Colors.blue,
                      height: 45,
                      child: TextButton(
                        onPressed: () {
                          //  Get.to(() => ItemListing());
                        },
                        child: const Center(
                          child: Text(
                            "Start Listing",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )),
                  const SizedBox(height: 10),
                  Container(
                    height: 254,
                    width: w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: greyColor),
                      // color: appColor,
                    ),
                    child: const Center(
                        child: BoldText(name: "Chart Loading!!", fontsize: 16)),
                  ),

                  const SizedBox(height: 10),

                  PlainText(
                    name: "Ordering Overview",
                    fontsize: 16,
                    color: textColor,
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {},
                        child:
                            buildContainer("Pending Order", 11, 80, sellColor),
                      ),
                      const SizedBox(width: 5),
                      InkWell(
                        onTap: () {},
                        child:
                            buildContainer("Confirm Order", 20, 80, sellColor),
                      ),
                      const SizedBox(width: 5),
                      InkWell(
                        onTap: () {},
                        child: buildContainer(
                            "Delivered Order", 40, 80, sellColor),
                      ),
                      const SizedBox(width: 5),
                      InkWell(
                        onTap: () {},
                        child: buildContainer(
                            "Cancelled Order", 09, 83, sellColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  PlainText(
                    name: "Business Overview",
                    fontsize: 16,
                    color: textColor,
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: buildContainer("Today's Ordering", 20, 162,
                            greenColor.withOpacity(0.7)),
                      ),
                      const SizedBox(width: 5),
                      InkWell(
                        onTap: () {},
                        child: buildContainer("Monthly Ordering", 80, 162,
                            greenColor.withOpacity(0.7)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  PlainText(
                    name: "Payment Overview",
                    fontsize: 16,
                    color: textColor,
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: buildContainer("Today's Ordering", 20, 162,
                            greenColor.withOpacity(0.7)),
                      ),
                      const SizedBox(width: 5),
                      InkWell(
                        onTap: () {},
                        child: buildContainer("Monthly Ordering", 80, 162,
                            greenColor.withOpacity(0.7)),
                      ),
                    ],
                  ),

                  // SampleLineChart(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildContainer(String text, int size, double width, Color color) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color,
      ),
      height: 95,
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PlainText(
            name: text,
            fontsize: 18,
            color: whiteColor,
            textAlign: TextAlign.center,
          ),
          PlainText(name: size.toString(), fontsize: 18, color: blackColor),
        ],
      ),
    );
  }
}
