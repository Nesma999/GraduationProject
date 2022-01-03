import 'package:Conneect_Firebase/Components/components.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../login/login.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  FirebaseAuth instance = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  var loginKey = GlobalKey<ScaffoldState>();
  bool passwordVisible = true;
  String _email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        key: loginKey,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ));
            },
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    //margin: EdgeInsets.only(top: 5.0),
                    child: Text(
                      "Forget  Password?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: HexColor("#F91818"),
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 25.0),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image:AssetImage(
                      "assets/images/forget.jpeg",
                    ),
                      ),
                        border: Border.all(
                            color: Colors.white, width: 8.0)
                    ),
                    height: 160.0,
                    width: 160.0,
                  ),
                  SizedBox(height: 30.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Text(
                      "Enter the email address associated with your account",
                      style: TextStyle(
                        color: HexColor("#E52121"),
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  SizedBox(height: 12.0),
                  Padding(
                    padding: const EdgeInsets.only(right: 50.0),
                    child: Text(
                      "We will email you a link ",
                      //textAlign: TextAlign.center,
                      style: TextStyle(
                        color: HexColor("#B78181"),
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: Text(
                      "to reset your password",
                      style: TextStyle(
                        color: HexColor("#B78181"),
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Enter your Email Address",
                          hintStyle: TextStyle(
                            color: HexColor("#A79A9A"),
                            fontSize: 20.0,
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "this field is required";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            this._email = value;
                          });
                        }),
                  ),
                  SizedBox(height: 100.0),
                  defaultButton(
                    backgroundColor: Color(0xffe60000),
                    sideColor:Color(0xffe60000),
                    text: 'Send',
                    tap: () {
                      forgetPass();
                    },
                    size: 25,
                    width: 150.0,
                  )
                ],
              ),
            )
          ],
        )));
  }

  forgetPass() {
    final formData = _formKey.currentState;
    if (formData.validate()) {
      formData.save();
      try {
        instance.sendPasswordResetEmail(email: this._email);

        Navigator.of(context).pop();
      } catch (e) {
        print(e.code);
      }
    }
  }
}
