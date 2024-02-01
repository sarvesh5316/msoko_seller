import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:msoko_seller/common/constant.dart';
import 'package:msoko_seller/common/utils.dart';
import 'package:msoko_seller/views/property_pages/property_drawer.dart';

class RequestCall extends StatefulWidget {
  const RequestCall({super.key, required this.email});
  final String email;

  @override
  State<RequestCall> createState() => _RequestCallState();
}

class _RequestCallState extends State<RequestCall> {
  TextEditingController number = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Pdrawer(
        email: widget.email,
      ),
      backgroundColor: const Color.fromRGBO(228, 228, 228, 1),
      appBar: AppBar(
        backgroundColor: appColor,
        title: const Text(
          "Help",
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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.black,
              height: 65,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Request a call from seller support.",
                    style: TextStyle(fontSize: 16.0, color: Colors.white),
                  ),
                  Center(
                    child: IconButton(
                      color: Colors.white,
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            SizedBox(
              width: MediaQuery.sizeOf(context).width,
              child: const Padding(
                padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                child: Text(
                  'Enter Phone Number',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 1.0),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
              child: TextFormField(
                controller: number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 1.0),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () async {
                  try {
                    FirebaseFirestore firestore = FirebaseFirestore.instance;
                    await firestore
                        .collection('propertyCallRequest')
                        .doc(widget.email)
                        .set({
                      'Number': number.text,
                      'status': 'Pending',
                    });

                    Utils().toastMessage("Requestes a call Successfully!");
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  } catch (e) {
                    Utils().toastMessage(e.toString());
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    width: MediaQuery.sizeOf(context).width * 0.40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.blue,
                    ),
                    padding: const EdgeInsets.fromLTRB(16, 12, 12, 12),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Send',
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
            ),
          ],
        ),
      ),
    );
  }
}
