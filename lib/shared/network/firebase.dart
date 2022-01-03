import 'package:Conneect_Firebase/modules/usersProfile/editAge.dart';
import 'package:Conneect_Firebase/modules/usersProfile/editEmailScreen.dart';
import 'package:Conneect_Firebase/modules/usersProfile/editPhone.dart';
import 'package:Conneect_Firebase/modules/usersProfile/popupverifyemail.dart';
import 'package:Conneect_Firebase/modules/usersProfile/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Database{
  String name,
      nameU,
      phone,
      updatePhone,
      age,
      ageU,
      email,
      addressline,
      country,
      subadmin,
      img,
      adminarea,
      password,
      bloodType,
      type,
      validity;
  TextEditingController uEmail = TextEditingController();
  dynamic user;
  String user_email;
  getCurrentUserInfo() async {
    user = await FirebaseAuth.instance.currentUser;
    user_email = user.email;
  }
  getData() async {
    final user = await FirebaseAuth.instance.currentUser;
    if (user != null)
      return await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get()
          .then((value) {
        name = value.data()['name'];
        age = value.data()['age'];
        phone = value.data()['phone'];
        email = value.data()['email'];
        password = value.data()['password'];
        addressline = value.data()['addressline'];
        country = value.data()['country'];
        subadmin = value.data()['subadminarea'];
        adminarea = value.data()['adminarea'];
        img = value.data()['imageurl'];
        type = value.data()['BloodType'];
        validity = value.data()['donor validity'];
      }).catchError((e) {
        print(e);
      });
  }
  void updateMobile(BuildContext context) async {
    final user = await FirebaseAuth.instance.currentUser;
    DocumentReference ref =
    FirebaseFirestore.instance.collection('users').doc(user.uid);
    ref.update({
      'phone': updatePhone,
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
                    builder: (context) => ImageeState().profileGreen()));
          } else if (snapshot.data()['donor validity'] == 'no') {
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
        });  }
  void updateAge(BuildContext context) async {
    final user = await FirebaseAuth.instance.currentUser;
    DocumentReference ref =
    FirebaseFirestore.instance.collection('users').doc(user.uid);
    ref.update({
      'age': ageU,
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get()
        .then((snapshot) {
      if (snapshot.data()['donor validity'] == 'yes') {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ImageeState().profileGreen()));
      } else if (snapshot.data()['donor validity'] == 'no') {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ImageeState().profileRed()));
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Imagee()));
      }
    });
  }
  void updateName(BuildContext context) async {
    final user = await FirebaseAuth.instance.currentUser;
    DocumentReference ref =
    FirebaseFirestore.instance.collection('users').doc(user.uid);
    ref.update({
      'name': nameU,
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
                    builder: (context) => ImageeState().profileGreen()));
          } else if (snapshot.data()['donor validity'] == 'no') {
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
        });  }
  void updateEmail(BuildContext context) async {
    final user = await FirebaseAuth.instance.currentUser;
    user.verifyBeforeUpdateEmail(uEmail.text).then((_) {
      print("sucess");
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AdvanceCustomAlert();
          });
    }).catchError((err) {
      print("Email can't be changed ${err.toString()}");
    });
  }
  void navigatorEmail(BuildContext context){
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
                builder: (context) => EditEmailState().editEmailGreen()));
      } else if (snapshot.data()['donor validity'] ==
          'no') {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EditEmailState().editEmailRed()));
      } else {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EditEmail()));
        ;
      }
    });
  }
  void navigatorPhone(BuildContext context){
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
                builder: (context) => EditPhoneState().editPhoneGreen()));
      } else if (snapshot.data()['donor validity'] ==
          'no') {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EditPhoneState().editPhoneRed()));
      } else {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EditPhone()));
      }
    });
  }
  void navigatorAge(BuildContext context){
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
                builder: (context) => EditAgeState().editAgeGreen()));
      } else if (snapshot.data()['donor validity'] == 'no') {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>  EditAgeState().editAgeRed()));
      } else {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => EditAge()));
        ;
      }
    });
  }
}
