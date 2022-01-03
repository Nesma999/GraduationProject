import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class messageBubble extends StatelessWidget {
  @override
  const messageBubble(this.message, this.name, this.imageurl, this.isMe,
      {this.key});

  final Key key;
  final String message;
  final String name;
  final String imageurl;
  final bool isMe;

  Widget build(BuildContext context) {

    return Stack(
      children: [
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: isMe ? Colors.grey[300] : Colors.red,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(14),
                    topRight: Radius.circular(14),
                    bottomLeft:
                        !isMe ? Radius.circular(4) : Radius.circular(14),
                    bottomRight:
                        !isMe ? Radius.circular(4) : Radius.circular(14)),
              ),
              width: 140,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              margin: EdgeInsets.symmetric(vertical: 14, horizontal: 8),
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isMe
                          ? Colors.black
                          : Theme.of(context).accentTextTheme.headline6.color,
                    ),
                  ),
                  Text(
                    message,
                    style: TextStyle(
                      color: isMe
                          ? Colors.black
                          : Theme.of(context).accentTextTheme.headline6.color,
                    ),
                    textAlign: isMe ? TextAlign.end : TextAlign.start,
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
            top: 0,
            left: isMe ? 238 : null,
            right: !isMe ? 238 : null,
            child: CircleAvatar(
              backgroundImage: NetworkImage(imageurl),
            )),
      ],
    );
  }
}
