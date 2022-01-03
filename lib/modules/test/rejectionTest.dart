import 'package:Conneect_Firebase/modules/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'test.dart';

int counter = 0;
int counter2 = 0;

class TestResult2Page extends StatefulWidget {
  @override
  _TestResult2PageState createState() => _TestResult2PageState();
}

class _TestResult2PageState extends State<TestResult2Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(onPressed: () {
              /*   showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) {
                        return CustomDialog2(
                          describtion1:
                              'your last answer means that you have objection to donation blood. ',
                          buttonText: 'Ok',
                          buttonText2: 'back',
                        );
                      });
                      */
            }),
          ],
        ),
      ),
    );
  }
}

class Consts {
  static const double padding = 20;
  static const double avatarRadius = 66;
  Consts._();
}

class CustomDialog2 extends StatefulWidget {
  final String tiltle, describtion1, buttonText, buttonText2, buttonText3;

  final img;

  CustomDialog2({
    Key key,
    this.tiltle,
    this.describtion1,
    this.buttonText,
    this.buttonText3,
    this.img,
    this.buttonText2,
  }) : super(key: key);

  @override
  _CustomDialog2State createState() => _CustomDialog2State();
}

class _CustomDialog2State extends State<CustomDialog2> {
  Color w = Colors.white;
  Color b = Colors.black;
  Color g = Colors.green;
  Color r = Color.fromRGBO(242, 7, 50, 1);
  Color r2 = Color.fromRGBO(242, 7, 50, 1);
  bool flag2 = true;
  bool flag3 = true;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: DialogContent(context),
    );
  }

  DialogContent(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: 82,
            bottom: Consts.padding,
            right: Consts.padding,
            left: Consts.padding,
          ),
          margin: EdgeInsets.only(
            top: Consts.avatarRadius,
          ),
          decoration: BoxDecoration(
              color: w,
              borderRadius: BorderRadius.circular(45),
              shape: BoxShape.rectangle,
              boxShadow: [
                BoxShadow(color: b, blurRadius: 20, offset: Offset(0, 10)),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: Consts.padding),
              Text(
                widget.describtion1,
                textAlign: TextAlign.center,
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  fontSize: 22,
                  color: r2,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: Consts.padding),
              Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      style: TextButton.styleFrom(
                        fixedSize: Size(0.0,40.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                            side: BorderSide(width: 2, color: Colors.black12)),
                        backgroundColor: flag2 ? w : g,
                      ),
                      child: Text(widget.buttonText,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w800,color: flag2 ? r : w,)),
                      onPressed: () {
                        fail();
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => ImageeState().profileRed()));
                        counter++;

                        setState(() {
                          flag2 = !flag2;
                          flag14 = true;
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 15.0),
                  Expanded(
                    child: ElevatedButton(
                     style: TextButton.styleFrom(
                       fixedSize: Size(0.0,40.0),
                       shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(50),
                           side: BorderSide(width: 2, color: Colors.black12)),
                       backgroundColor: flag3 ? w : r,
                     ),
                      child: Text(widget.buttonText2,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w800,color: flag3 ? r : w,)),
                      onPressed: () {
                        Navigator.of(context).pop();
                        setState(() {
                          flag3 = !flag3;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
          height: 140,
          width: 120,
          padding: EdgeInsetsDirectional.only(top: 18.0),
          child: CircleAvatar(
            backgroundImage: widget.img, // AssetImage("assets/images/14.png"),
            backgroundColor: w,
            radius: 60,
          ),
        )
      ],
    );
  }

  void fail() async {
    final user = await FirebaseAuth.instance.currentUser;
    DocumentReference ref =
        FirebaseFirestore.instance.collection('users').doc(user.uid);
    ref.update({
      "flag": "1",
      "donor validity": "no",
    });
  }
}
