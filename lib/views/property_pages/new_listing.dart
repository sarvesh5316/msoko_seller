// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:msoko_seller/auth/sign_up.dart';
import 'package:msoko_seller/common/constant.dart';
import 'package:msoko_seller/common/plain_text.dart';
import 'package:msoko_seller/common/rounded_button.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:msoko_seller/views/property_pages/SELECTION.dart';
import 'package:msoko_seller/views/property_pages/camera.dart';
import 'package:msoko_seller/views/property_pages/maps.dart';
import 'package:msoko_seller/views/property_pages/nl_confirmation_page.dart';
import 'package:msoko_seller/views/property_pages/service_selection_property.dart';

// ignore: must_be_immutable
class NewListing extends StatefulWidget {
  String email;
  NewListing({super.key, required this.email});

  @override
  State<NewListing> createState() => _NewListingState();
}

class _NewListingState extends State<NewListing>
    with SingleTickerProviderStateMixin {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late TabController tabController;

  final List<File> _imageList = [];
  String status = "";
  String selectedBankName = "";
  String agentPropertyUID = "";
  bool? loanAvailable;
  List<String> servicesOffered = [];
  LatLng? locationPoint;
  String maptext = "Select";
  String mapSelectSuccess = "";
  List<List<String>> bankList = SELECTION.fetchBanksList();
  Map<String, dynamic> fields = {};
  List<String> necessaryFields = [
    "Category",
    "Listing Status",
    "Locality",
    "Plot Number",
    "Map Location",
    "Property Type",
    "Covered Area (sqft)",
    "Water Availablity",
    "Electricity Availablity",
    "Disclaimer",
    "Rera ID",
    "Selling Price (TZS)",
    "Title",
    "Description",
    "Bank",
    "Post By",
    "Agent Name",
    "Contact Number",
    "Services"
  ];
  Map<String, dynamic> propertyTypeOptions = {
    'Flat': [
      "No. of Room",
      "No. of Bedroom",
      "No. of Bathroom",
      "No. of Living Room",
      "No. of Kitchen",
    ],
    'House': [
      "No. of Room",
      "No. of Bedroom",
      "No. of Bathroom",
      "No. of Living Room",
      "No. of Kitchen",
    ],
    'Plot': ["No. of Room", "No. of Trees", "No. of Water Outlets"],
    'Office Space': [
      "No. of Cabins",
      "No. of Cubicles",
      "No. of Cafe",
      "No. of Rest Room",
      "No. of Garden",
    ],
    'Other': ["Your Property Type"],
  };

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
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
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: whiteColor,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            TabBar(
              controller: tabController,
              tabs: const [
                Tab(
                  child: Center(
                    child: Text(
                      "Product Image",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Tab(
                  child: Center(
                    child: Text(
                      "Property Details",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
              dividerColor: Colors.transparent,
              labelColor: const Color(0xFF08215E),
              indicator: const UnderlineTabIndicator(
                borderSide: BorderSide(width: 2.0, color: Colors.amber),
                insets: EdgeInsets.symmetric(horizontal: -16.0),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
                child: TabBarView(controller: tabController, children: [
              SingleChildScrollView(
                  child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        border: Border.all(
                      width: 1,
                      style: BorderStyle.solid,
                    )),
                    child: Image.asset(
                      "assets/images/property.png",
                      fit: BoxFit.contain,
                      height: 200,
                      width: screenWidth,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: SizedBox(
                      width: screenWidth * 0.7,
                      child: RoundedButton(
                        onTap: () {
                          _showImageSourceOptions();
                        },
                        buttonColor: const Color.fromRGBO(15, 98, 223, 1),
                        textColor: Colors.white,
                        fontsize: 17,
                        radius: 30,
                        title: "Upload Photo",
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: [
                      ..._imageList.map((image) {
                        return Container(
                          width: 60.0,
                          height: 60.0,
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 1,
                                color: const Color.fromARGB(255, 104, 104, 104),
                                style: BorderStyle.solid),
                          ),
                          child: Image.file(image),
                        );
                      }).toList(),
                      InkWell(
                        onTap: () {
                          _showImageSourceOptions();
                        },
                        child: Container(
                          width: 60.0,
                          height: 60.0,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 184, 184, 184),
                            border: Border.all(
                                width: 1,
                                color: const Color.fromARGB(255, 104, 104, 104),
                                style: BorderStyle.solid),
                          ),
                          child: const Icon(
                            Icons.add_a_photo,
                            color: Color.fromARGB(255, 104, 104, 104),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Image Resolution",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          "Use clear color image with minimum resolution of 500X600 px",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 85, 85, 85),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        const Text(
                          "Follow Image Guidelines to reduce the Quality Check failures",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          "Lorem ipsum dolor sit amet consectetur adipisicing elit. Facere expedita quibusdam assumenda explicabo omnis totam? Voluptatem tenetur nisi error beatae veniam, illo velit eaque quidem, quam ratione quaerat repudiandae placeat.",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 85, 85, 85),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Lorem ipsum dolor sit amet consectetur adipisicing elit. Facere expedita quibusdam assumenda explicabo omnis totam? Voluptatem tenetur nisi error beatae veniam, illo velit eaque quidem, quam ratione quaerat repudiandae placeat.",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 85, 85, 85),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Lorem ipsum dolor sit amet consectetur adipisicing elit. Facere expedita quibusdam assumenda explicabo omnis totam? Voluptatem tenetur nisi error beatae veniam, illo velit eaque quidem, quam ratione quaerat repudiandae placeat.",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 85, 85, 85),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Lorem ipsum dolor sit amet consectetur adipisicing elit. Facere expedita quibusdam assumenda explicabo omnis totam? Voluptatem tenetur nisi error beatae veniam, illo velit eaque quidem, quam ratione quaerat repudiandae placeat.",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 85, 85, 85),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        RoundedButton(
                            title: "Confirm and Next",
                            borderColor:
                                const Color.fromRGBO(15, 98, 223, 0.867),
                            textColor: Colors.white,
                            radius: 0,
                            onTap: () {
                              tabController.animateTo(1);
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              )),
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Text(
                          "Category",
                          style: TextStyle(
                              color: Color.fromARGB(255, 114, 114, 114)),
                        ),
                        Text(
                          "*",
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    fieldDropdown("Category",
                        ['Buy', 'Rent', 'PG', 'Commercial', 'Project'], true),
                    const Row(
                      children: [
                        Text(
                          "Listing Status",
                          style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "*",
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        statusSelector("Active"),
                        const SizedBox(width: 15),
                        statusSelector("Inactive"),
                      ],
                    ),
                    lightTextPrint("Property Details"),
                    fieldText("Locality", "Enter your locality",
                        TextInputType.text, true),
                    fieldText("Plot Number", "Enter Plot Number",
                        TextInputType.text, true),
                    const Row(
                      children: [
                        Text(
                          "Select location on Maps",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "*",
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      //Map
                      padding: const EdgeInsets.only(left: 5),
                      decoration: BoxDecoration(
                          color: (mapSelectSuccess != "")
                              ? const Color.fromARGB(255, 228, 228, 228)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(30)),
                      child: Row(
                        children: [
                          ElevatedButton(
                            style: const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                Color.fromRGBO(33, 150, 243, 1),
                              ),
                            ),
                            onPressed: () async {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return const AlertDialog(
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CircularProgressIndicator(),
                                        SizedBox(height: 16.0),
                                        Text("Loading Maps"),
                                      ],
                                    ),
                                  );
                                },
                              );
                              Position currentLocation =
                                  await _determinePosition();
                              locationPoint = await Get.to<LatLng>(
                                () => MapPage(
                                  currentPosition: currentLocation,
                                  task: "Select Locality / Landmark",
                                ),
                              );
                              if (locationPoint != null) {
                                GeoPoint geoPoint = GeoPoint(
                                    locationPoint!.latitude,
                                    locationPoint!.longitude);
                                setState(() {
                                  fields['Map Location'] = geoPoint;
                                  maptext = "Re-select";
                                  mapSelectSuccess = "Successfully Selected";
                                });
                              }

                              Navigator.of(context).pop();
                            },
                            child: Text(
                              maptext,
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          if (mapSelectSuccess != "")
                            const SizedBox(
                              width: 20,
                            ),
                          if (mapSelectSuccess != "") Text(mapSelectSuccess),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    fieldDropdown(
                        "Property Type",
                        ['Flat', 'House', 'Plot', 'Office Space', 'Other'],
                        true),
                    if (fields['Property Type'] != null)
                      Column(
                        children: [
                          if (fields['Property Type'] != "Other")
                            ...propertyTypeOptions[fields['Property Type']]
                                .map((String option) {
                              return fieldText(
                                  option, "", TextInputType.number, false);
                            }).toList(),
                          if (fields['Property Type'] == "Other")
                            fieldText(
                                "Your Property Type",
                                "Enter your proprty type",
                                TextInputType.text,
                                false),
                          ElevatedButton(
                            style: const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                Color.fromRGBO(33, 150, 243, 1),
                              ),
                            ),
                            onPressed: () {
                              addMoreFieldPopup();
                            },
                            child: const Text(
                              "Add more fields",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    const SizedBox(height: 13),
                    fieldText("Covered Area (sqft)", "Property Covered Area",
                        TextInputType.number, true),
                    fieldText("Water Availablity", "Water Availablity per Day",
                        TextInputType.number, true),
                    fieldText(
                        "Electricity Availablity",
                        "Electricity Availablity per Day",
                        TextInputType.number,
                        true),
                    fieldText("Disclaimer", "Disclaimer of Property",
                        TextInputType.text, true),
                    fieldText("Rera ID", "Rera ID", TextInputType.text, true),
                    lightTextPrint("Price Details"),
                    fieldText("Selling Price (TZS)", "Property Selling Price",
                        TextInputType.number, true),
                    lightTextPrint("Add Title Details"),
                    fieldText(
                        "Title", "Property Title", TextInputType.text, true),
                    fieldText("Description", "Property Description",
                        TextInputType.text, true),
                    lightTextPrint("Check Loan Availability"),
                    SizedBox(
                      // Show Bank Options
                      height: 50,
                      width: screenWidth * 0.5,
                      child: RoundedButton(
                          title: "Select Bank",
                          buttonColor: Colors.blue,
                          textColor: Colors.white,
                          fontsize: 16,
                          radius: 0,
                          onTap: () async {
                            await _showBanksOptions();
                            setState(() {
                              loanAvailable = loanAvailable;
                              fields['Bank'] = selectedBankName;
                            });
                          }),
                    ),
                    Column(
                      // Loan Availability Radio Button
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Radio(
                              value: true,
                              groupValue: loanAvailable,
                              onChanged: (value) {},
                            ),
                            const Text(
                              "Available",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              value: false,
                              groupValue: loanAvailable,
                              onChanged: (value) {},
                            ),
                            const Text(
                              "Unavailable",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                    lightTextPrint("Service Details"),
                    Wrap(
                      // Service List Print + Add
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        ...servicesOffered
                            .map((service) => ServiceItem(service: service)),
                        InkWell(
                          onTap: () async {
                            // ignore: unused_local_variable
                            final updatedServices =
                                await showModalBottomSheet<List<String>>(
                              context: context,
                              builder: (BuildContext context) {
                                return ServicesOfferedProperty(
                                  initialSelectedServices: servicesOffered,
                                  onSelectionChanged: (updatedSelection) {
                                    setState(() {
                                      servicesOffered = updatedSelection;
                                    });
                                  },
                                );
                              },
                            );
                            setState(() {
                              fields['Services'] = servicesOffered;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: const Text(
                              "+ ADD",
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 13),
                    fieldText("Post By", "Property Posting Organization",
                        TextInputType.text, true),
                    fieldText(
                        "Agent Name", "Agent Name", TextInputType.text, true),
                    fieldText("Contact Number", "Agent Contact Number",
                        TextInputType.number, true),
                    const SizedBox(height: 24),
                    RoundedButton(
                        title: "Send to QC",
                        buttonColor: Colors.blue,
                        textColor: Colors.white,
                        fontsize: 19,
                        radius: 0,
                        onTap: () {
                          addPropertyListing();
                          logger.i(fields);
                        }),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ]))
          ],
        ),
      ),
    );
  }

  Future<List<String>> addImagesToStorage() async {
    List<String> downloadUrls = [];
    final Reference storageRef = FirebaseStorage.instance
        .ref()
        .child('property_listing_images')
        .child('listing_images');
    for (File imageFile in _imageList) {
      String fileName =
          '${DateTime.now().millisecondsSinceEpoch}_${imageFile.path.split('/').last}';
      Reference fileRef = storageRef.child(fileName);
      await fileRef.putFile(imageFile);
      String downloadUrl = await fileRef.getDownloadURL();
      downloadUrls.add(downloadUrl);
    }
    return downloadUrls;
  }

  void addPropertyListing() async {
    bool containsAllKeys =
        necessaryFields.every((key) => fields.containsKey(key));
    if (containsAllKeys && _imageList.isNotEmpty) {
      showDialog(
        barrierColor: const Color.fromARGB(113, 0, 0, 0),
        context: context,
        barrierDismissible:
            false, // Prevent users from tapping outside to close the dialog
        builder: (BuildContext context) {
          return const Center(
            child: SizedBox(
              height: 40,
              width: 40,
              child: CircularProgressIndicator(),
            ),
          );
        },
      );
      // -------------------------------------------------------------
      // ----------------------ADDING IMAGE URLs----------------------
      // -------------------------------------------------------------
      List<String> imageURLArray = await addImagesToStorage();
      fields['Images'] = imageURLArray;
      fields['Post Date'] = DateTime.now();
      // -------------------------------------------------------------
      // -------------------------------------------------------------
      agentPropertyUID = '${DateTime.now().millisecondsSinceEpoch}';
      fields['Agent UID'] = agentPropertyUID;
      fields['Quality Check'] = false;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.email)
          .get()
          .then((value) {
        if (status == 'Active') {
          FirebaseFirestore.instance
              .collection('users')
              .doc(widget.email)
              .update({
            'Property Active': value['Property Active'] + 1,
          });
        } else {
          FirebaseFirestore.instance
              .collection('users')
              .doc(widget.email)
              .update({
            'Property Inactive': value['Property Inactive'] + 1,
          });
        }
      });
      String docID = '${DateTime.now().millisecondsSinceEpoch}';

      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.email)
          .collection('Seller_Property')
          .doc(docID)
          .set(fields);

      fields['Email'] = widget.email;
      await FirebaseFirestore.instance
          .collection('property_items')
          .doc(docID)
          .set(fields);

      Navigator.of(context).pop();
      Get.off(NewListingConfirmationPage(
        docID: docID,
        email: widget.email,
      ));
    } else {
      Fluttertoast.showToast(
        msg: 'Please fill all fields',
        backgroundColor: Colors.grey,
      );
    }
  }

  Widget statusSelector(String feature) {
    bool isSelected = status == feature;

    return GestureDetector(
      onTap: () {
        setState(() {
          status = feature;
          fields['Listing Status'] = feature;
        });
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        width: MediaQuery.sizeOf(context).width * 0.3,
        height: 42,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: isSelected ? Colors.blue : Colors.grey,
          ),
          // borderRadius: BorderRadius.circular(10),
          color: isSelected ? Colors.blue : Colors.transparent,
        ),
        child: Center(
          child: Text(
            feature,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: isSelected ? Colors.white : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final imagePicker = ImagePicker();
      final pickedFile = await imagePicker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _imageList.add(File(pickedFile.path));
        });
      }
      Navigator.of(context)
          .pop(); // Close the bottom sheet after picking an image
    } catch (e) {
      logger.i("---------------$e------------------");
    }
  }

  void _showImageSourceOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: [
            Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.close_rounded,
                        size: 25,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: Column(
                    children: [
                      const Center(
                          child: Text(
                        "Upload a picture of your property",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      )),
                      const SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () async {
                                File? selectedImage = await Get.to<File>(
                                  () => const CameraPage(),
                                );
                                if (selectedImage != null) {
                                  setState(() {
                                    _imageList.add(File(selectedImage.path));
                                  });
                                }
                                // Get.to(CameraPage());
                                Navigator.of(context).pop();
                              },
                              child: const Column(
                                children: [
                                  Icon(
                                    Icons.photo_camera,
                                    color: Colors.blue,
                                    size: 32,
                                  ),
                                  Text(
                                    'Camera',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                _pickImage(ImageSource.gallery);
                              },
                              child: const Column(
                                children: [
                                  Icon(Icons.photo,
                                      color: Colors.blue, size: 32),
                                  Text(
                                    'Gallery',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Future<void> _showBanksOptions() {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 8, 8, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Select Banks",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600)),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.close_rounded,
                        size: 25,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: bankList.length,
                  itemBuilder: (context, index) {
                    final bankName = bankList[index];
                    return Row(
                      children: [
                        Checkbox(
                          value: selectedBankName == bankName[0],
                          onChanged: (value) {
                            if (value!) {
                              setState(() {
                                selectedBankName = bankName[0];
                              });
                              if (bankName[1] == "Available") {
                                setState(() {
                                  loanAvailable = true;
                                });
                              } else {
                                setState(() {
                                  loanAvailable = false;
                                });
                              }
                            }
                          },
                        ),
                        Text(bankName[0],
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w400)),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        });
      },
    );
  }

  Future<Position> _determinePosition() async {
    late Position currentPosition;
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // ignore: avoid_print
      print('Please enable Your Location Service');
      Fluttertoast.showToast(
        msg: 'Please enable Your Location Service',
        backgroundColor: Colors.grey,
      );
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // ignore: avoid_print
        print('Location permissions are denied');
        Fluttertoast.showToast(
          msg: 'Location permissions are denied',
          backgroundColor: Colors.grey,
        );
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // ignore: avoid_print
      print(
          'Location permissions are permanently denied, we cannot request permissions.');
      // ignore: avoid_print
      print(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    currentPosition = await Geolocator.getCurrentPosition();
    return currentPosition;
  }

  Widget fieldDropdown(String fieldName, List<String> options, bool required) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (fieldName != "Category")
          Row(
            children: [
              Text(
                fieldName,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              if (required)
                const Text(
                  "*",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.red),
                ),
            ],
          ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color.fromARGB(255, 224, 224, 224),
          ),
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              DropdownButton<String>(
                onTap: () {
                  if (fields.containsKey('Property Type')) {
                    fields.remove('Property Type');
                  }
                },
                borderRadius: BorderRadius.circular(10),
                value: fields[fieldName],
                items: options.map((String option) {
                  return DropdownMenuItem<String>(
                    value: option,
                    child: Text(option),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    fields[fieldName] = value;
                  });
                },
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                underline: Container(),
                isExpanded: true,
                icon: const Icon(Icons.arrow_drop_down),
                hint: const Text(
                  "Select",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }

  Widget fieldText(String fieldName, String fieldPlaceHolder,
      TextInputType inputType, bool required) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              fieldName,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            if (required)
              const Text(
                "*",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.red),
              ),
          ],
        ),
        const SizedBox(
          height: 7,
        ),
        TextField(
          onChanged: (value) {
            if (necessaryFields.contains(fieldName)) {
              setState(() {
                fields[fieldName] = value;
              });
            } else {
              if (fields.containsKey("Features")) {
                setState(() {
                  fields['Features'][fieldName] = value;
                });
              } else {
                setState(() {
                  fields['Features'] = {fieldName: value};
                });
              }
            }
          },
          keyboardType: inputType,
          decoration: InputDecoration(
              hintText: fieldPlaceHolder,
              hintStyle:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
              contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              border: OutlineInputBorder(
                borderSide: const BorderSide(width: 1),
                borderRadius: BorderRadius.circular(10),
              )),
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }

  Widget lightTextPrint(String text) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(
          text,
          style: const TextStyle(color: Color.fromARGB(255, 114, 114, 114)),
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }

  void addMoreFieldPopup() {
    String val = "";
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Enter Title',
                  style: TextStyle(fontSize: 17),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.close_rounded))
              ],
            ),
            content: Wrap(
              children: [
                TextField(
                  onChanged: (value) {
                    val = value;
                  },
                  decoration: InputDecoration(
                      hintStyle: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.normal),
                      contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(width: 1),
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
                const SizedBox(
                  height: 20,
                  width: 20,
                ),
                ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                      Color.fromRGBO(33, 150, 243, 1),
                    ),
                  ),
                  onPressed: () async {
                    if (fields.containsKey(val) == false) {
                      setState(() {
                        propertyTypeOptions[fields['Property Type']].add(val);
                      });
                      Navigator.of(context).pop();
                    } else {
                      Fluttertoast.showToast(
                        msg: 'Field already exists',
                        backgroundColor: Colors.grey,
                      );
                    }
                  },
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    child: const Text(
                      "Create",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class ServiceItem extends StatefulWidget {
  final String service;

  const ServiceItem({super.key, required this.service});

  @override
  State<ServiceItem> createState() => _ServiceItemState();
}

class _ServiceItemState extends State<ServiceItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 202, 202, 202),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        widget.service,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}
