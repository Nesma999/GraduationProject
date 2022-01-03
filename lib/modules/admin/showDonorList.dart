import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'dashBoard.dart';

class DonorList extends StatefulWidget {
  DonorListState createState() => DonorListState();
}

class DonorListState extends State<DonorList> {
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
          child: Column(children: [
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
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
                      style: TextStyle(
                          color: Color.fromRGBO(222, 144, 144, 1),
                          fontSize: 20),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: ElevatedButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Color.fromRGBO(227, 152, 152, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: Colors.grey[300],
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      "Donor List",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection("users").snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                return ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: snapshot.data.docs.map((e) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(
                          color: Colors.black26,
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                            child: ListTile(
                              leading: Container(
                                height: 60.0,
                                width: 60.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(e['imageurl']),
                                  ),
                                ),
                              ),
                              title: Text(
                                e["name"],
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(167, 117, 117, 1)),
                              ),
                              subtitle: Text(
                                e["adminarea"],
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Color.fromRGBO(167, 130, 130, 1)),
                              ),
                              trailing: ElevatedButton(
                                style: TextButton.styleFrom(
                                  fixedSize: Size(70.0, 30.0),
                                  backgroundColor:
                                      Color.fromRGBO(201, 124, 124, 1),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                                onPressed: () {},
                                child: Text(
                                  e["BloodType"],
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ]),
        ),
      ),
    ));
  }
}
