import 'package:Conneect_Firebase/Components/components.dart';
import 'package:Conneect_Firebase/modules/admin/approvePosts.dart';
import 'package:Conneect_Firebase/modules/login/login.dart';
import 'package:Conneect_Firebase/modules/admin/rejectedPosts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Conneect_Firebase/modules/admin/dashBoard.dart';
import 'package:Conneect_Firebase/modules/admin/postsRequests.dart';

class Dash extends StatefulWidget {
  static String id = 'Dash';
  @override
  _DashState createState() => _DashState();
}

class _DashState extends State<Dash> {
  var countusers1;
  var countpost;
  var countapprove, countpending;
  countusers() async {
    FirebaseFirestore.instance
        .collection("users") //your collectionref
        .get()
        .then((value) {
      int count = 0;
      count = value.docs.length;
      countusers1 = count;
      print(countusers1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70.0,
        primary: true,
        title: Row(
          children: [
            SizedBox(width: 100),
            Row(
              children: [
                Text(
                  'DashBoard',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Comic Sans MS',
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontSize: 30,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.logout,
                size: 30,
              ),
              onPressed: () async {
                await FirebaseAuth.instance
                    .signOut(); // دي هنا عشان ال يوزر يخرج وهيرجع علي اللوجين
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              })
        ],
        backgroundColor: Color.fromRGBO(238, 120, 120, 1.0),
      ),
      body: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(16.0, 120.0, 16.0, 16.0),
        child: Column(
          children: [
            Row(
              children: [
                defaultHomeAdmin(
                    color: Color.fromRGBO(238, 126, 126, 1.0),
                    function: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DashBoard()));
                    },
                    icon: Icons.accessibility_new_outlined,
                    text: 'Users : ',
                    futureBuilder: FutureBuilder(
                        future: countDocuments(),
                        builder: (context, snapshot) {
                          return Expanded(
                            child: Text(
                              "$countusers1",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontFamily: 'Arial',
                                //fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        })),
                SizedBox(
                  width: 20.0,
                ),
                defaultHomeAdmin(
                    color: Color.fromRGBO(206, 175, 175, 1.0),
                    function: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PostAdmin()));
                    },
                    icon: Icons.post_add,
                    text: 'Posts : ',
                    futureBuilder: FutureBuilder(
                        future: countPosts(),
                        builder: (context, snapshot) {
                          return Expanded(
                            child: Text(
                              "$countpost",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontFamily: 'Arial',
                                //fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        })),
              ],
            ),
            SizedBox(
              height: 45,
            ),
            Row(
              children: [
                defaultHomeAdmin(
                  function: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PostApprove()));
                  },
                  icon: Icons.check_circle,
                  text: 'Approved : ',
                  futureBuilder: FutureBuilder(
                      future: countApproved(),
                      builder: (context, snapshot) {
                        return Expanded(
                          child: Text(
                            "$countapprove",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontFamily: 'Arial',
                              //fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }),
                  color: Color.fromRGBO(228, 178, 216, 1.0),
                ),
                SizedBox(
                  width: 20.0,
                ),
                defaultHomeAdmin(
                    function: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PostReject()));
                    },
                    icon: Icons.pending_actions_outlined,
                    text: 'Rejected : ',
                    futureBuilder: FutureBuilder(
                        future: countPending(),
                        builder: (context, snapshot) {
                          return Expanded(
                            child: Text(
                              "$countpending",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontFamily: 'Arial',
                                //fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        }),
                    color: Color.fromRGBO(255, 13, 13, 1.0)),
              ],
            )
          ],
        ),
      ),
    );
  }

  countDocuments() async {
    QuerySnapshot myDoc =
        await FirebaseFirestore.instance.collection('users').get();
    List<DocumentSnapshot> myDocCount = myDoc.docs;
    countusers1 = myDocCount.length;
  }

  countPosts() async {
    QuerySnapshot myDoc = await FirebaseFirestore.instance
        .collection('post')
        .where("appending", isEqualTo: "pending")
        .get();
    List<DocumentSnapshot> myDocCount = myDoc.docs;
    countpost = myDocCount.length;
  }

  countApproved() async {
    QuerySnapshot myDoc = await FirebaseFirestore.instance
        .collection('post')
        .where("appending", isEqualTo: "accept")
        .get();
    List<DocumentSnapshot> myDocCount = myDoc.docs;
    countapprove = myDocCount.length;
  }

  countPending() async {
    QuerySnapshot myDoc = await FirebaseFirestore.instance
        .collection('post')
        .where("appending", isEqualTo: "Reject")
        .get();
    List<DocumentSnapshot> myDocCount = myDoc.docs;
    countpending = myDocCount.length;
  }
}
