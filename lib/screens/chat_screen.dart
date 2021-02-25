import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (_, i) => Container(
          padding: EdgeInsets.all(8.0),
          child: Text('This works!'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Firestore.instance
              .collection('chats/ZWSrfh6YgSyKJ3ke0JKs/messages')
              .snapshots()
              .listen((data) {
            data.documents.forEach((document) {
              print(document['text']);
            });
          });
        },
      ),
    );
  }
}
