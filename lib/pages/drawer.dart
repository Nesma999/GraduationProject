import 'package:Conneect_Firebase/pages/profileGreen.dart';
import 'package:Conneect_Firebase/pages/profileRed.dart';
import 'package:Conneect_Firebase/pages/profile_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'BloodTypes.dart';
import 'Change_Password.dart';
import 'call.dart';
import 'home.dart';
import 'login.dart';
import 'image.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  String _img, _name;
  var text = Color.fromRGBO(213, 209, 209, 1);
  var backG = Color.fromRGBO(229, 33, 33, 1);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: backG,
        child: Column(
          children: [
            Container(
              child: Padding(
                padding: EdgeInsets.only(top: 60.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    imageProfile(),
                    SizedBox(
                      height: 10,
                    ),
                    FutureBuilder(
                      future: _fetchInfo(),
                      builder: (context, snapshot) {
                        return Text(
                          "$_name ",
                          style: TextStyle(
                            color: text,
                            fontFamily: 'Arial',
                            fontSize: 30,
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(
                        Icons.account_circle,
                        color: text,
                        size: 27,
                      ),
                      title: Text(
                        'Profile',
                        style: TextStyle(
                            fontFamily: 'Arial', color: text, fontSize: 27),
                      ),
                      onTap: () {
                        final user = FirebaseAuth.instance.currentUser;
                        FirebaseFirestore.instance
                            .collection('users')
                            .doc(user.uid)
                            .get()
                            .then((snapshot) {
                          if (snapshot.data()['donor validity'] == 'yes') {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProfileGreen()));
                          } else if (snapshot.data()['donor validity'] ==
                              'no') {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProfileRed()));
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Imagee()));
                          }
                        });
                        //   Navigator.push(context,
                        //       MaterialPageRoute(builder: (context) => Imagee()));
                      },
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(
                        Icons.post_add_sharp,
                        color: text,
                        size: 27,
                      ),
                      title: Text(
                        'Posts',
                        style: TextStyle(
                            fontFamily: 'Arial', color: text, fontSize: 27),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyHomePage()));
                      },
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(
                        Icons.messenger_sharp,
                        color: text,
                        size: 27,
                      ),
                      title: Text(
                        'Chats',
                        style: TextStyle(
                            fontFamily: 'Arial', color: text, fontSize: 27),
                      ),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Chattt()));
                      },
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(
                        Icons.search,
                        color: text,
                        size: 27,
                      ),
                      title: Text(
                        'Search',
                        style: TextStyle(
                            fontFamily: 'Arial', color: text, fontSize: 27),
                      ),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Search()));
                      },
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(
                        Icons.vpn_key_outlined,
                        color: text,
                        size: 27,
                      ),
                      title: Text(
                        'Change Password',
                        style: TextStyle(
                            fontFamily: 'Arial', color: text, fontSize: 26),
                      ),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Change()));
                      },
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(
                        Icons.logout,
                        color: text,
                        size: 27,
                      ),
                      title: Text(
                        'Logout',
                        style: TextStyle(
                            fontFamily: 'Arial', color: text, fontSize: 27),
                      ),
                      onTap: () async {
                        await FirebaseAuth.instance
                            .signOut(); // دي هنا عشان ال يوزر يخرج وهيرجع علي اللوجين
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                    ),
                    SizedBox(
                      height: 37.5,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Widget imageProfile() {
    return FutureBuilder(
      future: _fetchInfo(),
      builder: (context, snapshot) {
        return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 190.0,
                width: 190.0,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: (_img != null)
                          ? NetworkImage(_img)
                          : NetworkImage(
                              'https://i.pinimg.com/564x/04/28/f5/0428f5706e19f681febc5aa677d7e282.jpg'),
                    ),
                    border: Border.all(color: text, width: 6.0)),
              ),
            ]);
      },
    );
  }

  _fetchInfo() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null)
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get()
          .then((value) {
        _name = value.data()['name'];
        _img = value.data()['imageurl'];
      }).catchError((e) {
        print(e);
      });
  }
}
