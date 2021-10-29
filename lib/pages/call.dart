import 'package:firebase_auth/firebase_auth.dart';
import 'package:Conneect_Firebase/pages/chat1.dart';

import 'package:Conneect_Firebase/pages/home.dart';
import 'package:Conneect_Firebase/pages/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Chattt extends StatefulWidget {
  @override
  ChatttState createState() => ChatttState();
}

class ChatttState extends State<Chattt> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Chats',style: TextStyle(fontSize: 28),),
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
        body: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection("users").snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) return new Text("There is no expense");
              return new ListView(children: getExpenseItems(snapshot));
            }));
  }

  getExpenseItems(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data.documents
        .map(
          (doc) => Column(children: [
            Container(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: ListTile(
                  leading: InkWell(
                      child: Container(
                        height: 60.0,
                        width: 60.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(doc['imageurl']),
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Chat11()));
                      }),
                  title: InkWell(
                    child: Text(
                      doc['name'],
                      style: TextStyle(
                          fontSize: 20,
                          color: Color.fromRGBO(167, 117, 117, 1)),
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Chat11()));
                    },
                  )),
            )
          ]),
          // new RaisedButton(
          // onPressed: () {
          //    Navigator.push(
          //      context, MaterialPageRoute(builder: (context) => Chat11()));
          // },
          // child: Row(children: <Widget>[
          //   Image.network(
          //     doc['imageurl'],
          //     width: 150,
          //     height: 100,
          //     fit: BoxFit.fill,
          //   ),
          //   SimpleDialog(doc["name"]),
          // ])))
        )
        .toList();
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
