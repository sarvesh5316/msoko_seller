// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:msoko_seller/common/bold_text.dart';
import 'package:msoko_seller/common/constant.dart';
import 'package:msoko_seller/common/plain_text.dart';
import 'package:msoko_seller/common/reusabletextformfield.dart';
import 'package:msoko_seller/common/rounded_button.dart';
import 'package:msoko_seller/common/utils.dart';
import 'package:msoko_seller/views/product_screen/product_home_screen.dart';

class CreateNewListing extends StatefulWidget {
  final String email;
  const CreateNewListing({super.key, required this.email});

  @override
  State<CreateNewListing> createState() => _CreateNewListingState();
}

List<String> imagePaths = [];
FirebaseAuth auth = FirebaseAuth.instance;
String userEmail = auth.currentUser!.email!;

class _CreateNewListingState extends State<CreateNewListing>
    with TickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();

  bool isActiveSelected = false;
  bool isInactiveSelected = true;
  final ScrollController scrollController = ScrollController();
  late TabController tabController;
  TextEditingController sellerSkuID = TextEditingController();
  TextEditingController mrpController = TextEditingController();
  TextEditingController sellPriceController = TextEditingController();
  TextEditingController stockController = TextEditingController();
  TextEditingController availStockController = TextEditingController();
  TextEditingController localDelController = TextEditingController();
  TextEditingController zonalDelController = TextEditingController();
  TextEditingController nationalDelController = TextEditingController();
  TextEditingController pkgWeightController = TextEditingController();
  TextEditingController pkgSizeController = TextEditingController();
  TextEditingController hsnController = TextEditingController();
  TextEditingController taxCodeController = TextEditingController();
  TextEditingController countryOriginController = TextEditingController();
  TextEditingController mfgDetailsController = TextEditingController();
  TextEditingController packerDetailsController = TextEditingController();
  TextEditingController importerDetailsController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController salesPkgController = TextEditingController();
  TextEditingController keywordController = TextEditingController();
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    logger.i(widget.email);
  }

  void navigateToTab(int tabIndex) {
    tabController.animateTo(tabIndex);
  }

  @override
  void dispose() {
    super.dispose();
    imagePaths.clear();
  }

  @override
  Widget build(BuildContext context) {
    // var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF08215E),
        title: PlainText(
          name: "New Listing",
          fontsize: 20,
          color: whiteColor,
        ),
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios_new,
            size: 20,
            color: whiteColor,
          ),
        ),
      ),
      body: Column(
        children: [
          TabBar(
            controller: tabController,
            tabs: [
              Tab(child: PlainText(name: "Product Image", fontsize: 16)),
              Tab(child: PlainText(name: "Product Details", fontsize: 16)),
            ],
            dividerColor: Colors.transparent,
            labelColor: appColor,
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(
                width: 4.0,
                color: Colors.amber,
              ),
              insets: EdgeInsets.symmetric(horizontal: -16.0),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                // Tab 1
                // Center(child: Text('Content for Tab 1')),
                Container(
                  height: h - 100,
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            // width: 320,
                            alignment: Alignment.center,
                            height: 220,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/dottedborder.png"),
                                  fit: BoxFit.fill),
                            ),
                            child: imagePaths.isEmpty
                                ? Image.asset(
                                    "assets/images/bag3.png",
                                    height: 184,
                                    width: 130,
                                  )
                                : Image.file(File(imagePaths[0])),
                          ),
                          hSpacer(10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: RoundedButton(
                              radius: 25,
                              title: "Upload Photo",
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  builder: (BuildContext builderContext) {
                                    return Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.244,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topLeft: const Radius.circular(25.0),
                                          topRight: const Radius.circular(25.0),
                                        ),
                                      ),
                                      child: buildEventShareSheet(),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                          hSpacer(20),
                          SizedBox(
                            height: 80,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: imagePaths.isNotEmpty
                                      ? ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: imagePaths.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: const EdgeInsets.all(2),
                                              child: Image.file(
                                                File(imagePaths[index]),
                                                fit: BoxFit.contain,
                                              ),
                                            );
                                          },
                                        )
                                      : InkWell(
                                          onTap: () {
                                            showModalBottomSheet(
                                              context: context,
                                              isScrollControlled: true,
                                              backgroundColor:
                                                  Colors.transparent,
                                              builder: (BuildContext
                                                  builderContext) {
                                                return Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.244,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          const Radius.circular(
                                                              25.0),
                                                      topRight:
                                                          const Radius.circular(
                                                              25.0),
                                                    ),
                                                  ),
                                                  child: buildEventShareSheet(),
                                                );
                                              },
                                            );
                                          },
                                          child: Container(
                                            alignment: Alignment.topLeft,
                                            height: 75,
                                            width: 50,
                                            child: Image.asset(
                                              "assets/images/addImg.png",
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                ),
                              ],
                            ),
                          ),
                          hSpacer(10),
                          BoldText(
                            name: "Image Resolution",
                            fontsize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          hSpacer(5),
                          PlainText(
                            name:
                                "Use clear color image with minimum resolution of 500X500 px",
                            fontsize: 15,
                            color: greyColor,
                          ),
                          hSpacer(10),
                          buildRichHeading("Seller SKU ID"),
                          hSpacer(5),
                          ReusableTextFormField(
                            controller: sellerSkuID,
                            hintText: "",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Seller SKU ID';
                              }
                              return null; // Return null for no validation error
                            },
                          ),
                          hSpacer(20),
                          BoldText(
                            name:
                                "Follow Image Guidelines to reduce the Quality Check failures",
                            fontsize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          buildGuidelineContainer(
                            "Lorem ipsum dolor sit amet consectetur adipisicing elit. Facere expedita quibusdam assumenda explicabo omnis totam? Voluptatem tenetur nisi error beatae veniam, illo velit eaque quidem, quam ratione quaerat repudiandae placeat",
                          ),
                          buildGuidelineContainer(
                            "Lorem ipsum dolor sit amet consectetur adipisicing elit. Facere expedita quibusdam assumenda explicabo omnis totam? Voluptatem tenetur nisi error beatae veniam, illo velit eaque quidem, quam ratione quaerat repudiandae placeat",
                          ),
                          buildGuidelineContainer(
                            "Lorem ipsum dolor sit amet consectetur adipisicing elit. Facere expedita quibusdam assumenda explicabo omnis totam? Voluptatem tenetur nisi error beatae veniam, illo velit eaque quidem, quam ratione quaerat repudiandae placeat",
                          ),
                          buildGuidelineContainer(
                            "Lorem ipsum dolor sit amet consectetur adipisicing elit. Facere expedita quibusdam assumenda explicabo omnis totam? Voluptatem tenetur nisi error beatae veniam, illo velit eaque quidem, quam ratione quaerat repudiandae placeat",
                          ),
                          RoundedButton(
                            title: "Confirm & Next",
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                navigateToTab(1);
                              } else {
                                Utils().toastMessage(
                                    "Kindly fill the required field");
                              }
                            },
                            radius: 0,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                // Tab 2
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5, left: 15, right: 15),
                    child: Form(
                      key: _formKey1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildHeading("Listing info"),
                          hSpacer(10),
                          buildRichHeading("Seller SKU ID "),
                          hSpacer(10),
                          ReusableTextFormField(
                            controller: sellerSkuID,
                            hintText: "",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Seller SKU ID';
                              }
                              return null; // Return null for no validation error
                            },
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
                                  textColor: isInactiveSelected
                                      ? greyColor
                                      : whiteColor,
                                  buttonColor:
                                      isActiveSelected ? blueColor : whiteColor,
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
                                  textColor:
                                      isActiveSelected ? greyColor : whiteColor,
                                  buttonColor: isInactiveSelected
                                      ? blueColor
                                      : whiteColor,
                                ),
                              ),
                            ],
                          ),
                          hSpacer(10),
                          buildHeading("Price Details"),
                          hSpacer(10),
                          buildRichHeading("MRP "),
                          hSpacer(10),
                          ReusableTextFormField(
                            keyboardType: TextInputType.number,
                            controller: mrpController,
                            hintText: "",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter MRP';
                              }
                              return null; // Return null for no validation error
                            },
                          ),
                          hSpacer(10),
                          buildRichHeading("Your Selling Price "),
                          hSpacer(10),
                          ReusableTextFormField(
                            keyboardType: TextInputType.number,
                            controller: sellPriceController,
                            hintText: "",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter selling price';
                              }
                              return null; // Return null for no validation error
                            },
                          ),
                          hSpacer(10),
                          buildHeading("Stock Details"),
                          hSpacer(10),
                          buildRichHeading("Stock "),
                          hSpacer(10),
                          ReusableTextFormField(
                            keyboardType: TextInputType.number,
                            controller: stockController,
                            hintText: "Add Numbers of Stocks",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Stocks';
                              }
                              return null; // Return null for no validation error
                            },
                          ),
                          hSpacer(10),
                          buildRichHeading("Stock available for buyers "),
                          hSpacer(10),
                          ReusableTextFormField(
                            keyboardType: TextInputType.number,
                            controller: availStockController,
                            hintText: "Add number of stocks available",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter available stocks';
                              }
                              return null; // Return null for no validation error
                            },
                          ),
                          hSpacer(10),
                          buildHeading("Delivery Charge Details"),
                          hSpacer(10),
                          buildRichHeading(
                              "Delivery Charge to customer(Local)"),
                          hSpacer(10),
                          ReusableTextFormField(
                            keyboardType: TextInputType.number,
                            controller: localDelController,
                            hintText: "Price",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Delivery Charge';
                              }
                              return null; // Return null for no validation error
                            },
                          ),
                          hSpacer(10),
                          buildRichHeading(
                              "Delivery Charge to customer(Zonal)"),
                          hSpacer(10),
                          ReusableTextFormField(
                            keyboardType: TextInputType.number,
                            controller: zonalDelController,
                            hintText: "Price",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Zonal Delivery price';
                              }
                              return null; // Return null for no validation error
                            },
                          ),
                          hSpacer(10),
                          buildRichHeading(
                              "Delivery Charge to customer(National)"),
                          hSpacer(10),
                          ReusableTextFormField(
                            keyboardType: TextInputType.number,
                            controller: nationalDelController,
                            hintText: "Price",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter National Delivery charge';
                              }
                              return null; // Return null for no validation error
                            },
                          ),
                          hSpacer(10),
                          buildHeading("Packaging Details"),
                          hSpacer(10),
                          buildRichHeading("Package weight(KG)"),
                          hSpacer(10),
                          ReusableTextFormField(
                            keyboardType: TextInputType.number,
                            controller: pkgWeightController,
                            hintText: "",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter package weight';
                              }
                              return null; // Return null for no validation error
                            },
                          ),
                          hSpacer(10),
                          buildRichHeading("Package Length(CM)"),
                          hSpacer(10),
                          ReusableTextFormField(
                            keyboardType: TextInputType.number,
                            controller: pkgSizeController,
                            hintText: "",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter package length';
                              }
                              return null; // Return null for no validation error
                            },
                          ),
                          hSpacer(10),
                          buildHeading("Tax Details"),
                          hSpacer(10),
                          buildRichHeading("HSN"),
                          hSpacer(10),
                          ReusableTextFormField(
                            controller: hsnController,
                            hintText: "",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter HSN';
                              }
                              return null; // Return null for no validation error
                            },
                          ),
                          hSpacer(10),
                          buildRichHeading("Tax Code"),
                          hSpacer(10),
                          ReusableTextFormField(
                            controller: taxCodeController,
                            hintText: "",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter tax code';
                              }
                              return null; // Return null for no validation error
                            },
                          ),
                          hSpacer(10),
                          buildHeading("Manufacturing Details"),
                          hSpacer(10),
                          buildRichHeading("Country Origin"),
                          hSpacer(10),
                          ReusableTextFormField(
                            controller: countryOriginController,
                            hintText: "",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter country origin ';
                              }
                              return null; // Return null for no validation error
                            },
                          ),
                          hSpacer(10),
                          buildRichHeading("Manufacture Details"),
                          hSpacer(10),
                          ReusableTextFormField(
                            controller: mfgDetailsController,
                            hintText: "",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter manufacture details';
                              }
                              return null; // Return null for no validation error
                            },
                          ),
                          hSpacer(10),
                          buildRichHeading("Packer Details"),
                          hSpacer(10),
                          ReusableTextFormField(
                            controller: packerDetailsController,
                            hintText: "",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter packer details';
                              }
                              return null; // Return null for no validation error
                            },
                          ),
                          hSpacer(10),
                          buildRichHeading("Importer Details"),
                          hSpacer(10),
                          ReusableTextFormField(
                            controller: importerDetailsController,
                            hintText: "",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter importer detail';
                              }
                              return null; // Return null for no validation error
                            },
                          ),
                          hSpacer(10),
                          buildRichHeading("Title"),
                          hSpacer(10),
                          ReusableTextFormField(
                            controller: titleController,
                            hintText: "",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Title';
                              }
                              return null; // Return null for no validation error
                            },
                          ),
                          hSpacer(10),
                          buildHeading("In the box"),
                          hSpacer(10),
                          buildRichHeading("Sales Package"),
                          hSpacer(10),
                          ReusableTextFormField(
                            controller: salesPkgController,
                            hintText: "",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Sales Package';
                              }
                              return null; // Return null for no validation error
                            },
                          ),
                          hSpacer(10),
                          buildHeading("Key Word"),
                          hSpacer(10),
                          buildRichHeading("Add Keywords"),
                          hSpacer(10),
                          ReusableTextFormField(
                            controller: keywordController,
                            hintText: "",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Some Keywords';
                              }
                              return null; // Return null for no validation error
                            },
                          ),
                          hSpacer(20),
                          RoundedButton(
                            title: "Send to QC",
                            onTap: () {
                              if (_formKey1.currentState!.validate()) {
                                // Utils().toastMessage("okay!");
                                addDataToFirebase();
                              } else {
                                Utils().toastMessage(
                                    "Please Enter Required Fields");
                              }
                            },
                            radius: 0,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  buildGuidelineContainer(String text) {
    return Container(
      padding: EdgeInsets.all(8),
      height: 75,
      // width: 330,
      // decoration: BoxDecoration(border: Border.all()),
      child: PlainText(
        textAlign: TextAlign.justify,
        name: text,
        fontsize: 14,
      ),
    );
  }

  Widget buildEventShareSheet() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: InkWell(
                onTap: () => Get.back(), child: Icon(Icons.close, size: 25)),
          ),
          BoldText(
            name: "Upload a picture of your product",
            fontsize: 16,
            fontWeight: FontWeight.w500,
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                reusableImageOption(Icons.image_rounded, "Gallery", () {
                  pickImage(ImageSource.gallery);
                }),
                reusableImageOption(Icons.camera_alt_rounded, "Camera", () {
                  pickImage(ImageSource.camera);
                }),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget reusableImageOption(IconData icon, String text, VoidCallback ontap) {
    return InkWell(
      onTap: ontap,
      child: Column(
        children: [
          Icon(
            icon,
            size: 30,
            color: blueColor,
          ),
          PlainText(name: text, fontsize: 16),
        ],
      ),
    );
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

  Future<void> pickImage(ImageSource imgSource) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: imgSource);

    if (pickedFile != null) {
      setState(() {
        imagePaths.add(pickedFile.path);
      });
    }
  }

  Future<void> addDataToFirebase() async {
    try {
      List<String> imageUrls = await uploadImagesToFirebaseStorage1();
      // var userEmail = widget.email;

      // Generate a unique ID for the product document
      String productId =
          FirebaseFirestore.instance.collection('products').doc().id;

      // Add data to Firestore under the 'products' collection with a unique document ID
      await FirebaseFirestore.instance
          .collection('products')
          .doc(productId)
          .set({
        'sellerSkuID': sellerSkuID.text,
        'itemMrp': mrpController.text,
        'sellPrice': sellPriceController.text,
        'stock': stockController.text,
        'itemOrderCount': availStockController.text,
        'itemShippingChargelocal': localDelController.text,
        'itemShippingChargezonal': zonalDelController.text,
        'itemShippingChargenational': nationalDelController.text,
        'pkgWeight': pkgWeightController.text,
        'pkgSize': pkgSizeController.text,
        'email': widget.email.toString(),
        'hsn': hsnController.text,
        'isActive': isActiveSelected,
        'taxCode': taxCodeController.text,
        'countryOrigin': countryOriginController.text,
        'mfgDetails': mfgDetailsController.text,
        'packerDetails': packerDetailsController.text,
        'importerDetails': importerDetailsController.text,
        'itemName': titleController.text,
        'salesPkg': salesPkgController.text,
        'keywords': keywordController.text,
        'itemImages': imageUrls,
      });

      logger.i('Product added to Firestore successfully!');
      Utils().toastMessage('Product added to Firestore successfully!');
    } catch (e) {
      logger.i('Error adding product to Firestore: $e');
      Utils().toastMessage('Error adding product to Firestore: $e');
    }
  }

  Future<List<String>> uploadImagesToFirebaseStorage() async {
    List<String> imageUrls = [];

    try {
      for (String imagePath in imagePaths) {
        // Use your own logic to get a unique filename
        String filename = DateTime.now().millisecondsSinceEpoch.toString();
        Reference storageReference =
            FirebaseStorage.instance.ref().child('images/$filename.jpg');

        UploadTask uploadTask = storageReference.putFile(File(imagePath));
        TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

        // Get the download URL of the uploaded image
        String downloadUrl = await taskSnapshot.ref.getDownloadURL();
        imageUrls.add(downloadUrl);
      }
    } catch (e) {
      // Handle errors
      Utils().toastMessage('Error uploading images to Firebase Storage: $e');
      logger.i('Error uploading images to Firebase Storage: $e');
    }

    return imageUrls;
  }

  Future<List<String>> uploadImagesToFirebaseStorage1() async {
    List<String> imageUrls = [];

    try {
      String userEmail = widget.email;

      for (String imagePath in imagePaths) {
        // Use your own logic to get a unique filename
        String filename = DateTime.now().millisecondsSinceEpoch.toString();
        Reference storageReference = FirebaseStorage.instance
            .ref()
            .child('productImages/$userEmail/$filename.jpg');

        UploadTask uploadTask = storageReference.putFile(File(imagePath));
        TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

        // Get the download URL of the uploaded image
        String downloadUrl = await taskSnapshot.ref.getDownloadURL();
        imageUrls.add(downloadUrl);
        Utils().toastMessage('Product Added to Database');
        logger.i('Product Added to Database');
        Get.to(() => ProductHomeScreen(email: widget.email));
      }
    } catch (e) {
      // Handle errors
      Utils().toastMessage('Error uploading images to Firebase Storage: $e');
      logger.i('Error uploading images to Firebase Storage: $e');
    }

    return imageUrls;
  }
}
