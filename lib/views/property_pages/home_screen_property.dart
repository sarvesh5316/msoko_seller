import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msoko_seller/common/constant.dart';
import 'package:msoko_seller/common/plain_text.dart';
import 'package:msoko_seller/common/rounded_button.dart';
import 'package:msoko_seller/views/property_pages/new_listing.dart';
import 'package:msoko_seller/views/property_pages/property_drawer.dart';

// ignore: must_be_immutable
class HomeScreenProperty extends StatefulWidget {
  String email = "";
  HomeScreenProperty({super.key, required this.email});

  @override
  State<HomeScreenProperty> createState() => _HomeScreenPropertyState();
}

class _HomeScreenPropertyState extends State<HomeScreenProperty> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int activeListings = 0;
  int inActiveListings = 0;
  String status = "";
  String imageURL = "";
  String title = "";
  String location = "";
  String postDate = "";
  String postBy = "";
  String agentName = "";
  String reraID = "";
  String price = "";
  String rooms = "";
  bool sort = false;
  String filter = "";
  String usernamee = "";
  String avatarurl = "";

  @override
  void initState() {
    super.initState();
    statusCount();
  }

  void statusCount() {
    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(widget.email)
          .get()
          .then((value) {
        setState(() {
          activeListings = value['Property Active'];
          inActiveListings = value['Property Inactive'];
        });
      });
    } catch (e) {
      if (kDebugMode) {
        debugPrint("CATCHED ERROR : $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 205, 205, 205),
      key: scaffoldKey,
      drawer: Pdrawer(
        email: widget.email,
      ),
      appBar: AppBar(
        backgroundColor: const Color(0xFF08215E),
        title: Row(
          children: [
            const SizedBox(width: 10),
            PlainText(
              name: "Home",
              fontsize: 20,
              color: whiteColor,
            ),
          ],
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
          InkWell(
            onTap: () {
              // Get.to(() => const NotificationScreen());
            },
            child: Icon(
              Icons.notifications,
              color: whiteColor,
            ),
          ),
          const SizedBox(width: 15),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                RoundedButton(
                    title: "Create New Listing",
                    fontsize: 15,
                    buttonColor: const Color.fromRGBO(15, 136, 223, 1),
                    onTap: () async {
                      await Get.to(() => NewListing(
                            email: widget.email,
                          ));
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(widget.email)
                          .get()
                          .then((value) {
                        setState(() {
                          activeListings = value['Property Active'];
                          inActiveListings = value['Property Inactive'];
                        });
                      });
                    }),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          if (filter == "Active") {
                            setState(() {
                              filter = "";
                            });
                          } else {
                            setState(() {
                              filter = "Active";
                            });
                          }
                        },
                        child: Text(
                          "$activeListings\nActive Listings",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: (filter == "Active")
                                ? Colors.blue
                                : Colors.black,
                            fontWeight: (filter == "Active")
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (filter == "Inactive") {
                            setState(() {
                              filter = "";
                            });
                          } else {
                            setState(() {
                              filter = "Inactive";
                            });
                          }
                        },
                        child: Text(
                          "$inActiveListings\nInactive Listings",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: (filter == "Inactive")
                                ? Colors.blue
                                : Colors.black,
                            fontWeight: (filter == "Inactive")
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          InkWell(
            onTap: () {
              if (!sort) {
                setState(() {
                  sort = true;
                });
              } else {
                setState(() {
                  sort = false;
                });
              }
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 15, 25, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (sort)
                    const RotationTransition(
                      turns: AlwaysStoppedAnimation(0.5),
                      child: Icon(
                        Icons.sort,
                        color: Colors.blue,
                        size: 25,
                      ),
                    ),
                  if (!sort)
                    const Icon(
                      Icons.sort,
                      color: Colors.blue,
                      size: 25,
                    ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text(
                    "Sort",
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 17,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<QuerySnapshot>(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .doc(widget.email)
                    .collection("Seller_Property")
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    var documents = snapshot.data!.docs;
                    return CustomScrollView(
                      slivers: [
                        SliverPadding(
                          padding: const EdgeInsets.all(0),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                if (sort) {
                                  index = activeListings +
                                      inActiveListings -
                                      index -
                                      1;
                                }
                                var value = documents[index];
                                status = value['Listing Status'];
                                try {
                                  imageURL = value['Images'][0];
                                } catch (e) {
                                  imageURL =
                                      "https://firebasestorage.googleapis.com/v0/b/msoko-seller.appspot.com/o/avatar%2FAvatar_Property.png?alt=media&token=571a9f00-0f39-416a-a00e-8cd1aa592ca9";
                                }
                                title = value['Title'];
                                location = '${value['Plot Number']}, ${value['Locality']}';
                                Timestamp ts = value['Post Date'];
                                postDate = formatTimestamp(ts);
                                postBy = value['Post By'];
                                agentName = value['Agent Name'];
                                reraID = value['Rera ID'];
                                price = value['Selling Price (TZS)'];
                                price = formatAmount(price);
                                if (filter == "" || filter == status) {
                                  return ListTile(
                                    contentPadding: const EdgeInsets.all(0),
                                    title: Container(
                                      padding: const EdgeInsets.all(15),
                                      color: Colors.white,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              status,
                                              style: TextStyle(
                                                color: (status == 'Active')
                                                    ? Colors.green
                                                    : Colors.red,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: SizedBox(
                                              height: 150,
                                              width: 150,
                                              child: Image.network(
                                                imageURL,
                                                height: 150,
                                                width: 150,
                                                loadingBuilder:
                                                    (BuildContext context,
                                                        Widget child,
                                                        ImageChunkEvent?
                                                            loadingProgress) {
                                                  if (loadingProgress == null) {
                                                    return child;
                                                  } else {
                                                    return const Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    );
                                                  }
                                                },
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return const Center(
                                                      child: Icon(Icons.error));
                                                },
                                              ),
                                            ),
                                          ),
                                          Text(
                                            '$price | $title',
                                            textAlign: TextAlign.left,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.location_on_sharp,
                                                size: 20,
                                              ),
                                              const SizedBox(
                                                width: 4,
                                              ),
                                              Text(
                                                location,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontSize: 16),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            "Posted on $postDate, by $postBy",
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: Color.fromARGB(
                                                    255, 100, 100, 100)),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Row(
                                            children: [
                                              const Text(
                                                "AGENT",
                                                style: TextStyle(
                                                    color: Colors.blue,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 14),
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              Text(
                                                agentName,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Color.fromARGB(
                                                        255, 0, 0, 0)),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            "Rera ID: $reraID",
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: Color.fromARGB(
                                                    255, 100, 100, 100)),
                                          ),
                                          const Align(
                                            alignment: Alignment.bottomRight,
                                            child: Text(
                                              "Edit",
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      15, 98, 223, 1)),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                              childCount: activeListings + inActiveListings,
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }

  String formatAmount(String source) {
    int amount = int.parse(source);
    if (amount < 1000) {
      return 'TZS ${amount.toString()}';
    } else if (amount < 100000) {
      double formattedAmount = amount / 1000.0;
      return 'TZS ${formattedAmount.toStringAsFixed(1)} K';
    } else if (amount < 10000000) {
      double formattedAmount = amount / 100000.0;
      return 'TZS ${formattedAmount.toStringAsFixed(1)} L';
    } else {
      double formattedAmount = amount / 10000000.0;
      return 'TZS ${formattedAmount.toStringAsFixed(1)} Cr';
    }
  }

  String formatTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    String formattedDate =
        "${_getMonth(dateTime.month)} ${dateTime.day}', ${dateTime.year % 100}";
    return formattedDate;
  }

  String _getMonth(int month) {
    switch (month) {
      case 1:
        return "Jan";
      case 2:
        return "Feb";
      case 3:
        return "Mar";
      case 4:
        return "Apr";
      case 5:
        return "May";
      case 6:
        return "Jun";
      case 7:
        return "Jul";
      case 8:
        return "Aug";
      case 9:
        return "Sep";
      case 10:
        return "Oct";
      case 11:
        return "Nov";
      case 12:
        return "Dec";
      default:
        return "";
    }
  }
}
