import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './message_bubbel.dart';

class Messages extends StatelessWidget {
  const Messages({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseAuth.instance.currentUser(),
        builder: (_, futureSnapshot) {
          if (futureSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return StreamBuilder(
            stream: Firestore.instance
                .collection('chat')
                .orderBy(
                  'createdAt',
                  descending: true,
                )
                .snapshots(),
            builder: (_, chatSnapshot) {
              if (chatSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final chatDocuments = chatSnapshot.data.documents;
              return ListView.builder(
                reverse: true,
                itemCount: chatDocuments.length,
                itemBuilder: (_, index) {
                  return MessageBubble(
                    chatDocuments[index]['text'],
                    chatDocuments[index]['username'],
                    chatDocuments[index]['userId'] == futureSnapshot.data.uid,
                    key: ValueKey(chatDocuments[index].documentID),
                  );
                },
              );
            },
          );
        });
  }
}
