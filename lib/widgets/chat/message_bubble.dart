import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final Key key;
  MessageBubble({required this.message, required this.isMe, required this.key});

  @override
  Widget build(BuildContext context) {
    final borderds = Radius.elliptical(6, 4);
    final borderdscr = Radius.circular(20);
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
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
                bottomLeft: isMe ? Radius.elliptical(2, 2) : borderdscr,
                bottomRight: isMe ? borderdscr : Radius.elliptical(2, 2),
              ),
              border: Border.all(
                  width: 1,
                  color: Theme.of(context).primaryColor,
                  strokeAlign: 2)),
          child: Text(
            message,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
