//import 'package:begin/Hay.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Result2.dart';
import 'result1.dart';

bool flag14 = true;

class TestEdit2 extends StatefulWidget {
  static String id = 'Test';
  int counter = 0;
  @override
  _TestEdit2State createState() => _TestEdit2State();
}

class _TestEdit2State extends State<TestEdit2> {
  Color r = Color.fromRGBO(224, 13, 35, 1);
  Color g = Color.fromRGBO(0, 200, 23, 1);
  int questionIndex = 0;
  int questionCurrentIndex = 0;
  var flag = true;
  var flag2 = true;
  var flag3 = true;
  var flag4 = true;
  var flag5 = true;
  var flag6 = true;
  var flag7 = true;
  var flag8 = true;
  var flag9 = true;
  var flag10 = true;
  var flag11 = true;
  var flag12 = true;
  var flag13 = true;

  void changeColor() {
    setState(() {
      // ignore: unnecessary_statements
      (flag) ? Colors.white : Color.fromRGBO(0, 200, 23, 1);
      flag = !flag;
    });
  }

  final question = [
    ' Hello... This test is to measure'
        ' if you are eligable for blood donation or not,are you donate with blood in the last 3 monthes', //[0]
    // renewed every three months if you have a Temporary objection to donation blood ,Go to test again and edit your answers',
    'Next..... this test is to'
        ' measure if you have blood diseases like anaemia or blood pressure ?', //[1]
    'Are you taking drugs or Tranquilizers or any other tablets related to them?', //can edit //[2]
    'Are you diabetic ? if yes is  your diabetes level unregular now?', //can //[3]
    'Are you aged less than 18 or more than 60 ?', //can //[5]
    'Did you have any surgery in the last year ?', //can //[6]
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Blood donation validity test',
          style: TextStyle(
            fontFamily: 'Comic Sans MS',
            fontWeight: FontWeight.bold,
            fontSize: 20,

            // fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: r,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      //child: ClipRRect(
                      // borderRadius: BorderRadius.circular(18),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
                      height: 1.0,
                      width: 2.0,
                      color: Colors.red,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      //child: ClipRRect(
                      // borderRadius: BorderRadius.circular(18),
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: Color.fromRGBO(0, 200, 23, 1),
                        child: Text(
                          "1",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        //  onPressed: () {},
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 100, 0, 50),
                      height: 1.0,
                      width: 1.0,
                      color: Colors.red,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      //child: ClipRRect(
                      // borderRadius: BorderRadius.circular(18),
                    ),
                    Container(
                      height: 1.0,
                      width: 10.0,
                      color: Colors.red,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      //child: ClipRRect(
                      // borderRadius: BorderRadius.circular(18),
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor:
                            (flag4) ? r : Color.fromRGBO(0, 200, 23, 1),
                        child: Text(
                          "2",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 1.0,
                      width: 10.0,
                      color: Colors.red,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      //child: ClipRRect(
                      // borderRadius: BorderRadius.circular(18),
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor:
                            (flag5) ? r : Color.fromRGBO(0, 200, 23, 1),
                        child: Text(
                          "3",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 1.0,
                      width: 10.0,
                      color: Colors.red,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      //child: ClipRRect(
                      // borderRadius: BorderRadius.circular(18),
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor:
                            (flag6) ? r : Color.fromRGBO(0, 200, 23, 1),
                        child: Text(
                          "4",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 1.0,
                      width: 10.0,
                      color: Colors.red,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      //child: ClipRRect(
                      // borderRadius: BorderRadius.circular(18),
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor:
                            (flag7) ? r : Color.fromRGBO(0, 200, 23, 1),
                        child: Text(
                          "5",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 1.0,
                      width: 10.0,
                      color: Colors.red,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      //child: ClipRRect(
                      // borderRadius: BorderRadius.circular(18),
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor:
                            (flag8) ? r : Color.fromRGBO(0, 200, 23, 1),
                        child: Text(
                          "6",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 3.0,
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(25.0, 0.0, 25.0, 0.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Color.fromRGBO(247, 101, 101, 1.0),
                ),

                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        question[questionIndex],
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          fontFamily: "Arial",
                          wordSpacing: 0.5,
                          height: 1.3,
                        ),
                      ),
                    ),
                    SizedBox(height: 30.0,),
                    Padding(
                      padding: const EdgeInsetsDirectional.all(20.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: TextButton.styleFrom(
                                fixedSize: Size(0.0,35.0),
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                              onPressed: () {
                                showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return CustomDialog2(
                                        describtion1:
                                            'your last answer means that you have objection to donation blood. ',
                                        buttonText: 'Ok',
                                        buttonText2: 'back',
                                        img: AssetImage("assets/images/14.png"),
                                      );
                                    });
                              },
                              child: Text(
                                " Yes ",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromRGBO(100, 100, 100, 1),
                                  fontFamily: 'Bell MT',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 40.0),
                          Expanded(
                            child: ElevatedButton(
                              style: TextButton.styleFrom(
                                fixedSize: Size(0.0,35.0),
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  flag2 = !flag2;
                                  questionIndex += 1;

                                  if (questionIndex == 1) {
                                    flag4 = !flag4;
                                  } else if (questionIndex == 2) {
                                    flag5 = !flag5;
                                  } else if (questionIndex == 3) {
                                    flag6 = !flag6;
                                  } else if (questionIndex == 4) {
                                    flag7 = !flag7;
                                  } else if (questionIndex == 5) {
                                    flag8 = !flag8;
                                    showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (BuildContext context) {
                                          return CustomDialog(
                                            describtion1:
                                                'You have passed the test and initially got ready to donate. if you have a permanent objection to donation blood ,Go to test again and edit your anwser. ',
                                            buttonText: 'Ok',
                                            img: AssetImage("assets/images/4.png"),
                                          );
                                        });
                                  }
                                });
                              },
                              child: Text(
                                " No ",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromRGBO(100, 100, 100, 1),
                                  fontFamily: 'Bell MT',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (questionIndex == 0)
                      ElevatedButton(
                        style: TextButton.styleFrom(
                          fixedSize: Size(150.0, 35.0),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          " Exit ",
                          style: TextStyle(
                            fontSize: 20,
                            color: Color.fromRGBO(100, 100, 100, 1),
                            fontFamily: 'Bell MT',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    SizedBox(height: 30.0,),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
