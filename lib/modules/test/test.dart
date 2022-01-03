import 'package:Conneect_Firebase/modules/profile.dart';
import 'package:flutter/material.dart';
import 'Result2.dart';
import 'result1.dart';

bool flag14 = true;

class Test extends StatefulWidget {
  static String id = 'Test';

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  Color r = Color.fromRGBO(224, 13, 35, 1);
  Color g = Color.fromRGBO(0, 200, 23, 1);
  int counter = 0;
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
        ' if you are eligible for blood donation or not, Are you donate with blood in the last 3 months', //[0]
    'Next..... this test is to'
        ' measure if you have blood diseases like anaemia or blood pressure ?', //[1]
    'Are you taking drugs or Tranquilizers or any other tablets related to them?', //can edit //[2]
    'Are you diabetic ? if yes is  your diabetes level unregular now?', //can //[3]
    'Are you liverish or have hepatitis  b or c?', //[4]
    'Are you aged less than 18 or more than 60 ?', //can //[5]
    'Did you have any surgery in the last year ?', //can //[6]
    'Do you Have Aids or any infectious diseases??', //[7]
    'This test is to check if you have Asthma or long time chest diseases?', //[8]
    'Finally ...we would like to know if you have any heart diseases or you are taking digitization medicine ?', //[9]
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
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(top: 100.0),
                      child: Container(
                        height: 1.0,
                        width: 2.0,
                        color: Colors.red,
                      ),
                    ),
                    CircleAvatar(
                      radius: 15,
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
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 100, 0, 50),
                      height: 1.0,
                      width: 1.0,
                      color: Colors.red,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                    ),
                    Container(
                      height: 1.0,
                      width: 10.0,
                      color: Colors.red,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: CircleAvatar(
                        radius: 15,
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
                      child: CircleAvatar(
                        radius: 15,
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
                      child: CircleAvatar(
                        radius: 15,
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
                      child: CircleAvatar(
                        radius: 15,
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
                      child: CircleAvatar(
                        radius: 15,
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
                    Container(
                      height: 1.0,
                      width: 10.0,
                      color: Colors.red,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor:
                            (flag9) ? r : Color.fromRGBO(0, 200, 23, 1),
                        child: Text(
                          "7",
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
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor:
                            (flag10) ? r : Color.fromRGBO(0, 200, 23, 1),
                        child: Text(
                          "8",
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
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor:
                            (flag11) ? r : Color.fromRGBO(0, 200, 23, 1),
                        child: Text(
                          "9",
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
                      child: CircleAvatar(
                        radius: 16,
                        backgroundColor:
                            (flag12) ? r : Color.fromRGBO(0, 200, 23, 1),
                        child: Text(
                          "10",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
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
                                if (questionIndex == 0 ||
                                    questionIndex == 1 ||
                                    questionIndex == 2 ||
                                    questionIndex == 3 ||
                                    questionIndex == 5 ||
                                    questionIndex == 6) {
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
                                } else {
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
                                }
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
                                  } else if (questionIndex == 6) {
                                    flag9 = !flag9;
                                  } else if (questionIndex == 7) {
                                    flag10 = !flag10;
                                  } else if (questionIndex == 8) {
                                    flag11 = !flag11;
                                  } else if (questionIndex == 9) {
                                    flag12 = !flag12;
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
                                  color: Color.fromRGBO(100, 100, 100, 1),
                                  fontSize: 20,
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
                            color: Color.fromRGBO(100, 100, 100, 1),
                            fontSize: 20,
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
