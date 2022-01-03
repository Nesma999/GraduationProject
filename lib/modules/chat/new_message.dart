import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class newMessage extends StatefulWidget {
  @override
  _newMessageState createState() => _newMessageState();
}

class _newMessageState extends State<newMessage> {
  final _controller = TextEditingController();
  String _enterMessage = "";
  _sendMessage() async {
    FocusScope.of(context).unfocus();
    //send a message here
      final user = FirebaseAuth.instance.currentUser;
      final userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      FirebaseFirestore.instance.collection('chat').add(
          // كل ما اضغط ع ال button  يظهرلى ع الشاشه ال  text  و يروح يزودها ف ال firestore
          {
            'Text' : _enterMessage,
            'Time': Timestamp.now(), // دا علشان يجبلى الوقت اللى اتبعتت فيه المسدج
           'name': userData['name'],
           'userId': user.uid,
            'imageurl' : userData['imageurl'],
            //'RecieverId':['RecieverId'],
           // 'SenderId' :['SenderId']
          });

    _controller.clear();
    setState(() {
      _enterMessage="";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,

              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
                  labelText: 'Send a message ...',labelStyle: TextStyle(color: Colors.red)),
              onChanged: (val) {
                setState(() {
                  _enterMessage = val;
                });
              },
            ),
          ),
          IconButton(
              color: Colors.red,
              disabledColor: Colors.grey,
              icon: Icon(Icons.send),
              onPressed: _enterMessage.trim().isEmpty ? null : _sendMessage
          ),
        ],
      ),
    );
  }
}
