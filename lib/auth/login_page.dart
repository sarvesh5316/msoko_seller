// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msoko_seller/auth/forget_pass.dart';
import 'package:msoko_seller/auth/sign_up.dart';
import 'package:msoko_seller/common/constant.dart';
import 'package:msoko_seller/common/utils.dart';
import 'package:msoko_seller/views/Service%20Section/Home_Page.dart';
import 'package:msoko_seller/views/product_screen/product_home_screen.dart';
import 'package:msoko_seller/views/property_pages/home_screen_property.dart';

// import 'package:msoko_seller/views/product_screen/home_screen.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;
  bool isVisible = true;

  Future<void> login() async {
    try {
      // Replace 'users' with the actual collection name
      QuerySnapshot<Map<String, dynamic>> collection = await FirebaseFirestore
          .instance
          .collection('users')
          .where('Email', isEqualTo: emailController.text.toString())
          .get();

      if (collection.docs.isNotEmpty) {
        for (QueryDocumentSnapshot<Map<String, dynamic>> doc
            in collection.docs) {
          // Access data using doc.data()
          Map<String, dynamic> userData = doc.data();
          logger.i("Document ID: ${doc.id}");
          logger.i("User Data: $userData");
          logger.i(userData['Product']);
          logger.i(userData['Name']);
          var x = userData['Property'];
          var y = userData['Product'];
          var z = userData['Service'];
          logger.i(y);
          // Navigation based on user properties
          if (x == true) {
            Get.offAll(() => HomeScreenProperty(email: emailController.text));
          } else if (y == true) {
            Get.offAll(() => ProductHomeScreen(email: emailController.text));
          } else if (z == true) {
            Get.offAll(() => ServiceHomeScreen());
          } else {
            Utils().toastMessage("User Not Registered! Please Register first.");
          }
        }
      } else {
        logger.i("No documents found in the 'users' collection.");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        Utils().toastMessage("Invalid email or password");
      } else {
        Utils().toastMessage("Error: ${e.message}");
      }
    } catch (e) {
      Utils().toastMessage("An unexpected error occurred");
    }
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: h,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    child: SizedBox(
                      height: 300,
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset(
                        "assets/images/rect.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 100,
                    left: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome to\nM-Soko",
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w700,
                            color: whiteColor,
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          height: 10,
                          width: 40,
                          decoration: BoxDecoration(
                            color: logoColor,
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 164,
                    left: 200,
                    child: Container(
                      height: 132,
                      width: 132,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: logoColor,
                      ),
                      child: Image.asset(
                        "assets/images/logo2.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Image.asset("assets/images/Looper.png"),
                  ),
                  Positioned(
                    top: 300,
                    child: SizedBox(
                      height: 512,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 10),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Email",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: appColor),
                              ),
                              TextFormField(
                                controller: emailController,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter Email';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Password",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: appColor),
                              ),
                              TextFormField(
                                controller: passController,
                                obscureText: isVisible,
                                decoration: InputDecoration(
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      setState(() {
                                        isVisible = !isVisible;
                                      });
                                    },
                                    child: Icon(
                                      isVisible
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter Your Password';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 10),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: InkWell(
                                  onTap: () {
                                    Get.to(() => ForgetPassword());
                                  },
                                  child: Text(
                                    "Forget Password?",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: appColor),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 148,
                                    child: Divider(thickness: 2),
                                  ),
                                  Text(" or ",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                      )),
                                  SizedBox(
                                    width: 148,
                                    child: Divider(thickness: 2),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 41,
                                    width: 41,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Image.asset("assets/images/fb.png"),
                                  ),
                                  SizedBox(width: 15),
                                  Container(
                                    height: 41,
                                    width: 41,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Image.asset(
                                        "assets/images/google-icon.png"),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              InkWell(
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    login();
                                  }
                                },
                                child: Container(
                                    height: 50,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: appColor,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          width: 0, color: Colors.grey),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Login",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                            color: whiteColor),
                                      ),
                                    )),
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "New Here?",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  InkWell(
                                    onTap: () {
                                      Get.to(() => SignUpPage());
                                    },
                                    child: Text(
                                      "Register",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xFF97C1FF)),
                                    ),
                                  ),
                                ],
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
          ],
        ),
      ),
    );
  }
}
