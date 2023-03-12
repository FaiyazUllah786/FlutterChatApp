import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //streamBuilder widget rebuild whenever stream updates (not rebuild ui just evaluate what data needs to update)
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chats/f15w53dnwChahX8oTroD/messages')
            .snapshots(),
        builder: (ctx, streamSnapshot) {
          //if no data is present length of itemcount will become null causing error
          //thus this condition helps in this scenario
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          //getting data in variable
          final documents = streamSnapshot.data!.docs;
          return ListView.builder(
            itemCount: streamSnapshot.data?.docs.length,
            itemBuilder: (ctx, i) => Container(
              height: 80,
              child: Center(
                child: Text('${documents[i]['text']}'),
              ),
            ),
          );
        },
      ),
      //adding dummy data
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          FirebaseFirestore.instance
              .collection('chats/f15w53dnwChahX8oTroD/messages')
              .add({
            'text': 'This is text is added by clicking button',
          });
        },
      ),
    );
  }
}
