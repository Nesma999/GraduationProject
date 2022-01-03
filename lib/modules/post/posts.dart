import 'dart:async';
import 'package:Conneect_Firebase/Components/components.dart';
import 'package:Conneect_Firebase/models/comment.dart';
import 'package:Conneect_Firebase/models/likes.dart';
import 'package:Conneect_Firebase/models/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Conneect_Firebase/services/post.dart';
import '../drawer/drawer.dart';

class MyHomePage extends StatefulWidget {
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  var countlike1;
  StreamSubscription<QuerySnapshot> _subscription;
  List<DocumentSnapshot> postList = [];
  final Query _collectionReference = Firestore.instance
      .collection("post")
      .where("appending", isEqualTo: "accept");
  @override
  void initState() {
    super.initState();
    _subscription = _collectionReference.snapshots().listen((datasnapshot) {
      setState(() {
        postList = datasnapshot.documents;
        print("Posts List ${postList.length}");
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
  }

  List<Postt> posts;
  List<LikeModel> likes;
  final _post = Post();
  final _like = Likes();
  String ss = "1";
  String comment11;
  final comments = Comment();
  final uid = FirebaseAuth.instance.currentUser.uid;
  var countlikee;
  TextEditingController postdescripition = TextEditingController();
  TextEditingController comment10 = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  final GlobalKey<FormState> commentKey = GlobalKey();
  var loginKey = GlobalKey<ScaffoldState>();
  var img, name, contant;
  bool flag1 = true, flag2 = true;
  var text = Color.fromRGBO(213, 209, 209, 1);
  var r = Color.fromRGBO(218, 19, 19, 1);
  var backG = Color.fromRGBO(229, 33, 33, 1);
  var bar = Color.fromRGBO(255, 255, 255, 1);
  var userName = Color.fromRGBO(200, 125, 125, 1);
  var post = Color.fromRGBO(59, 45, 45, 1);
  var react = Color.fromRGBO(222, 24, 24, 1);
  var comment = Color.fromRGBO(213, 68, 68, 1);
  String _img;

  Widget imageProfile() {
    return FutureBuilder(
      future: _showProfile(),
      builder: (context, snapshot) {
        return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 40.0,
                width: 40.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: (_img != null)
                        ? NetworkImage(_img)
                        : NetworkImage(
                            'https://i.pinimg.com/564x/04/28/f5/0428f5706e19f681febc5aa677d7e282.jpg'),
                  ),
                ),
              ),
            ]);
      },
    );
  }

  _showProfile() async {
    final user = await FirebaseAuth.instance.currentUser;
    if (user != null)
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get()
          .then((value) {
        _img = value.data()['imageurl'];
      }).catchError((e) {
        print(e);
      });
  }

  @override
  Widget build(BuildContext context) {

    countlike1(var post) async {
      QuerySnapshot myDoc = await Firestore.instance
          .collection('likes')
          .where("postid", isEqualTo: post)
          .get();
      List<DocumentSnapshot> myDocCount = myDoc.docs;
      countlikee = myDocCount.length;
    }

    Color textIconColor = Colors.white;
    void addLike(int index) {
      //add like document to firestore
      String likeID = FirebaseFirestore.instance.collection("likes").doc().id;
      var data = {
        'userEmail': auth.currentUser.email,
        'postID': posts[index].postid,
        'likeID': likeID,
      };
      FirebaseFirestore.instance.collection("likes").doc(likeID).set(data);

      //check likes
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: backG,
        title: Text(
          "Posts",
          style: TextStyle(fontSize: 25, fontFamily: 'Noto Serif', color: bar),
        ),
      ),
      drawer: Drawer(
        child: DrawerScreen(),
      ),
      key: loginKey,
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: 10.0,
          ),
          Form(
              key: _formKey,
              child: Container(
                //padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextFormField(
                  controller: postdescripition,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black26,
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black26,
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black26,
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    // filled: true,
                    // fillColor: Colors.white,
                    suffixIcon: icon(),
                    hintText: "Write here....",
                    hintStyle: TextStyle(
                      color: Color.fromRGBO(200, 125, 125, 1),
                      //fontSize: 25,
                    ),
                  ),
                  maxLines: 5,
                  //maxLength: 200,
                  validator: (postdescripition) {
                    if (postdescripition.isEmpty) {
                      return "this field is required";
                    }
                    return null;
                  },
                ),
              )),
          SizedBox(
            height: 10.0,
          ),
          ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (context, index) => SizedBox(
              height: 10.0,
            ),
            itemBuilder: ((context, index) {
              return Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black26),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Column(children: [
                    Container(
                      //padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                      child: ListTile(
                        leading: Container(
                          height: 50.0,
                          width: 50.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image:
                                  NetworkImage(postList[index].data()['img']),
                            ),
                          ),
                        ),
                        title: Text(
                          postList[index].data()['name'],
                          style: TextStyle(fontSize: 20, color: userName),
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
                                  fontSize: 18,
                                  color: post),
                            ),
                          ),
                        ])),
                    Container(
                      child: FlatButton(
                          padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        add(postList[index].data()['postid'])));
                          },
                          child: Row(
                            children: [
                              FutureBuilder(
                                  future: countlike1(
                                      postList[index].data()['postid']),
                                  builder: (context, snapshot) {
                                    return Text(
                                      "$countlikee",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: react,
                                        fontFamily: 'Arial',
                                      ),
                                    );
                                  }),
                              SizedBox(width: 5),
                              Icon(
                                FontAwesomeIcons.thumbsDown,
                                size: 16,
                              ),
                              Icon(
                                FontAwesomeIcons.thumbsUp,
                                size: 16,
                              ),
                            ],
                          )),
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center,
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 5.0,
                          ),
                          Expanded(
                            child: defaultLikesButton(
                              textColor: Color.fromRGBO(222, 24, 24, 1),
                              icon: FontAwesomeIcons.thumbsUp,
                              text: 'Like',
                              function: () {
                                addlike(postList[index].data()['postid']);
                              },
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                              child: defaultLikesButton(
                                textColor: Color.fromRGBO(222, 24, 24, 1),
                            icon: FontAwesomeIcons.thumbsDown,
                            text: 'disLike',
                            function: () {},
                          )),
                          SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            child: defaultLikesButton(
                              textColor: Color.fromRGBO(222, 24, 24, 1),
                              icon: FontAwesomeIcons.comment,
                              text: 'Comment',
                              function: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => commentfetch(
                                            postList[index].data()['postid'])));
                              },
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                        ]),
                    Row(children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.all(5.0),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black26),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.all(5.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                Container(
                                  padding: EdgeInsetsDirectional.all(10.0),
                                  height: 60,
                                  child: TextFormField(
                                    controller: comment10,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(25),
                                        borderSide: BorderSide(color: Colors.red),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.red,
                                        ),
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.red,
                                        ),
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          Icons.send_rounded,
                                          color: Colors.black54,
                                          //size: 25,
                                        ),
                                        onPressed: () {
                                            Addcomment(
                                                postList[index]
                                                    .data()['postid']);
                                        },
                                      ),
                                      hintText: 'Write a Comment',
                                      hintStyle: TextStyle(
                                        color: Color.fromRGBO(199, 179, 179, 1),
                                        //fontSize: 20,
                                      ),
                                    ),
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return "this field is required";
                                      }

                                      return null;
                                    },
                                  ),
                                ),
                                RaisedButton(
                                  color: Color.fromRGBO(255, 225, 225, 1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: BorderSide(
                                      color: Color.fromRGBO(255, 225, 225, 1),
                                    ),
                                  ),
                                  child: Text(
                                    "View all comments",
                                    style: TextStyle(color: react, fontSize: 15),
                                  ),
                                  onPressed: () {
                                    Addcomment(postList[index].data()['postid']);
                                  },
                                ),
                              ]),
                            ),
                          ),
                        ),
                      )
                    ]),
                    SizedBox(height: 10.0,),
                  ])
              );
            }),
            itemCount: postList.length,
          ),
        ]),
      ),
    );
  }
  Widget icon() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 80, 5, 0),
      child: IconButton(
          icon: Icon(
            Icons.add_box_outlined,
            size: 30,
            color: Colors.red,
          ),
          onPressed: () async {
            final formData = _formKey.currentState;
            if (formData.validate()) {
              formData.save();
              var current_user = FirebaseAuth.instance.currentUser;
              var doc_ref =
                  await FirebaseFirestore.instance.collection("post").doc();
              final userData = await FirebaseFirestore.instance
                  .collection("users")
                  .doc(uid)
                  .get();
              _post.AddPost(
                Postt(
                  uid: current_user.uid,
                  postid:
                      FirebaseFirestore.instance.collection("posts").doc().id,
                  name: userData['name'],
                  postdesc: postdescripition.text,
                  appending: "pending",
                  img: userData['imageurl'],
                  time: Timestamp.now(),
                  // likes:Addlike(post),
                ),
              );
              loginKey.currentState.showSnackBar(SnackBar(
                content: Text("Wait admin approve or reject your post"),
              ));
              //showDialogFun(context);

            }
          }),
    );
  }

  final FirebaseAuth auth = FirebaseAuth.instance;

  addlike(var post) async {
    final userData =
        await FirebaseFirestore.instance.collection("users").doc(uid).get();
    _like.AddLike(
      post,
      LikeModel(
        userid: FirebaseAuth.instance.currentUser.uid,
        name: userData['name'],
        img: userData['imageurl'],
        like: "yes",
        postid: post,
        userEmail: FirebaseAuth.instance.currentUser.email,
        likeID: FirebaseFirestore.instance.collection("likes").doc().id,

        // likes:Addlike(post),
      ),
    );
  }

  Addcomment(var post) async {
    final userData =
        await FirebaseFirestore.instance.collection("users").doc(uid).get();
    comments.AddComment(
        post,
        CommentModel(
          comment: comment10.text,
          postid: post,
          userEmail: FirebaseAuth.instance.currentUser.email,
          commentID: FirebaseFirestore.instance.collection("comments").doc().id,
          name: userData["name"],
          img: userData["imageurl"],
          userid: FirebaseAuth.instance.currentUser.uid,
        ));
    comment10.clear();
  }

  Widget add(var post) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 55,),
              Icon(
                FontAwesomeIcons.react,
                color: Colors.white,
                size: 25,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                'Reacts',
                style: TextStyle(
                  fontFamily: 'Comic Sans MS',
                  //fontWeight: FontWeight.bold,
                  fontSize: 25,
                  // fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          backgroundColor: Colors.red,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
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
            stream: Firestore.instance
                .collection("like")
                .where("postid", isEqualTo: post)
                .snapshots(),
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
                leading: Container(
                  height: 60.0,
                  width: 60.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(doc['img']),
                    ),
                  ),
                ),
                title: Text(
                  doc['name'],
                  style: TextStyle(
                      fontSize: 20, color: Color.fromRGBO(167, 117, 117, 1)),
                ),
              ),
            )
          ]),
        )
        .toList();
  }

  Widget commentfetch(var post) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              SizedBox(width: 55),
              Icon(
                Icons.comment,
                color: Colors.white,
                size: 25,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                'Comments',
                style: TextStyle(
                  fontFamily: 'Comic Sans MS',
                  //fontWeight: FontWeight.bold,
                  fontSize: 25,
                  // fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          backgroundColor: Colors.red,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
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
            stream: Firestore.instance
                .collection("comments")
                .where("postid", isEqualTo: post)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) return new Text("There is no expense");
              return new ListView(children: getcommentsItems(snapshot));
            }));
  }

  getcommentsItems(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data.documents
        .map((doc) => Card(
                margin: EdgeInsets.all(10),
                color: Colors.white,
                //elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                  side: BorderSide(
                    color: Colors.black26,
                  ),
                ),
                child: Column(children: [
                  ListTile(
                      leading: Container(
                        height: 60.0,
                        width: 60.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(doc['img']),
                          ),
                        ),
                      ),
                      title: Text(
                        doc['name'],
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                      subtitle: Text(
                        doc['comment'],
                        style: TextStyle(
                            fontSize: 20,
                            color: Color.fromRGBO(167, 117, 117, 1)),
                      )),
                ]))
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
