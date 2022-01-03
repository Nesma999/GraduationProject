import 'package:Conneect_Firebase/modules/chat/chat1.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../drawer/drawer.dart';

class Chattt extends StatefulWidget {
  @override
  ChatttState createState() => ChatttState();
}
class ChatttState extends State<Chattt> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          elevation: 0.0,
          title: Text('Chat'),
        ),
        drawer: Drawer(
          child: DrawerScreen(),
        ),
        body:
        SingleChildScrollView(
          child: Column(
            children:[

              StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection("users").snapshots(),
                builder:
                    (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) return new Text("There is no expense");
                  return new ListView(
                    shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: getExpenseItems(snapshot)
                  );
                }),
            ]
          ),
        ));
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
                  )
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 30.0,end: 30.0),
              child: Divider(
                color: Colors.grey[400],
              ),
            ),
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
