import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/chat/messages.dart';
import '../widgets/chat/new_message.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //streamBuilder widget rebuild whenever stream updates (not rebuild ui just evaluate what data needs to update)
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Messages(),
            ),
            NewMessage()
          ],
        ),
      ),
      //adding dummy data
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: () {
      //     FirebaseFirestore.instance
      //         .collection('chats/f15w53dnwChahX8oTroD/messages')
      //         .add({
      //       'text': 'This is text is added by clicking button',
      //     });
      //   },
      // ),
    );
  }
}
