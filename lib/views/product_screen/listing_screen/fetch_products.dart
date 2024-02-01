import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:msoko_seller/common/constant.dart';

class Product {
  final String sellerSkuID;
  final String itemMrp;
  final String sellPrice;
  final String stock;
  final String itemOrderCount;
  final String itemShippingChargelocal;
  final String itemShippingChargezonal;
  final String itemShippingChargenational;
  final String pkgWeight;
  final String pkgSize;
  final String hsn;
  // final String isActive;
  final String taxCode;
  final String countryOrigin;
  final String mfgDetails;
  final String packerDetails;
  final String importerDetails;
  final String itemName;
  final String salesPkg;
  final String keywords;
  final List<String> itemImages;

  Product({
    required this.sellerSkuID,
    required this.itemMrp,
    required this.sellPrice,
    required this.stock,
    required this.itemOrderCount,
    required this.itemShippingChargelocal,
    required this.itemShippingChargezonal,
    required this.itemShippingChargenational,
    required this.pkgWeight,
    required this.pkgSize,
    required this.hsn,
    // required this.isActive,
    required this.taxCode,
    required this.countryOrigin,
    required this.mfgDetails,
    required this.packerDetails,
    required this.importerDetails,
    required this.itemName,
    required this.salesPkg,
    required this.keywords,
    required this.itemImages,
  });

  // Factory method to create a Product instance from a Firestore document
  factory Product.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Product(
      sellerSkuID: data['sellerSkuID'],
      itemMrp: data['itemMrp'],
      sellPrice: data['sellPrice'],
      stock: data['stock'],
      itemOrderCount: data['itemOrderCount'],
      itemShippingChargelocal: data['itemShippingChargelocal'],
      itemShippingChargezonal: data['itemShippingChargezonal'],
      itemShippingChargenational: data['itemShippingChargenational'],
      pkgWeight: data['pkgWeight'],
      pkgSize: data['pkgSize'],
      hsn: data['hsn'],
      // isActive: data['isActive'],
      taxCode: data['taxCode'],
      countryOrigin: data['countryOrigin'],
      mfgDetails: data['mfgDetails'],
      packerDetails: data['packerDetails'],
      importerDetails: data['importerDetails'],
      itemName: data['itemName'],
      salesPkg: data['salesPkg'],
      keywords: data['keywords'],
      itemImages: List<String>.from(data['itemImages']),
    );
  }
}

Future<List<Product>> fetchDataFromFirebase(String userEmail) async {
  try {
    logger.i('data fetching started');

    // Retrieve data from Firestore
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('products')
        .where('email', isEqualTo: userEmail)
        .get();

    if (querySnapshot.size > 0) {
      // Map the documents to a list of Product instances
      List<Product> products =
          querySnapshot.docs.map((doc) => Product.fromFirestore(doc)).toList();
      logger.i(products.length);

      return products;
    } else {
      // No data found
      logger.i('No data found for the user in Firestore.');
      return [];
    }
  } catch (e) {
    // Handle errors
    logger.i('Error fetching data from Firestore: $e');
    return [];
  }
}
