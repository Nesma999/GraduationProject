import 'dart:async';
import 'package:Conneect_Firebase/models/approve.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:Conneect_Firebase/services/service.dart";

class PostAdmin extends StatefulWidget {
  PostAdminState createState() => PostAdminState();
}

class PostAdminState extends State<PostAdmin> {
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
      .where("appending", isEqualTo: "pending");

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
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Center(
                child: Text('Posts\'s Requests',
                    style: TextStyle(
                      fontFamily: 'Comic Sans MS',
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Color.fromRGBO(233, 101, 101, 1),
                      fontStyle: FontStyle.italic,
                    )),
              ),
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
              backgroundColor: Colors.white,
              elevation: 0.0,
            ),
            body: Column(children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        approveall();
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => PostAdmin()));
                      },
                      child: Text(
                        "Approve ALL",
                        style: TextStyle(
                            // color: Color.fromRGBO(
                            //     204, 143, 143, 1),
                            color: Colors.white,
                            fontSize: 18),
                      ),
                      style: TextButton.styleFrom(
                        fixedSize: Size(0.0,45.0),
                        backgroundColor: Color.fromRGBO(233, 101, 101, 1),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.grey[300],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20.0,),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        rejectall();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PostAdmin()));
                      },
                      child: Text(
                        "Reject ALL",
                        style: TextStyle(
                            color: Color.fromRGBO(204, 143, 143, 1),
                            fontSize: 18),
                      ),
                      style: TextButton.styleFrom(
                        fixedSize: Size(0.0,45.0),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.grey[300],
                          ),
                        ),
                      ),
                    ),
                  )
                ]),
              ),
              Flexible(
                  child: postList != null
                      ? Card(
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
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
                                    margin: EdgeInsets.fromLTRB(10, 15, 10, 0),
                                    color: Colors.white,
                                    //elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                      side: BorderSide(
                                        color: Colors.black26,
                                      ),
                                    ),
                                    child: Column(children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ListTile(
                                          leading: Container(
                                            height: 60.0,
                                            width: 60.0,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    postList[index]
                                                        .data()['img']),
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
                                      padding: EdgeInsets.fromLTRB(30, 10, 0, 0),
                                      child: Row(children: [
                                        Expanded(
                                          child: Text(
                                            postList[index].data()[
                                                'postdescribtion'],
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: post),
                                          ),
                                        ),
                                      ])),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(children: [
                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              Approve(postList[index]
                                                  .data()['postid']);
                                            },
                                            child: Text(
                                              "Approve",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18),
                                            ),
                                            style:TextButton.styleFrom(
                                              backgroundColor: Color.fromRGBO(233, 101, 101, 1),
                                              shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                  color: Colors.grey[300],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 20.0,),
                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Reject(postList[index]
                                                  .data()['postid']);
                                            },
                                            child: Text(
                                              "Reject",
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      204, 143, 143, 1),
                                                  fontSize: 18),
                                            ),
                                            style: TextButton.styleFrom(
                                              backgroundColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                  color: Colors.grey[300],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        ]),
                                      )
                                    ]));
                              })))
                      : Center(
                          child: CircularProgressIndicator(),
                        ))
            ])));
  }

  void approveall() async {
    var collection = FirebaseFirestore.instance.collection('post');
    var querySnapshots = await collection.get();
    for (var snapshot in querySnapshots.docs) {
      var documentID = snapshot.id; // <-- Document ID
      print(documentID);
      DocumentReference ref =
          FirebaseFirestore.instance.collection('post').doc(documentID);
      ref.update({
        'appending': "accept",
      });
    }
  }

  void rejectall() async {
    var collection = FirebaseFirestore.instance.collection('post');
    var querySnapshots = await collection.get();
    for (var snapshot in querySnapshots.docs) {
      var documentID = snapshot.id; // <-- Document ID
      print(documentID);
      DocumentReference ref =
          FirebaseFirestore.instance.collection('post').doc(documentID);
      ref.update({
        'appending': "Reject",
      });
    }
  }

  Approve(var post) {
    _post.Approve(
        post,
        PostApprove1(
          appending1: "accept",
        ));
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => PostAdmin()));
  }

  Reject(var post) {
    _post.Approve(
        post,
        PostApprove1(
          appending1: "Reject",
        ));
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => PostAdmin()));
  }
}
