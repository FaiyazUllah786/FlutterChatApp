import 'package:chatapp/widgets/chat/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatDocs = snapshot.data!.docs;
        final user = FirebaseAuth.instance.currentUser;
        // final String date = DateFormat.Hm().format(chatDocs[i]['createdAt'].toDate());
        return ListView.builder(
            reverse: true,
            itemCount: chatDocs.length,
            itemBuilder: (ctx, i) => MessageBubble(
                  message: chatDocs[i]['text'],
                  isMe: chatDocs[i]['userId'] == user!.uid,
                  key: ValueKey(chatDocs[i].id),
                  //firestore method(toDate()) to convert timestamp to date
                  timeStamp: DateFormat('HH:mm')
                      .format(chatDocs[i]['createdAt'].toDate()),
                  userId: chatDocs[i]['userId'],
                  userImage: chatDocs[i]['userImage'],
                ));
      },
    );
  }
}
