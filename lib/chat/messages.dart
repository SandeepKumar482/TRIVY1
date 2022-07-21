import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trivy/Profile.dart';
import 'package:trivy/chat/message_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trivy/edit.dart';
import 'package:trivy/trivyTech.dart';

class Messages extends StatelessWidget {
  String recevieId;
  Messages(this.recevieId);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser.getIdToken(),
      builder: (context, futureSnapshot) {
        if (futureSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('chat')
                .where("match", whereIn: [
                  ServiceApp.auth.currentUser.uid + "-" + recevieId,
                  recevieId + "-" + ServiceApp.auth.currentUser.uid
                ])
                .orderBy(
                  'createdAt',
                  descending: true,
                )
                .snapshots(),
            builder: (context, chatSnapshot) {
              if (chatSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                final chatDocs = chatSnapshot.data.documents;
                return ListView.builder(
                  reverse: true,
                  itemCount: chatDocs.length,
                  itemBuilder: (context, index) => MessageStyle(
                    chatDocs[index]['text'],
                    chatDocs[index]['firstName'],
                    chatDocs[index]['userId'] ==
                        ServiceApp.auth.currentUser.uid,
                    key: ValueKey(chatDocs[index].documentID),
                  ),
                );
              }
            });
      },
    );
  }

}