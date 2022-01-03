import 'package:Conneect_Firebase/modules/messages/message.dart';
import 'package:Conneect_Firebase/modules/messages/new_message.dart';
import 'package:Conneect_Firebase/modules/posts.dart';
import 'package:flutter/material.dart';

class Chat11 extends StatefulWidget {
  _Chat11State createState() => _Chat11State();
}
 class _Chat11State extends State<Chat11> {




  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
        backgroundColor: Colors.red,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MyHomePage(),
                ));
          },
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: message(),
            ),
            newMessage(),
          ],
        ),
      ),

    );
  }


}
class SimpleDialog extends StatelessWidget {
  final title;
  SimpleDialog(this.title);
  Color g2 = Color.fromRGBO(93, 96, 99, 1);
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 20,
      ),
    );
  }
}

/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gp/utilities/constants.dart';


final _firestore = FirebaseFirestore.instance;
User loggedInUser;

class Chatscreen extends StatefulWidget {
  static String id = 'chat_screen';

  @override
  _ChatscreenState createState() => _ChatscreenState();
}

class _ChatscreenState extends State<Chatscreen> {
  final _auth = FirebaseAuth.instance;
  final messageTextController = TextEditingController();

  String messageText;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }


  void messagesStream() async {
    await for (var snapshot in _firestore.collection('modules.messages').snapshots()) {
      for (var message in snapshot.docs) {
        print(message.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,

        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessageStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      //Implement send functionality.
                      messageTextController.clear();
                      var date = DateTime.now();
                      _firestore.collection('modules.messages').add({
                        'text': messageText,
                        'sender': loggedInUser.email,
                        'timeStamp': date.toUtc().millisecondsSinceEpoch
                      });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('modules.messages')
          .orderBy('timeStamp', descending: false)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final modules.messages = snapshot.data.docs.reversed;
          List<Widget> messageBubbles = [];
          for (var message in modules.messages) {
            final messageText = message.data()['text'];
            final messageSender = message.data()['sender'];
            final messageTime = message.data()['timeStamp'];

            final currentUser = loggedInUser.email;

            var dateTime = DateTime.fromMillisecondsSinceEpoch(messageTime);

            final messageBubble = MessageBubble(
              sender: messageSender,
              message: messageText,
              isCurrentUser: currentUser == messageSender,
              time: dateTime,
            );
            messageBubbles.add(messageBubble);
          }
          if (snapshot.data.size == 0) {
            return Center(
              child: Text('No message'),
            );
          } else {
            return Expanded(
              child: ListView(
                reverse: true,
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                children: messageBubbles,
              ),
            );
          }
        } else {
          return Text('No message');
        }
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({this.sender, this.message, this.isCurrentUser, this.time});

  final String sender;
  final String message;
  final DateTime time;
  final bool isCurrentUser;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment:
        isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(color: Colors.grey[500]),
          ),
          Material(
            borderRadius: isCurrentUser
                ? BorderRadius.only(
                topLeft: Radius.circular(12.0),
                bottomLeft: Radius.circular(12.0),
                bottomRight: Radius.circular(12.0))
                : BorderRadius.only(
                topRight: Radius.circular(12.0),
                bottomLeft: Radius.circular(12.0),
                bottomRight: Radius.circular(12.0)),
            color: isCurrentUser ? Colors.lightBlue : Colors.grey[700],
            child: Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      '$message',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Flexible(
                    child: Text(
                      '${time.hour}:${time.minute}',
                      style: TextStyle(
                        color: isCurrentUser ? Colors.blue[800] : Colors.grey[400],
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}*/