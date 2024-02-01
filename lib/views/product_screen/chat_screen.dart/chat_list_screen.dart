import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:msoko_seller/common/utils.dart';
import 'package:msoko_seller/views/product_screen/chat_screen.dart/chat_screen.dart';
import 'package:msoko_seller/views/product_screen/model/user_model.dart';

class ChatListScreen extends StatefulWidget {
  final String email;
  const ChatListScreen({super.key, required this.email});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final String currentUserId =
      UserDataService().userModel?.uid?.toString() ?? '';
  final String currentUserEmail1 =
      UserDataService().userModel?.email.toString() ?? '';
  late String currentUserEmail;

  @override
  void initState() {
    super.initState();
    currentUserEmail = widget.email;
  }

  // final String currentUserId = UserDataService().userModel!.uid.toString();
  // final String currentUserId = UserDataService().userModel!.uid.toString();
  // final String currentUserEmail = UserDataService().userModel!.email.toString();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildUserList(),
    );
  }

  // buld a list of sellers
  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection(FirestoreCollections.productsChatRoom)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Error');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Utils1.customLoadingSpinner(),
          );
        }
        return ListView(
          children: snapshot.data!.docs
              .map<Widget>((doc) => _buildUserListItem(doc))
              .toList(),
        );
      },
    );
  }

// build individual chat list items
  Widget _buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> chatRoom = document.data() as Map<String, dynamic>;

    if (chatRoom['buyerEmail'] == currentUserEmail) {
      String sellerEmail = chatRoom['sellerEmail'];
      String sellerId = chatRoom['sellerId'];
      String sellerUsername = chatRoom['sellerUsername'];

      return ListTile(
        leading: const Icon(Icons.person),
        title: Text(sellerUsername),
        onTap: () {
          // pass the clicked users uid to the chat page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatScreen(
                sellerUserEmail: sellerEmail,
                sellerUserID: sellerId,
                sellerUserName: sellerUsername,
              ),
            ),
          );
        },
      );
    } else {
      // If buyerEmail doesn't match, return an empty container or null
      return Container(); // or return null;
    }
  }
}
