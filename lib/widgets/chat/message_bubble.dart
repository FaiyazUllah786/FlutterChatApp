import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final String userId;
  final String timeStamp;
  final String userImage;
  final Key key;
  MessageBubble(
      {required this.message,
      required this.isMe,
      required this.userId,
      required this.timeStamp,
      required this.userImage,
      required this.key});

  @override
  Widget build(BuildContext context) {
    final borderds = Radius.elliptical(6, 4);
    final borderdscr = Radius.circular(20);
    return Stack(
      children: [
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(12),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: isMe
                      ? Theme.of(context).primaryColorDark.withOpacity(0.5)
                      : Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: borderdscr,
                    topRight: borderdscr,
                    bottomLeft: isMe ? borderdscr : Radius.elliptical(2, 2),
                    bottomRight: isMe ? Radius.elliptical(2, 2) : borderdscr,
                  ),
                  border: Border.all(
                      width: 1,
                      color: Theme.of(context).primaryColor,
                      strokeAlign: 2)),
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('user')
                        .doc(userId)
                        .get(),
                    builder: (ctx, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text('Loading....');
                      }
                      return Text(
                        snapshot.data?['user'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColorDark,
                        ),
                      );
                    },
                  ),
                  Text(
                    message,
                    style: TextStyle(fontSize: 18),
                    textAlign: isMe ? TextAlign.end : TextAlign.start,
                  ),
                  Text(timeStamp)
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: -10,
          right: isMe ? 50 : null,
          left: isMe ? null : 50,
          child: CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(userImage),
          ),
        ),
      ],
      clipBehavior: Clip.none,
    );
  }
}
