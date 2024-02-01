import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:msoko_seller/common/constant.dart';
import 'package:msoko_seller/views/property_pages/allticket.dart';
import 'package:msoko_seller/views/property_pages/property_drawer.dart';
import 'package:msoko_seller/views/property_pages/request_call.dart';
import 'package:msoko_seller/views/property_pages/ticket_creation.dart';

class Ticket1 extends StatefulWidget {
  const Ticket1({
    super.key,
    required this.email,
    required this.userurl,
  });
  final String email;
  final String userurl;
  @override
  State<Ticket1> createState() => _Ticket1State();
}

class _Ticket1State extends State<Ticket1> {
  String state = "";
  @override
  Widget build(BuildContext context) {
    if (state == "true") {
      setState(() {});
    }
    return Scaffold(
      drawer: Pdrawer(
        email: widget.email,
      ),
      backgroundColor: const Color.fromRGBO(228, 228, 228, 1),
      appBar: AppBar(
        backgroundColor: appColor,
        title: const Text(
          "My tickets",
          style: TextStyle(color: Colors.white),
        ),
        leading: Builder(builder: (BuildContext builderContext) {
          return InkWell(
            onTap: () {
              Scaffold.of(builderContext).openDrawer();
            },
            child: Icon(
              Icons.menu,
              color: whiteColor,
            ),
          );
        }),
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
              onTap: () {
                Get.to(() => RequestCall(
                      email: widget.email,
                    ));
              },
              child: const Row(
                children: [
                  Icon(
                    Icons.headphones,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Help",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            color: const Color.fromRGBO(255, 255, 255, 1),
            height: 65,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(16.0),
            child: FutureBuilder<int>(
              future: countData(""),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'All Tickets',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      Center(
                        child: IconButton(
                          icon: const Icon(Icons.arrow_forward),
                          onPressed: () {
                            Get.to(() => Alltickets(
                                  email: widget.email,
                                  status: "",
                                  userUrl: widget.userurl,
                                ));
                          },
                        ),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  int documentCount = snapshot.data ?? 0;

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'All Tickets:($documentCount)',
                        style: const TextStyle(fontSize: 18.0),
                      ),
                      Center(
                        child: IconButton(
                          icon: const Icon(Icons.arrow_forward),
                          onPressed: () {
                            Get.to(() => Alltickets(
                                email: widget.email,
                                status: "",
                                userUrl: widget.userurl));
                          },
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            color: const Color.fromRGBO(255, 255, 255, 1),
            height: 65,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(16.0),
            child: FutureBuilder<int>(
              future: countData("pending"),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Pending Tickets',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      Center(
                        child: IconButton(
                          icon: const Icon(Icons.arrow_forward),
                          onPressed: () {
                            Get.to(() => Alltickets(
                                email: widget.email,
                                status: "pending",
                                userUrl: widget.userurl));
                          },
                        ),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  int documentCount = snapshot.data ?? 0;

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Pending Tickets: ($documentCount)',
                        style: const TextStyle(fontSize: 18.0),
                      ),
                      Center(
                        child: IconButton(
                          icon: const Icon(Icons.arrow_forward),
                          onPressed: () {
                            Get.to(() => Alltickets(
                                email: widget.email,
                                status: "pending",
                                userUrl: widget.userurl));
                          },
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            color: const Color.fromRGBO(255, 255, 255, 1),
            height: 65,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(16.0),
            child: FutureBuilder<int>(
              future: countData("resolved"),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Resolved / Closed',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      Center(
                        child: IconButton(
                          icon: const Icon(Icons.arrow_forward),
                          onPressed: () {
                            Get.to(() => Alltickets(
                                email: widget.email,
                                status: "resolved",
                                userUrl: widget.userurl));
                          },
                        ),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  int documentCount = snapshot.data ?? 0;

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Resolved / Closed:($documentCount)',
                        style: const TextStyle(fontSize: 18.0),
                      ),
                      Center(
                        child: IconButton(
                          icon: const Icon(Icons.arrow_forward),
                          onPressed: () {
                            Get.to(() => Alltickets(
                                email: widget.email,
                                status: "resolved",
                                userUrl: widget.userurl));
                          },
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
          buildClickableContainer(),
        ],
      ),
    );
  }

  Widget buildClickableContainer() {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () {
          Get.to(() => Tcreate(email: widget.email))?.then((result) {
            debugPrint(result);
            if (result != null) {
              setState(() {
                state = "true";
              });

              // You can use setState or any other state management solution here
            }
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(11.0),
          child: Container(
            width: MediaQuery.sizeOf(context).width * 0.40,
            // width: 170,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.blue,
            ),
            padding: const EdgeInsets.fromLTRB(16, 12, 12, 12),

            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                SizedBox(width: 5.0),
                Text(
                  'Create',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<int> countData(String status) async {
    List<Map<String, dynamic>> data = [];

    QuerySnapshot<Map<String, dynamic>> alldocuments = await FirebaseFirestore
        .instance
        .collection('Property_Tickets')
        .doc(widget.email)
        .collection(widget.email)
        .get();
    Map<String, dynamic> documentsMap = {};
    for (QueryDocumentSnapshot documentSnapshot in alldocuments.docs) {
      documentsMap[documentSnapshot.id] = documentSnapshot.data();
    }
    documentsMap.forEach((documentId, itemData) {
      if (itemData['title'] != null) {
        if (status == "") {
          data.add(itemData);
        } else if (status == "pending") {
          if (itemData['Reply'].toString() == "") {
            data.add(itemData);
          }
        } else if (status == "resolved") {
          if (itemData['Reply'].toString() != "") {
            data.add(itemData);
          }
        }
      }
    });
    return data.length;
  }
}
