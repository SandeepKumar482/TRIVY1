import 'package:flutter/material.dart';
import 'package:trivy/MyWallet.dart';
import 'package:trivy/appColor.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trivy/chat/messages.dart';
import 'package:trivy/chat/new_message.dart';

// ignore: must_be_immutable
class ChatScreen extends StatelessWidget {
   String receiveId;
  static const String id = 'chat';
  ChatScreen(this.receiveId);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.c2,
      appBar: AppBar(
        backgroundColor: AppColor.c1,
        title: Text('Chat with your seeker/picker'),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Messages(receiveId),
            ),
            NewMessage(receiveId),
          ],
        ),
      ),
    );
  }
}
