import 'package:flutter/material.dart';
import 'package:msoko_seller/common/constant.dart';
import 'package:msoko_seller/common/plain_text.dart';
import 'package:msoko_seller/common/rounded_button.dart';
import 'package:get/get.dart';
class FeedBack extends StatefulWidget {
  const FeedBack({super.key});

  @override
  State<FeedBack> createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF08215E),
        title: PlainText(
          name: "Send feedback",
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 60),
          child: Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(border: Border.all(color: greyColor)),
            height: 415,
            width: w,
            child: Column(
              children: [
                SizedBox(
                  height: 61,
                  width: w,
                  child: ListView.builder(
                      itemCount: 5,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.star_outline,
                            color: yellowColor,
                            size: 50,
                          ),
                        );
                      }),
                ),
                const SizedBox(height: 30),
                Container(
                  decoration: BoxDecoration(
                      color: greyColor1,
                      borderRadius: BorderRadius.circular(10)),
                  height: 150,
                  child: TextFormField(
                    maxLines: 7,
                    decoration: const InputDecoration(
                      hintText:
                      "Write your words and suggestions to help us improve",
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 63,
                ),
                SizedBox(
                  height: 63,
                  width: 200,
                  child: RoundedButton(
                    onTap: () {},
                    title: "Send",
                    radius: 35,
                    fontsize: 20,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
