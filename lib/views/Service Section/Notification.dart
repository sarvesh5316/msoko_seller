import 'package:flutter/material.dart';
import 'package:msoko_seller/common/constant.dart';
import 'package:msoko_seller/common/plain_text.dart';
import 'package:get/get.dart';
import '../../common/bold_text.dart';

class Notification_page extends StatefulWidget {
  const Notification_page({super.key});

  @override
  State<Notification_page> createState() => _Notification_pageState();
}

class _Notification_pageState extends State<Notification_page>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  void navigateToTab(int tabIndex) {
    tabController.animateTo(tabIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF08215E),
        title: PlainText(
          name: "Notifications(7)",
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
            onTap: () {},
            child: Icon(
              Icons.more_vert,
              color: whiteColor,
            ),
          ),
          const SizedBox(width: 15),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 0),
        child: Column(
          children: [
            TabBar(
              controller: tabController,
              tabs: const [
                Tab(child: PlainText(name: "All", fontsize: 20)),
                Tab(child: PlainText(name: "Orders", fontsize: 20)),
                Tab(child: PlainText(name: "Payment", fontsize: 20)),
              ],
              dividerColor: Colors.transparent,
              labelColor: appColor,
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(
                  width: 4.0,
                  color: appColor,
                ),
                insets: const EdgeInsets.symmetric(horizontal: -16.0),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  //tab 1
                  listBuilder(),
                  //tab 2
                  listBuilder(),
                  //Tab3
                  listBuilder()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget listBuilder() {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Card(
          // height: 148,
          // width: w,
          color: whiteColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.task_outlined),
                    BoldText(
                      name: "New Order",
                      fontsize: 16,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Icon(
                        Icons.circle,
                        color: greenColor,
                        size: 10,
                      ),
                      PlainText(
                        name: "Today",
                        fontsize: 16,
                        color: greenColor,
                      ),
                    ],
                  ),
                ),
                const PlainText(
                  name:
                      "Lorem ipsum dolor sit amet consectetur adipisicing elit. Facere expedita quibusdam assumenda explicabo omnis ",
                  fontsize: 16,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
