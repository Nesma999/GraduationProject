import 'package:Conneect_Firebase/pages/profileGreen.dart';
import 'package:Conneect_Firebase/pages/profileRed.dart';
import 'package:Conneect_Firebase/pages/test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'EditAnswer.dart';
import 'Profile.dart';
import 'drawer.dart';
import 'image.dart';

class EditAgeRed extends StatefulWidget {
  @override
  EditAgeRedState createState() => EditAgeRedState();
}

class EditAgeRedState extends State<EditAgeRed> {
  var backG = Color.fromRGBO(229, 33, 33, 1);
  final GlobalKey<FormState> _formKey = GlobalKey();
  String name,
      phone,
      age,
      email,
      addressline,
      country,
      subadmin,
      img,
      adminarea,
      password,
      bloodType;
  var lat, long;
  PickedFile _imageFile;
  File _fileImage;
  final ImagePicker _picker = ImagePicker();
  final _scaffoldkey = GlobalKey<ScaffoldState>();
  ProfileWidgetState profile = new ProfileWidgetState();
  photo() async {
    final pickedFile = await _picker.getImage(
      source: ImageSource.camera,
    );
    setState(() {
      _imageFile = pickedFile;
    });
    var file = File(_imageFile.path);

    final ref1 = FirebaseStorage.instance
        .ref()
        .child('user_image')
        .child(_imageFile.path);
    await ref1.putFile(file);
    final url = await ref1.getDownloadURL();

    final user = await FirebaseAuth.instance.currentUser;
    DocumentReference ref =
        FirebaseFirestore.instance.collection('users').doc(user.uid);
    ref.update({'imageurl': url});
    _scaffoldkey.currentState.showSnackBar(SnackBar(
      content: Text('Your Picture Updated'),
    ));
  }

  insertimage() async {
    final pickedFile = await _picker.getImage(
      source: ImageSource.gallery,
    );
    setState(() {
      _imageFile = pickedFile;
    });
    var file = File(_imageFile.path);
    final ref1 = FirebaseStorage.instance
        .ref()
        .child('user_image')
        .child(_imageFile.path);
    await ref1.putFile(file);
    final url = await ref1.getDownloadURL();
    final user = await FirebaseAuth.instance.currentUser;

    DocumentReference ref =
        FirebaseFirestore.instance.collection('users').doc(user.uid);
    ref.update({'imageurl': url});
    _scaffoldkey.currentState
        .showSnackBar(SnackBar(content: Text('Your Picture Updated')));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          backgroundColor: Color(0xffe60000),
          elevation: 0.0,
          actions: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
              child: FloatingActionButton(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.add,
                    size: 25,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser.uid)
                        .get()
                        .then((snapshot) {
                      if (snapshot.data()['flag'] == '0') {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Test()));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TestEdit2()));
                      }
                    });
                  }
                  ),
            ),
          ],
        ),
        preferredSize: Size.fromHeight(60),
      ),
      drawer: Drawer(
        child: DrawerScreen(),
      ),
      key: _scaffoldkey,
      body: new ListView(
        children: <Widget>[
          new Column(
            children: <Widget>[
              Container(
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  overflow: Overflow.visible,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            height: 150.0,
                            color: backG,
                          ),
                        )
                      ],
                    ),
                    //floatAction(),
                    //userName(),
                    profile.userName(),
                    profile.userimageProfile(),
                  ],
                ),
              ),
             Row(children: [
               SizedBox(width: 95,),
              verify(),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Container(
                  width: 45,
                  height: 45,
                  child: IconButton(
                    icon: Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: () => bottomSheetImage(context),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    color: backG,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 3.0,
                        color: Colors.grey,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                ),
              )]),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          profile.userEmail(),
          SizedBox(
            child: Divider(
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 15),
          profile.userPhone(),
          SizedBox(
            child: Divider(
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 15),
          profile.userLocation(),
          SizedBox(
            child: Divider(
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Icon(Icons.email, color: Colors.red),
              SizedBox(width: 4),
              Text(
                "Age :",
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Arial',
                    color: Color.fromRGBO(235, 125, 125, 1)),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Form(
                  key: _formKey,
                  child: Container(
                    width: 270,
                    height: 40,
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Enter your Age",
                        hintStyle: TextStyle(
                          color: Color.fromRGBO(154, 141, 141, 1),
                          fontSize: 18,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.add_box_outlined,
                            size: 30,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            update();
                          },
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          age = value;
                        });
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(width: 30),
            ],
          ),
            SizedBox(height: 15),
          SizedBox(
            child: Divider(
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 15),
          profile.userBloodType(),
          SizedBox(height: 15),
          SizedBox(
            child: Divider(
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 15),
          profile.userBloodDonationValidity(),
          SizedBox(height: 15),
          SizedBox(
            child: Divider(
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }

  Widget bottomSheetImage(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext c) {
          return Container(
            height: 100.0,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            child: Column(
              children: <Widget>[
                Text(
                  "Choose Profile Photo",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton.icon(
                      icon: Icon(Icons.camera),
                      onPressed: () {
                        photo();
                        //Navigator.of(context).pop();
                      },
                      label: Text("Camera"),
                    ),
                    FlatButton.icon(
                      icon: Icon(Icons.image),
                      onPressed: () {
                        insertimage();
                      },
                      label: Text("Gallery"),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
  verify(){
    return  Padding(
                padding: EdgeInsets.fromLTRB(0, 30, 135, 0),
                child: Container(
                  width: 45,
                  height: 45,
                  child: Icon(
                      FontAwesomeIcons.exclamationTriangle,
                      color: Colors.red,
                      size: 30,
                    ),
                ),
              );
  }
  void update() async {
    final user = await FirebaseAuth.instance.currentUser;
    DocumentReference ref =
    FirebaseFirestore.instance.collection('users').doc(user.uid);
    ref.update({
      'age': age,
    });
    FirebaseFirestore.instance
                      .collection('users')
                      .doc(user.uid)
                      .get()
                      .then(
                    (snapshot) {
                      if (snapshot.data()['donor validity'] == 'yes') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfileGreen()));
                      } else if (snapshot.data()['donor validity'] == 'no') {
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
                    });  }
  }

