import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:msoko_seller/common/utils.dart';
import 'package:msoko_seller/views/product_screen/chat_screen.dart/msg_model.dart';
import 'package:msoko_seller/views/product_screen/model/product_model.dart';
import 'package:msoko_seller/views/product_screen/model/user_model.dart';

class MessageType {
  static const int normaltext = 0;
  static const int banner = 1;
}

class ChatService extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendMessage(
    String sellerId,
    String sellerEmail,
    String sellerUsername,
    String message,
    int? msgType,
    ProductModel? productModel,
  ) async {
    final String currentUserId =
        UserDataService().userModel?.uid.toString() ?? '';
    final String currentUserEmail =
        UserDataService().userModel?.email.toString() ?? '';
    final Timestamp timestamp = Timestamp.now();

    Message newMessage = Message(
      productId: productModel?.productId ?? '',
      buyerId: currentUserId,
      buyerEmail: currentUserEmail,
      sellerId: sellerId,
      sellerEmail: sellerEmail,
      message: message,
      timestamp: timestamp,
      imageUrl: productModel?.itemThumbnail ?? '',
      messageType: msgType ?? 0,
    );

    List<String> ids = [currentUserEmail, sellerEmail];
    ids.sort();
    String chatRoomId = ids.join("_");

    final existingDoc = await _firestore
        .collection(FirestoreCollections.productsChatRoom)
        .doc(chatRoomId)
        .get();

    if (!existingDoc.exists) {
      await _firestore
          .collection(FirestoreCollections.productsChatRoom)
          .doc(chatRoomId)
          .set({
        'chatRoomId': chatRoomId,
        'buyerEmail': currentUserEmail,
        'sellerEmail': sellerEmail,
        'sellerId': sellerId,
        'sellerUsername': sellerUsername,
      });
    }

    await _firestore
        .collection(FirestoreCollections.productsChatRoom)
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  Stream<QuerySnapshot> getMessages(
      String currentUserEmail, String otherUserEmail) {
    List<String> ids = [currentUserEmail, otherUserEmail];
    ids.sort();
    String chatRoomId = ids.join("_");
    return _firestore
        .collection(FirestoreCollections.productsChatRoom)
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
