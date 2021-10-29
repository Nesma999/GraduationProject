import 'dart:async';
import 'package:Conneect_Firebase/models/approve.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:Conneect_Firebase/services/service.dart";

class PostReject extends StatefulWidget {
  PostRejectState createState() => PostRejectState();
}

class PostRejectState extends State<PostReject> {
  final _post = ApprovePost();
  var text = Color.fromRGBO(213, 209, 209, 1);
  var r = Color.fromRGBO(218, 19, 19, 1);
  var backG = Color.fromRGBO(229, 33, 33, 1);
  var bar = Color.fromRGBO(255, 255, 255, 1);
  var userName = Color.fromRGBO(200, 125, 125, 1);
  var post = Color.fromRGBO(59, 45, 45, 1);
  var react = Color.fromRGBO(222, 24, 24, 1);
  var comment = Color.fromRGBO(213, 68, 68, 1);
  StreamSubscription<QuerySnapshot> _subscription;
  List<DocumentSnapshot> postList;
  final Query _collectionReference = FirebaseFirestore.instance
      .collection("post")
      .where("appending", isEqualTo: "Reject");

  @override
  void initState() {
    super.initState();
    _subscription = _collectionReference.snapshots().listen((datasnapshot) {
      setState(() {
        postList = datasnapshot.docs;
        print("Posts List ${postList.length}");
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
    Scaffold(
      appBar: AppBar(
        toolbarHeight: 50.0,
        primary: true,
        title: Container(
                padding: EdgeInsets.fromLTRB(60, 0, 0, 0),
                child: Text('Post\'s Rejected',
                    style: TextStyle(
                      fontFamily: 'Comic Sans MS',
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Color.fromRGBO(233, 101, 101, 1),
                      fontStyle: FontStyle.italic,
                    ))),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.red,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
        body: Column(children: [
      Flexible(
          child: postList != null
              ? Card(
                  margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                  color: Color.fromRGBO(254, 199, 199, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                    side: BorderSide(
                      color: Colors.black26,
                    ),
                  ),
                  child: ListView.builder(
                      itemCount: postList.length,
                      itemBuilder: ((context, index) {
                        return Card(
                            margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                            color: Colors.white,
                            //elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                              side: BorderSide(
                                color: Colors.black26,
                              ),
                            ),
                            child: Column(children: [
                              FlatButton(
                                onPressed: () async {},
                                padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                                child: ListTile(
                                  leading: Container(
                                    height: 60.0,
                                    width: 60.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            postList[index].data()['img']),
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    postList[index].data()['name'],
                                    style: TextStyle(
                                        fontSize: 20, color: userName),
                                  ),
                                ),
                              ),
                              Container(
                                  child: Column(children: [
                                Container(
                                    padding: EdgeInsets.fromLTRB(30, 10, 0, 10),
                                    child: Row(children: [
                                      Expanded(
                                        child: Text(
                                          postList[index]
                                              .data()['postdescribtion'],
                                          style: TextStyle(
                                              fontSize: 25, color: post),
                                        ),
                                      ),
                                    ])),
                              ]))
                            ]));
                      })))
              : Center(
                  child: CircularProgressIndicator(),
                ))
    ])));
  }
}
