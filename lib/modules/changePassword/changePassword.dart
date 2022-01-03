import 'package:Conneect_Firebase/Components/components.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../drawer/drawer.dart';

class Change extends StatefulWidget {
  @override
  _ChangeState createState() => _ChangeState();
}

class _ChangeState extends State<Change> {
  FirebaseAuth instance = FirebaseAuth.instance;

  bool currentPassword = true;
  bool newPassword = true;
  bool confirmPassword = true;
  String  newPass, confirm;
  String userId = "";
  var user = FirebaseAuth.instance.currentUser;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  TextEditingController newController = TextEditingController();
  String _img;
  Widget imageProfile() {
    return FutureBuilder(
      future: _showProfile(),
      builder: (context, snapshot) {
        return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
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
                    border: Border.all(
                        color: Color.fromRGBO(213, 209, 209, 1), width: 6.0)),
              ),
            ]);
      },
    );
  }

  _showProfile() async {
    final user = FirebaseAuth.instance.currentUser;
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
    return Scaffold(
      backgroundColor: Colors.white,
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black,size: 30),
        elevation: 0.0,
      ),
      drawer: Drawer(
        child: DrawerScreen(),
      ),
      body: Padding(
        padding: const EdgeInsetsDirectional.all(20.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Change Password',
                      style: TextStyle(
                        color: Color.fromRGBO(249, 24, 24, 1),
                        fontSize: 30,
                        fontFamily: 'Comic Sans MS',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                imageProfile(),
                SizedBox(height: 20.0),
                defaultChangePassword(
                  control: passwordController,
                  label: 'Current Password',
                  suffix:
                      currentPassword ? Icons.visibility : Icons.visibility_off,
                  isPassword: currentPassword,
                  function: () {
                    setState(() {
                      currentPassword = !currentPassword;
                    });
                  },
                  validate: (String value) {
                    if (value.isEmpty) {
                      return 'Please re-enter password';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                defaultChangePassword(
                  control: newController,
                  label: 'New Password',
                  suffix: newPassword ? Icons.visibility : Icons.visibility_off,
                  isPassword: newPassword,
                  function: () {
                    setState(() {
                      newPassword = !newPassword;
                    });
                  },
                  validate: (String value) {
                    if (value.isEmpty) {
                      return 'Please re-enter password';
                    }
                    return null;
                  },
                  changed: (value) {
                    setState(() {
                      this.newPass = value;
                    });
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                defaultChangePassword(
                  control: confirmController,
                  suffix:
                      confirmPassword ? Icons.visibility : Icons.visibility_off,
                  isPassword: confirmPassword,
                  function: () {
                    setState(() {
                      confirmPassword = !confirmPassword;
                    });
                  },
                  validate: (String value) {
                    if (value.isEmpty) {
                      return 'Please re-enter password';
                    }
                    print(newController.text);

                    print(confirmController.text);

                    if (newController.text != confirmController.text) {
                      return "Password does not match";
                    }
                    return null;
                  },
                  changed: (value) {
                    setState(() {
                      this.confirm = value;
                    });
                  },
                  label: 'Confirm Password',
                ),
                SizedBox(height: 80),
                defaultButton(
                  backgroundColor: Color(0xffe60000),
                  sideColor:Color(0xffe60000),
                  width: 190.0,
                    text: 'Change',
                    size: 25,
                    tap: (){
                      final scaffold = ScaffoldMessenger.of(context);
                      if (formKey.currentState.validate()) {
                        final user = FirebaseAuth.instance.currentUser;
                        user.updatePassword(newController.text).then((_) {
                          print('Password Change successful');
                          scaffold.showSnackBar(
                            SnackBar(
                              content: const Text('Password Change successful'),
                            ),
                          );
                        }).catchError((err) {
                          print("Password can't be changed");
                        });
                      }
                    },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
