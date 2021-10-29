import 'dart:ui';
import 'package:hexcolor/hexcolor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login.dart';

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
    Size screenSize = MediaQuery.of(context).size;
    return SafeArea(child: 
    Scaffold(
      key: loginKey,
        body: SingleChildScrollView(
            child: Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 10, right: 350),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios,size: 30,),
             color: Colors.black,
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ));
            },
          ),
        ),
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
                    fontSize: 35.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 15.0),
              Container(
                child: Image.asset("assets/images/forget.jpeg",scale: 0.1,),
                height: 180,
                width: 180,
              ),
              SizedBox(height: 15.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: Text(
                  "Enter the email address associated with your account ",
                  // textAlign: TextAlign.center,
                  style: TextStyle(
                    color: HexColor("#E52121"),
                    fontSize: 20.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              SizedBox(height: 12.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60.0),
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
                padding: const EdgeInsets.only(left: 50.0),
                child: Text(
                  "to reset your password",
                  //textAlign: TextAlign.center,
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
              SizedBox(height: 30.0),
              Container(
                  //height: 20.0,
                  width: 200.0,
                  margin: EdgeInsets.only(top: 45.0),
                  child: RaisedButton(
                    padding: EdgeInsets.symmetric(vertical:8,horizontal:5),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    child: Text(
                      " Send ",
                      style: TextStyle(
                        color: HexColor("#FFFFFF"),
                        fontSize: 35,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    onPressed: () {
                      forgetPass();
                      // try {
                      //   instance.sendPasswordResetEmail(email: this._email);

                      //   Navigator.of(context).pop();
                      // } catch (e) {
                      //   print(e.code);
                      // }
                    },
                    color: Colors.red,
                  ))
            ],
          ),
        )
      ],
    ))));
  }

  forgetPass() {
    final formData = _formKey.currentState;
    if (formData.validate()) {
      formData.save();
      try {
        instance.sendPasswordResetEmail(email: this._email);

        Navigator.of(context).pop();
      }
      catch (e) {
        print(e.code);
      }
    }
  }
}
