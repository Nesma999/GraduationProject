import 'package:Conneect_Firebase/Components/components.dart';
import 'package:flutter/material.dart';
import 'package:Conneect_Firebase/modules/login/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'BackGraund.dart';
class Register extends StatefulWidget {
  static String id = 'FormScreen';
  @override
  State<StatefulWidget> createState() {
    return RegisterState();
  }
}

class RegisterState extends State<Register> {
  var backG = Color.fromRGBO(229, 33, 33, 1);
  var gr = Color.fromRGBO(230, 230, 230, 1);
  var b = Colors.black;
  var w = Colors.white;
  User user;
  bool passwordShow = true;
  bool isPasswordShow = true;
  String _name,
      _phone,
      _age,
      email,
      _password,
      _bloodeType;
  int state = 1;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var fCode = GlobalKey<FormState>();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  var loginKey = GlobalKey<ScaffoldState>();
  FirebaseAuth instance = FirebaseAuth.instance;
  var locationMessage = "Location";
  var lat, long, country, adminarea, addressline, subadmin, code;
  _getLocation() async {
    var position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    lat = position.latitude;
    long = position.longitude;
    final coordinates = new Coordinates(lat, long);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    country = addresses.first.countryName;
    adminarea = addresses.first.adminArea;
    addressline = addresses.first.addressLine;
    subadmin = addresses.first.subAdminArea;
    setState(() {
      locationMessage =
          " AdminArea : $adminarea \n Country : $country \n addressline: $addressline \n subadminarea : $subadmin";
    });
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height * 0.25;
    return SafeArea(
      child: Scaffold(
        key: loginKey,
        body: SingleChildScrollView(
          child: Column(
            children: [
              ClipPath(
                // will draw the wave
                clipper: BezierClipper(state),
                child: Container(
                  color: Color(0xffe60000),
                  height: height,
                  child: Center(
                    child: Text(
                      "Create Account",
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
              SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      defaultTextField(
                        text: 'User Name',
                        keyboard: TextInputType.text,
                        suffix: Icons.person_pin_rounded,
                        color: Colors.black54,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'This field is Required';
                          }
                          if (value.length < 3) {
                            return 'Name Must Be at least 3 characters';
                          }
                          if (value.length > 30) {
                            return 'You exceed characters limits';
                          }
                          if (value.contains('@') ||
                              value.contains('*') ||
                              value.contains('/') ||
                              value.contains('+')) {
                            return 'invalid username';
                          }
                        },
                        onSave: (String value) {
                          _name = value;
                        },
                      ),
                      SizedBox(height: 16.0),
                      defaultTextField(
                        text: 'Email Address',
                        keyboard: TextInputType.emailAddress,
                        suffix: Icons.email,
                        color: Colors.black54,
                        validate: (value) {
                          if (value.isEmpty) {
                            return 'This field is Required';
                          }
                          if (!RegExp("^[a-zA-Z0-9+.-]+@[a-zA-Z0-9.-]+.[a-z]")
                              .hasMatch(value)) {
                            return "Please Enter Invalid Email";
                          } else if (!value.contains('.com') ||
                              !value.contains('gmail')) {
                            return "invalid email";
                          }
                        },
                        onSave: (value) {
                          email = value;
                        },
                      ),
                      SizedBox(height: 16.0),
                      defaultTextField(
                        text: 'Phone Number',
                        keyboard: TextInputType.phone,
                        suffix: Icons.phone_enabled,
                        color: Colors.black54,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'This field is Required';
                          }
                          if (value.contains('@') ||
                              value.contains('*') ||
                              value.contains('/') ||
                              value.contains('+') ||
                              value.contains('(') ||
                              value.contains(')') ||
                              value.contains('=') ||
                              value.contains('?') ||
                              value.contains('>') ||
                              value.contains('<') ||
                              value.contains(',') ||
                              value.contains('.') ||
                              value.contains('[') ||
                              value.contains(']') ||
                              value.contains('{') ||
                              value.contains('}') ||
                              value.contains('"') ||
                              value.contains(';') ||
                              value.contains(':') ||
                              value.contains('_') ||
                              value.contains('-') ||
                              value.contains('&') ||
                              value.contains('^') ||
                              value.contains('%') ||
                              value.contains('!') ||
                              value.contains('،') ||
                              value.contains('|') ||
                              value.contains('~')) {
                            return 'phone number mustn\'t contain special characters';
                          }
                          if (RegExp("[a-zA-Z]").hasMatch(value)) {
                            return "Phone number mustn\'t be characters";
                          }
                          if (value.length != 11) {
                            return 'Phone number must be 11 numbers';
                          }
                          if (value.contains('-')) {
                            return 'Phone number mustn\'t be negative number';
                          }
                        },
                        onSave: (String value) {
                          _phone = value;
                        },
                      ),
                      SizedBox(height: 16.0),
                      defaultTextField(
                        text: 'Age',
                        keyboard: TextInputType.number,
                        suffix: Icons.perm_contact_calendar,
                        color: Colors.black54,
                        validate: (String value) {
                          int ages = int.tryParse(value);

                          if (ages == null) {
                            return 'This field is Required';
                          }
                          if (ages == 0) {
                            return 'Age mustn\'t be zero';
                          }
                          if (ages < 15) {
                            return 'minimum age is 15';
                          }
                          if (ages > 90) {
                            return 'maximum age is 90';
                          }
                          return null;
                        },
                        onSave: (String value) {
                          _age = value;
                        },
                      ),
                      SizedBox(height: 16.0),
                      defaultTextField(
                        text: 'Blood Type',
                        keyboard: TextInputType.text,
                        suffix: Icons.local_fire_department_rounded,
                        color: Colors.black54,
                        validate: (value) {
                          if (value.isEmpty) {
                            return 'This field is Required';
                          }
                          return null;
                        },
                        onSave: (String value) {
                          _bloodeType = value;
                        },
                      ),
                      SizedBox(height: 16.0),
                      defaultTextField(
                        maxLines: 5,
                        text: locationMessage,
                        keyboard: TextInputType.number,
                        suffix: Icons.location_on,
                        size: 30,
                        showCursor: false,
                        readOnly: true,
                        color: Colors.black54,
                        icon: () {
                          _getLocation();
                        },
                        onTap: () {
                          _getLocation();
                        },
                        validate: (value) {
                          if (locationMessage.isEmpty) {
                            return 'This field is Required';
                          }
                        },
                        onSave: (String value) {
                          locationMessage = value;
                        },
                      ),
                      SizedBox(height: 16.0),
                      defaultTextField(
                        control: password,
                        text: 'Password',
                        keyboard: TextInputType.visiblePassword,
                        suffix: passwordShow
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.black54,
                        isPass: passwordShow,
                        icon: () {
                          setState(() {
                            passwordShow = !passwordShow;
                          });
                        },
                        validate: (value) {
                          if (value.isEmpty) {
                            return 'This field is Required';
                          } else if (value.length <= 5) {
                            return "Password is too short";
                          } else if (value.length > 15) {
                            return "Password is too Long";
                          }
                        },
                        onSave: (value) {
                          _password = value;
                        },
                      ),
                      SizedBox(height: 16.0),
                      defaultTextField(
                        control: confirmpassword,
                        text: 'Confirm Password',
                        keyboard: TextInputType.visiblePassword,
                        suffix: isPasswordShow
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.black54,
                        isPass: isPasswordShow,
                        icon: () {
                          setState(() {
                            isPasswordShow = !isPasswordShow;
                          });
                        },
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'This field is Required';
                          }
                          if (password.text != confirmpassword.text) {
                            return "Password does not match";
                          }
                          if (value.length < 5) {
                            return "Password must be at least 5 Characters";
                          }
                        },
                        onSave: (value) {
                          _password = value;
                        },
                      ),
                      SizedBox(height: 16.0),
                      defaultButton(
                        width: 140.0,
                        size: 10,
                          text: 'SignUp',
                          tap: () {
                            register();
                          }),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account?',
                            style: TextStyle(
                              color: Color(0xff2A2222),
                              fontSize: 16,
                            ),
                          ),
                          TextButton(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                color: Color(0xffE17373),
                                fontSize: 16,
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()));
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> register() async {
    final formData = _formKey.currentState;
    if (formData.validate()) {
      formData.save();
      //verificationEmail();
      try {
        UserCredential credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: _password);
        FirebaseFirestore.instance
            .collection('users')
            .doc(credential.user.uid)
            .set({
          'name': this._name,
          'age': this._age,
          'phone': this._phone,
          'long': long,
          'lat': lat,
          'adminarea': adminarea,
          'addressline': addressline,
          'subadminarea': subadmin,
          'country': country,
          'imageurl':
          'https://i.pinimg.com/564x/04/28/f5/0428f5706e19f681febc5aa677d7e282.jpg',
          'userid': credential.user.uid,
          'role': 'notAdmin',
          'BloodType': _bloodeType.toUpperCase(),
          "flag": "0",
          "donor validity": "-",
        });
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          loginKey.currentState.showSnackBar(SnackBar(
            content: Text("Email already exist"),
          ));
        } else if (e.code == 'weak-password') {
          //shwo snackbar
          loginKey.currentState.showSnackBar(SnackBar(
            content: Text("Your Password Is weak"),
          ));
        } else if (e.code == 'invalid-email') {
          //shwo snackbar
          loginKey.currentState.showSnackBar(SnackBar(
            content: Text("Invalid Email"),
          ));
        }
      } catch (e) {
        print(e.code);
      }
    }
  }
  }
  // void verificationEmail() async {
  //   EmailAuth.sessionName = "Blood Donation";
  //   var ref = await EmailAuth.sendOtp(receiverMail: email);
  //   if(ref) {
  //     print("code send");
  //     showDialogFun(context);
  //   }else {
  //     print("code not send");
  //   }
  // }
  //
  // void verifyCode() async {
  //   var ref = EmailAuth.validate(receiverMail: email, userOTP: code);
  //   if (ref) {
  //     print("code verifed");
  //     try {
  //       UserCredential credential = await FirebaseAuth.instance
  //           .createUserWithEmailAndPassword(email: email, password: _password);
  //       FirebaseFirestore.instance
  //           .collection('users')
  //           .doc(credential.user.uid)
  //           .set({
  //         'name': this._name,
  //         'age': this._age,
  //         'phone': this._phone,
  //         'long': long,
  //         'lat': lat,
  //         'adminarea': adminarea,
  //         'addressline': addressline,
  //         'subadminarea': subadmin,
  //         'country': country,
  //         'imageurl':
  //             'https://i.pinimg.com/564x/04/28/f5/0428f5706e19f681febc5aa677d7e282.jpg',
  //         'userid': credential.user.uid,
  //         'role': 'notAdmin',
  //         'BloodType': _bloodeType,
  //         "flag": "0",
  //         "donor validity": "-",
  //       });
  //     } on FirebaseAuthException catch (e) {
  //       if (e.code == 'email-already-in-use') {
  //         loginKey.currentState.showSnackBar(SnackBar(
  //           content: Text("Email already exist"),
  //         ));
  //       } else if (e.code == 'weak-password') {
  //         //shwo snackbar
  //         loginKey.currentState.showSnackBar(SnackBar(
  //           content: Text("Your Password Is weak"),
  //         ));
  //       } else if (e.code == 'invalid-email') {
  //         //shwo snackbar
  //         loginKey.currentState.showSnackBar(SnackBar(
  //           content: Text("Invalid Email"),
  //         ));
  //       }
  //     } catch (e) {
  //       print(e.code);
  //     }
  //     Navigator.pushReplacement(
  //         context, MaterialPageRoute(builder: (context) => LoginPage()));
  //   } else {
  //     loginKey.currentState.showSnackBar(SnackBar(
  //       content: Text("Invalid Code"),
  //     ));
  //   }
  // }
  //
  // showDialogFun(context) {
  //   return showDialog(
  //        barrierDismissible: false,
  //       context: context,
  //       builder: (BuildContext context) {
  //         return Dialog(
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(20.0),
  //           ),
  //           child: SingleChildScrollView(
  //             child: Container(
  //               height: 500,
  //               width: double.infinity,
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   Padding(
  //                     padding: EdgeInsets.fromLTRB(80, 0, 80, 0),
  //                     child: Container(
  //                       width: 85,
  //                       height: 85,
  //                       child: IconButton(
  //                         icon: Icon(
  //                           Icons.email_rounded,
  //                           color: Colors.white,
  //                           size: 60,
  //                         ),
  //                         onPressed: () {},
  //                       ),
  //                       decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.circular(50.0),
  //                         color: backG,
  //                         boxShadow: [
  //                           BoxShadow(
  //                             blurRadius: 3.0,
  //                             color: Colors.grey,
  //                             offset: Offset(0, 0),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                   Padding(
  //                     padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
  //                     child: Text(
  //                       "Email Verification",
  //                       style: TextStyle(
  //                           fontSize: 25, fontWeight: FontWeight.bold),
  //                     ),
  //                   ),
  //                   Padding(
  //                     padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
  //                     child: Text(
  //                       "Enter the code sent to your email",
  //                       style: TextStyle(
  //                         fontSize: 15,
  //                       ),
  //                     ),
  //                   ),
  //                   Form(
  //                     key: fCode,
  //                     child: Padding(
  //                       padding: const EdgeInsets.all(20.0),
  //                       child: defaultTextField(
  //                         text: 'Enter Code',
  //                         keyboard: TextInputType.number,
  //                         validate: (value) {
  //                           if (value.isEmpty) {
  //                             return "this field is required";
  //                           }
  //                         },
  //                         onChange: (value) {
  //                           code = value;
  //                         },
  //                       ),
  //                     ),
  //                   ),
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       Text(
  //                         "Don't receive the code? ",
  //                         style: TextStyle(
  //                           color: Color(0xff2A2222),
  //                           fontSize: 15,
  //                         ),
  //                       ),
  //                       TextButton(
  //                         onPressed: () {
  //                           verificationEmail();
  //                         },
  //                         child: Text(
  //                           "RESEND",
  //                           style: TextStyle(
  //                             color: Color(0xffE17373),
  //                             fontSize: 15,
  //                           ),
  //                         ),
  //                       )
  //                     ],
  //                   ),
  //                   SizedBox(
  //                     height: 20.0,
  //                   ),
  //                   defaultButton(
  //                       text: 'Verify',
  //                       tap: () {
  //                         if(fCode.currentState.validate()) {
  //                           verifyCode();
  //                         }
  //                       }),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         );
  //       });
  // }
//}
