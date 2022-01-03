import 'package:Conneect_Firebase/Components/components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'search/search.dart';
import 'changePassword.dart';
import 'call.dart';
import 'posts.dart';
import 'login/login.dart';
import 'usersProfile/profile.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  String _img, _name;
  var text = Colors.white;
  var backG = Color.fromRGBO(229, 33, 33, 1);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: backG,
        child: Padding(
          padding: const EdgeInsetsDirectional.only(top: 60.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              imageProfile(),
              SizedBox(height: 10.0,),
              Expanded(
                child: FutureBuilder(
                  future: _fetchInfo(),
                  builder: (context, snapshot) {
                    return Text(
                      "$_name ",
                      style: TextStyle(
                        color: text,
                        fontFamily: 'Arial',
                        fontSize: 25,
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 16.0),
                child: Container(
                  height: 1.0,
                  width: double.infinity,
                  color: Colors.white38,
                ),
              ),
              defaultDrawer(
                  text: 'Profile',
                  icon:  Icons.account_circle,
                  onTap:(){
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
                                builder: (context) => ImageeState().profileGreen()));
                      } else if (snapshot.data()['donor validity'] ==
                          'no') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ImageeState().profileRed()));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Imagee()));
                      }
                    });
                  }
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 16.0),
                child: Container(
                  height: 1.0,
                  width: double.infinity,
                  color: Colors.white38,
                ),
              ),
              defaultDrawer(
                  text: 'Posts',
                  icon: Icons.post_add_sharp,
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyHomePage()));
                }
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 16.0),
                child: Container(
                  height: 1.0,
                  width: double.infinity,
                  color: Colors.white38,
                ),
              ),
              defaultDrawer(
                  text: 'Chats',
                  icon:  Icons.messenger_sharp,
                  onTap: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Chattt()));
                },
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 16.0),
                child: Container(
                  height: 1.0,
                  width: double.infinity,
                  color: Colors.white38,
                ),
              ),
              defaultDrawer(
                  text: 'Search',
                  icon: Icons.search,
                  onTap: (){
    Navigator.push(context,
    MaterialPageRoute(builder: (context) => Search()));
    },
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 16.0),
                child: Container(
                  height: 1.0,
                  width: double.infinity,
                  color: Colors.white38,
                ),
              ),
              defaultDrawer(
                  text: 'Change Password',
                  icon: Icons.lock_outline,
                  onTap: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Change()));
                  },
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 16.0),
                child: Container(
                  height: 1.0,
                  width: double.infinity,
                  color: Colors.white38,
                ),
              ),
              defaultDrawer(
                  text: 'LogOut',
                  icon: Icons.logout,
                  onTap: () async {
    await FirebaseAuth.instance
        .signOut(); // دي هنا عشان ال يوزر يخرج وهيرجع علي اللوجين
    Navigator.pushReplacement(
    context,
    MaterialPageRoute(
    builder: (context) => LoginPage()));
    },
              ),
            ],
          ),
        ),
    );
  }

  Widget imageProfile() {
    return FutureBuilder(
      future: _fetchInfo(),
      builder: (context, snapshot) {
        return Container(
          height: 150.0,
          width: 150.0,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: (_img != null)
                    ? NetworkImage(_img)
                    : NetworkImage(
                        'https://i.pinimg.com/564x/04/28/f5/0428f5706e19f681febc5aa677d7e282.jpg'),
              ),
              border: Border.all(color: Color.fromRGBO(213, 209, 209, 1), width: 6.0)),
        );
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
