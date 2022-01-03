import 'package:Conneect_Firebase/Components/components.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'donorList.dart';

class DashBoard extends StatefulWidget {
  static String id = '';
  @override
  DashBoardState createState() => DashBoardState();
}

class DashBoardState extends State<DashBoard> {
  var countA, countA1, countB1, countB2, countAB1, countAB2, countO1, countO2;
  var color = Color.fromRGBO(236, 118, 118, 1);
  var color2 = Color.fromRGBO(243, 147, 147, 1);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.red,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(children: <Widget>[
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: TextButton.styleFrom(
                      fixedSize: Size(0.0,40.0),
                      backgroundColor: Color.fromRGBO(227, 152, 152, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(color: Colors.grey[300]),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => DashBoard()));
                    },
                    child: Text(
                      "DashBoard",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: ElevatedButton(
                    style: TextButton.styleFrom(
                      fixedSize: Size(0.0,40.0),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: Colors.grey[300],
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => DonorList()));
                    },
                    child: Text(
                      "Donor List",
                      style: TextStyle(
                          color: Color.fromRGBO(222, 144, 144, 1),
                          fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Row(children: [
              defaultDashBoard(
                  color: color,
                  text: 'A+',
                  futureBuilder: FutureBuilder(
                      future: counta(),
                      builder: (context, snapshot){
                        return defaultCountDash(label: '$countA');
                      }
                  ),
              ),
              SizedBox(
                width: 20.0,
              ),
              defaultDashBoard(
                  color: color,
                  text: 'A-',
                  futureBuilder: FutureBuilder(
                      future: countaminus(),
                      builder: (context, snapshot){
                        return defaultCountDash(label: '$countA1');
                      },
                  ),
              ),
            ]),
            SizedBox(
              height: 45,
            ),
            Row(children: [
              defaultDashBoard(
                  color: color2,
                  text: 'B+',
                  futureBuilder: FutureBuilder(
                      future: countBplus(),
                      builder: (context, snapshot){
                        return defaultCountDash(
                          label: '$countB1',
                        );
                      },),
              ),
              SizedBox(
                width: 20.0,
              ),
              defaultDashBoard(
                  color: color2,
                  text: 'B-',
                  futureBuilder: FutureBuilder(
                    future: countBMINUS(),
                      builder: (context, snapshot){
                      return defaultCountDash(label: '$countB2');
                      },
                  ),
              ),
            ]),
            SizedBox(
              height: 45,
            ),
            Row(children: [
              defaultDashBoard(
                  color: color,
                  text: 'AB+',
                  futureBuilder: FutureBuilder(
                      future: countABplus(),
                      builder: (context, snapshot){
                        return defaultCountDash(label: '$countAB1');
                      },
                  ),
              ),
              SizedBox(
                width: 20.0,
              ),
              defaultDashBoard(
                  color: color,
                  text: 'AB-',
                  futureBuilder: FutureBuilder(
                      future: countABminus(),
                      builder: (context, snapshot){
                        return defaultCountDash(label:'$countAB2');
                      }
                  ),
              ),
            ]),
            SizedBox(
              height: 45,
            ),
            Row(children: [
              defaultDashBoard(
                  color: color2,
                  text: 'O+',
                  futureBuilder: FutureBuilder(
                      future: countOplus(),
                      builder: (context, snapshot){
                        return defaultCountDash(label: '$countO1');
                      }
                  ),
              ),
              SizedBox(
                width: 20.0,
              ),
              defaultDashBoard(
                  color: color2,
                  text: 'O-',
                  futureBuilder: FutureBuilder(
                      future: countOminus(),
                      builder: (context, snapshot){
                        return defaultCountDash(label: '$countO2');
                      }
                  ),
              ),
            ])
          ]),
        ),
      ),
    ));
  }

  counta() async {
    QuerySnapshot myDoc = await FirebaseFirestore.instance
        .collection('users')
        .where('BloodType', isEqualTo: "A+")
        .get();
    List<DocumentSnapshot> myDocCount = myDoc.docs;
    countA = myDocCount.length;
    print(countA);
  }

  countaminus() async {
    QuerySnapshot myDoc = await FirebaseFirestore.instance
        .collection('users')
        .where('BloodType', isEqualTo: "A-")
        .get();
    List<DocumentSnapshot> myDocCount = myDoc.docs;
    countA1 = myDocCount.length;
    print(countA1);
  }

  countBplus() async {
    QuerySnapshot myDoc = await FirebaseFirestore.instance
        .collection('users')
        .where('BloodType', isEqualTo: "B+")
        .get();
    List<DocumentSnapshot> myDocCount = myDoc.docs;
    countB1 = myDocCount.length;
    print(countB1);
  }

  countBMINUS() async {
    QuerySnapshot myDoc = await FirebaseFirestore.instance
        .collection('users')
        .where('BloodType', isEqualTo: "B-")
        .get();
    List<DocumentSnapshot> myDocCount = myDoc.docs;
    countB2 = myDocCount.length;
    print(countB2);
  }

  countABplus() async {
    QuerySnapshot myDoc = await FirebaseFirestore.instance
        .collection('users')
        .where('BloodType', isEqualTo: "AB+")
        .get();
    List<DocumentSnapshot> myDocCount = myDoc.docs;
    countAB1 = myDocCount.length;
    print(countAB1);
  }

  countABminus() async {
    QuerySnapshot myDoc = await FirebaseFirestore.instance
        .collection('users')
        .where('BloodType', isEqualTo: "AB-")
        .get();
    List<DocumentSnapshot> myDocCount = myDoc.docs;
    countAB2 = myDocCount.length;
    print(countAB2);
  }

  countOplus() async {
    QuerySnapshot myDoc = await FirebaseFirestore.instance
        .collection('users')
        .where('BloodType', isEqualTo: "O+")
        .get();
    List<DocumentSnapshot> myDocCount = myDoc.docs;
    countO1 = myDocCount.length;
    print(countO1);
  }

  countOminus() async {
    QuerySnapshot myDoc = await FirebaseFirestore.instance
        .collection('users')
        .where('BloodType', isEqualTo: "O-")
        .get();
    List<DocumentSnapshot> myDocCount = myDoc.docs;
    countO2 = myDocCount.length;
    print(countO2);
  }
}
