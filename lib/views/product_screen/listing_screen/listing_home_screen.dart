// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msoko_seller/common/bold_text.dart';
import 'package:msoko_seller/common/constant.dart';
import 'package:msoko_seller/common/plain_text.dart';
import 'package:msoko_seller/views/product_screen/listing_screen/create_new_listing.dart';
import 'package:msoko_seller/views/product_screen/listing_screen/fetch_products.dart';

class ListingHomeScreen extends StatefulWidget {
  final String email;

  const ListingHomeScreen({super.key, required this.email});

  @override
  State<ListingHomeScreen> createState() => _ListingHomeScreenState();
}

// List<String> images = [];
// Map<String, dynamic> productData = {};
// List<String> productTitles = [];
List<Product> productdetails = [];
// List<List<String>> productImages = [];

class _ListingHomeScreenState extends State<ListingHomeScreen>
    with TickerProviderStateMixin {
  final ScrollController scrollController = ScrollController();
  late TabController tabController;
  bool isloading = false;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this);
    // fetchDataFromFirebase();
    fetchDataFromFirebase(widget.email).then((List<Product> products) {
      setState(() {
        productdetails = products;
      });
    });
    logger.i(productdetails.length);
  }

  void navigateToTab(int tabIndex) {
    tabController.animateTo(tabIndex);
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF08215E),
        title: PlainText(
          name: "Listing",
          fontWeight: FontWeight.w400,
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
        actions: [
          InkWell(
            onTap: () {
              Get.to(() => CreateNewListing(
                    email: widget.email,
                  ));
            },
            child: Icon(
              Icons.add_box_rounded,
              color: whiteColor,
            ),
          ),
          SizedBox(width: 15),
          InkWell(
            onTap: () {
              // Get.to(() => NotificationScreen());
            },
            child: Icon(
              Icons.more_vert,
              color: whiteColor,
            ),
          ),
          SizedBox(width: 15),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 5, right: 5),
              height: 80,
              child: TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                dividerHeight: 0,
                indicatorWeight: 0,
                labelPadding: EdgeInsets.zero,
                controller: tabController,
                // indicatorPadding: EdgeInsets.all(0),

                tabs: [
                  buildTabBar("10", "Active Listings"),
                  buildTabBar("09", "Ready to Activation"),
                  buildTabBar("05", "Blocked Listings"),
                  buildTabBar("20", "Archieved Listings"),
                  buildTabBar("15", "Inactive Listings"),
                ],
                dividerColor: blackColor,
                labelColor: blueColor,
                padding: EdgeInsets.all(0),
                indicatorColor: appColor,
                unselectedLabelColor: blackColor,
                indicator: BoxDecoration(),
                // indicator: BoxDecoration(
                //     // borderRadius: BorderRadius.circular(0),
                //     // border: Border.all(),
                //     // color: Colors.amber,
                //     ),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.check_box_outlined,
                        color: blueColor,
                      ),
                      PlainText(
                        name: "Select",
                        fontsize: 18,
                        color: blueColor,
                      ),
                      SizedBox(width: 70),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: orangeColor,
                          border: Border.all(color: orangeColor),
                        ),
                        child: Icon(
                          Icons.swap_horiz_outlined,
                          color: whiteColor,
                        ),
                      ),
                      SizedBox(width: 10),
                      Icon(
                        Icons.filter_alt_outlined,
                        color: blueColor,
                      ),
                      PlainText(
                        name: "Filter",
                        fontsize: 18,
                        color: blueColor,
                      ),
                      SizedBox(width: 20),
                      Icon(
                        Icons.sort_rounded,
                        color: blueColor,
                      ),
                      PlainText(
                        name: "Sort",
                        fontsize: 18,
                        color: blueColor,
                      ),
                      SizedBox(width: 20),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BoldText(name: "Product Details", fontsize: 15),
                      // SizedBox(width: 70),
                      BoldText(name: "Date", fontsize: 15),
                      // SizedBox(width: 30),
                      BoldText(name: "Price", fontsize: 15),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  // ignore: sized_box_for_whitespace
                  child: Container(
                    height: h * 0.68,
                    // color: Colors.amber,
                    child: TabBarView(
                      physics: BouncingScrollPhysics(),
                      controller: tabController,
                      children: [
                        //tab 1
                        buildProductTab(productdetails),
                        //tab 2
                        buildProductTab(productdetails),
                        //tab 3
                        buildProductTab(productdetails),
                        //tab 4
                        buildProductTab(productdetails),
                        //tab 5
                        buildProductTab(productdetails),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTabBar(String count, String label) {
    return Container(
      decoration: BoxDecoration(border: Border.all()),
      width: 100,
      height: 100,
      // color: appColor,
      child: Tab(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            PlainText(
              name: count,
              fontsize: 15,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 5),
            BoldText(
              name: label,
              fontsize: 12,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProductTab(List<Product> products) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        controller: scrollController,
        itemCount: productdetails.length,
        itemBuilder: (context, index) {
          Product product = products[index];

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(productdetails[index]
                                .itemImages
                                .isNotEmpty
                            ? productdetails[index].itemImages[0]
                            : 'default_image_url'), // Use a default image URL or local placeholder if images are empty
                      ),
                    ),
                    SizedBox(width: 5),
                    SizedBox(
                      width: 115,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BoldText(
                              name: productdetails[index].itemName,
                              fontsize: 14),
                          PlainText(
                            name: product.sellerSkuID,
                            fontsize: 13,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 10),
                PlainText(name: "12/01/2024", fontsize: 15),
                SizedBox(width: 10),
                // PlainText(name: "TZS500", fontsize: 17),
                RichText(
                  text: TextSpan(
                    text: "TZS",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                    children: [
                      TextSpan(
                        text: productdetails[index].itemMrp,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
