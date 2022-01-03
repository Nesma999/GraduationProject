import 'dart:async';
import 'package:Conneect_Firebase/Components/components.dart';
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
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: defaultPostsAppBar(context, 'Posts\'s Requests'),
        body: Column(children: [
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
                            return defaultPosts(
                              img: postList[index].data()['img'],
                              name: postList[index].data()['name'],
                              description:
                                  postList[index].data()['postdescribtion'],
                              padding: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(children: [
                                  Expanded(
                                    child: defaultButton(
                                      sideColor: Colors.grey[300],
                                      backgroundColor:
                                          Color.fromRGBO(233, 101, 101, 1),
                                      text: 'Approve',
                                      tap: () {
                                        Approve(
                                            postList[index].data()['postid']);
                                      },
                                      size: 0.0,
                                      width: 0.0,
                                      height: 0.0,
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20.0,
                                  ),
                                  Expanded(
                                    child: defaultButton(
                                      sideColor: Colors.grey[300],
                                      backgroundColor: Colors.white,
                                      textColor:
                                          Color.fromRGBO(204, 143, 143, 1),
                                      text: 'Reject',
                                      tap: () {
                                        Reject(
                                            postList[index].data()['postid']);
                                      },
                                      size: 0.0,
                                      width: 0.0,
                                      height: 0.0,
                                      fontSize: 18,
                                    ),
                                  ),
                                ]),
                              ),
                            );
                          })))
                  : Center(
                      child: CircularProgressIndicator(),
                    ))
        ]));
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
  }

  Reject(var post) {
    _post.Approve(
        post,
        PostApprove1(
          appending1: "Reject",
        ));
  }
}
// Expanded(
//   child: ElevatedButton(
//     onPressed: () async {
//       approveall();
//     },
//     child: Text(
//       "Approve ALL",
//       style: TextStyle(
//           // color: Color.fromRGBO(
//           //     204, 143, 143, 1),
//           color: Colors.white,
//           fontSize: 18),
//     ),
//     style: TextButton.styleFrom(
//       fixedSize: Size(0.0,45.0),
//       backgroundColor: Color.fromRGBO(233, 101, 101, 1),
//       shape: RoundedRectangleBorder(
//         side: BorderSide(
//           color: Colors.grey[300],
//         ),
//       ),
//     ),
//   ),
// ),
// SizedBox(width: 20.0,),
// Expanded(
//   child: ElevatedButton(
//     onPressed: () async {
//       rejectall();
//     },
//     child: Text(
//       "Reject ALL",
//       style: TextStyle(
//           color: Color.fromRGBO(204, 143, 143, 1),
//           fontSize: 18),
//     ),
//     style: TextButton.styleFrom(
//       fixedSize: Size(0.0,45.0),
//       backgroundColor: Colors.white,
//       shape: RoundedRectangleBorder(
//         side: BorderSide(
//           color: Colors.grey[300],
//         ),
//       ),
//     ),
//   ),
// )
