import 'package:Conneect_Firebase/Components/components.dart';
import 'package:Conneect_Firebase/Admin/Dash.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:Conneect_Firebase/modules/home.dart';
import 'package:Conneect_Firebase/modules/forget_password.dart';
import 'package:Conneect_Firebase/modules/registration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'BackGraund.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  RegisterState verify = new RegisterState();
  User user;
  bool passordVisible = true;
  var w = Colors.white;
  var gr = Color.fromRGBO(230, 230, 230, 1);
  var b = Colors.black;
  var bl = Colors.blue;
  var r = Colors.red;
  var g = Colors.blueGrey;
  var str = "name";
  int state = 1;
  final GlobalKey<FormState> _formKey = GlobalKey();
  String _email, _password;
  var loginKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height * 0.30;
    return SafeArea(
        child: Scaffold(
          key: loginKey,
          body: ListView(
          //like column but support scrolling
          children: <Widget>[
            ClipPath(
              // will draw the wave
              clipper: BezierClipper(state),
              child: Container(
                color: Color(0xffe60000),
                height: height,
                child: Center(
                  child: Text(
                    "Welcome back!",
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w900,
                      fontFamily: "Arial",
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    SizedBox(height: 82),
                    Form(
                      key: _formKey,
                      child: Column(
                          children: [
                        defaultTextField(
                          text: 'Enter your email',
                          keyboard: TextInputType.emailAddress,
                          validate: (val) {
                            if (val.isEmpty) {
                              return "this field is required";
                            } else if (!val.contains('@') ||
                                !val.contains('.com') ||
                                !val.contains('gmail')) {
                              return "invalid email";
                            }
                            if (!RegExp(
                                    "^[a-zA-Z0-9+.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                .hasMatch(val)) {
                              return "Please Enter Invalid Email";
                            }
                          },
                          onSave: (val) {
                            _email = val;
                          },
                        ),
                        SizedBox(height: 20),
                        defaultTextField(
                            text: 'Enter your Password',
                            keyboard: TextInputType.visiblePassword,
                            suffix: passordVisible ? Icons.visibility : Icons.visibility_off ,
                            color: Color(0xffe60000),
                            isPass: passordVisible,
                            icon: (){
                              setState(() {
                                passordVisible = !passordVisible;
                              });
                            },
                            validate: (val) {
                              if (val.isEmpty) {
                                return "this field is required";
                              } else if (val.length <= 5) {
                                return "Password is too short";
                              }
                              return null;
                            },
                            onSave: (val) {
                              _password = val;
                            },
                        ),
                        SizedBox(height: 15),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.only(start: 180.0),
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ForgetPassword()));
                            },
                            child: Text(
                              'Forget Password?',
                              style: TextStyle(
                                color: Color(0xffCC6E6E),
                                fontSize: 15,
                                fontFamily: "Arial",
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        defaultButton(
                          width: 140.0,
                          size: 10,
                            text: 'Login',
                            tap: (){
                              login();
                            }
                        ),
                        SizedBox(height: 12.0),
                        Text(
                          "OR",
                          style: TextStyle(
                            color: Color(0xff2A2222),
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Don't have an account? ",
                              style: TextStyle(
                                color: Color(0xff2A2222),
                                fontSize: 16,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Register()));
                              },
                              child: Text(
                                "SignUp",
                                style: TextStyle(
                                  color: Color(0xffE17373),
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
            ),
          ]),
    ));
  }

  Future<void> login() async {
    final formData = _formKey.currentState;
    if (formData.validate()) {
      formData.save();
      print(_email);
      try {
        UserCredential credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
        FirebaseFirestore.instance
            .collection('users')
            .doc(credential.user.uid)
            .get()
            .then((snapshot) {
          if (snapshot.data()['role'] == 'Admin') {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Dash()),
                (Route<dynamic> route) => false);
          } else {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => MyHomePage()),
                (Route<dynamic> route) => false);
          }
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          //shwo snackbar
          loginKey.currentState.showSnackBar(SnackBar(
            content: Text("User Not Found"),
          ));
        } else if (e.code == 'wrong-password') {
          //shwo snackbar
          loginKey.currentState.showSnackBar(SnackBar(
            content: Text("Your Password Is Wrong"),
          ));
        } else if (e.code == 'invalid-email') {
          //shwo snackbar
          loginKey.currentState.showSnackBar(SnackBar(
            content: Text("Invalid Email"),
          ));
        } else if (e.code == 'user-disabled') {
          //shwo snackbar
          loginKey.currentState.showSnackBar(SnackBar(
            content: Text("User Disabled"),
          ));
        }
      } catch (e) {
        print(e.code);
      }
    }
  }

  showDialogFun(context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Container(
              height: 200,
              child: Container(
                padding: EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                      child: Text(
                        "Please verify your email.",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.fromLTRB(60, 0, 0, 0),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        },
                        child: Text("OK",
                            style: TextStyle(
                                fontSize: 35, color: Color(0xFFFFFFFF))),
                        color: Color(0xffe60000),
                        padding:
                            EdgeInsets.symmetric(vertical: 7, horizontal: 45),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
