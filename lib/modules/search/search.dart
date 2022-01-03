import 'package:Conneect_Firebase/Components/components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';

import 'drawer.dart';

class Search extends StatefulWidget {
  @override
  SearchState createState() => SearchState();
}

class SearchState extends State<Search> {
  String title = "";
  Color g = Color.fromRGBO(105, 100, 100, 1);
  var backG = Color.fromRGBO(229, 33, 33, 1);
  var bar = Color.fromRGBO(255, 255, 255, 1);
  var userName = Color.fromRGBO(167, 120, 120, 1);
  var titlee = Color.fromRGBO(187, 166, 166, 1);
  bool isColor = false;
  bool isColorText = false;
  bool isColorA = false;
  bool isColorO = false;
  bool isColorB = false;
  bool isColorTextB = false;
  bool isColorAB = false;
  bool isColorTextAB = false;
  Color w = Colors.white;
  Color b = Colors.black;
  String search1, search2;
  var lat, long, adminarea;
  String location = "Location";
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black,size: 30),
        elevation: 0.0,
      ),
      drawer: Drawer(
        child: DrawerScreen(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(0, 20, 190, 0),
              child: Text(
                "Find Donor",
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Color.fromRGBO(230, 23, 23, 1),
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Text(
                "By Blood Type and Location  ",
                style: TextStyle(
                  color: Color.fromRGBO(163, 109, 109, 1),
                  fontSize: 22,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 40, 165, 0),
              child: Text(
                "Choose Blood Type  ",
                style: TextStyle(
                  color: Color.fromRGBO(150, 137, 137, 1),
                  fontSize: 20.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.all(8.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: ElevatedButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            backgroundColor: isColor ? Colors.red : w,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 1, color: Colors.black12)),
                          ),
                          onPressed: () {
                            setState(() {
                              search1 = "A+";
                              isColor = !isColor;
                            });
                          },
                          child: Container(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: Text("A+",
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w400,
                                    color: isColor ? Colors.white : g,
                                  ))),
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            backgroundColor: isColorA ? Colors.red : w,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 1, color: Colors.black12)),
                          ),
                          onPressed: () {
                            setState(() {
                              search1 = "A-";
                              isColorA = !isColorA;
                            });
                          },
                          child: Container(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: Text("A-",
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w400,
                                    color: isColorA ? Colors.white : g,
                                  ))),
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            backgroundColor: isColorB ? Colors.red : w,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 1, color: Colors.black12)),
                          ),
                          onPressed: () {
                            setState(() {
                              search1 = "B+";
                              isColorB = !isColorB;
                            });
                          },
                          child: Container(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: Text("B+",
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w400,
                                    color: isColorB ? Colors.white : g,
                                  ))),
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            backgroundColor: isColorTextB ? Colors.red : w,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 1, color: Colors.black12)),
                          ),
                          onPressed: () {
                            setState(() {
                              search1 = "B-";
                              isColorTextB = !isColorTextB;
                            });
                          },
                          child: Container(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: Text("B-",
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w400,
                                    color: isColorTextB ? Colors.white : g,
                                  ))),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: ElevatedButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            backgroundColor: isColorO ? Colors.red : w,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 1, color: Colors.black12)),
                          ),
                          onPressed: () {
                            setState(() {
                              search1 = "O+";
                              isColorO = !isColorO;
                            });
                          },
                          child: Container(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: Text("O+",
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w400,
                                    color: isColorO ? Colors.white : g,
                                  ))),
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            backgroundColor: isColorText ? Colors.red : w,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 1, color: Colors.black12)),
                          ),
                          onPressed: () {
                            setState(() {
                              search1 = "O-";
                              isColorText = !isColorText;
                            });
                          },
                          child: Container(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: Text("O-",
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w400,
                                    color: isColorText ? Colors.white : g,
                                  ))),
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            backgroundColor: isColorAB ? Colors.red : w,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 1, color: Colors.black12)),
                          ),
                          onPressed: () {
                            setState(() {
                              search1 = "AB+";
                              isColorAB = !isColorAB;
                            });
                          },
                          child: Container(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: Text("AB+",
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w400,
                                    color: isColorAB ? Colors.white : g,
                                  ))),
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            backgroundColor: isColorTextAB ? Colors.red : w,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 1, color: Colors.black12)),
                          ),
                          onPressed: () {
                            setState(() {
                              search1 = "AB-";
                              isColorTextAB = !isColorTextAB;
                            });
                          },
                          child: Container(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: Text("AB-",
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w400,
                                    color: isColorTextAB ? Colors.white : g,
                                  ))),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Form(
                key: formKey,
                child: Container(
                  width: 350,
                  height: 60,
                  child: TextFormField(
                    showCursor: false,
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: location,
                      hintStyle: TextStyle(
                        color: Colors.black26,
                        fontWeight: FontWeight.w600,
                        fontSize: 25,
                      ),
                      prefixIcon: IconButton(
                          icon: Icon(
                            Icons.location_on,
                            color: Colors.black54,
                            size: 35,
                          ),
                          onPressed: () {
                            getLocation();
                          }), //TextStyle
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black12,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black12,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black12,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    keyboardType: TextInputType.text,
                    onTap: () {
                      getLocation();
                    },
                    validator: (value) {
                      if (location.isEmpty) {
                        return "Please Enter Your Location";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        location = value;
                      });
                    },
                  ),
                )),
            SizedBox(
              height: 50,
            ),
            ElevatedButton.icon(
              style: TextButton.styleFrom(
                backgroundColor: Color(0xffe60000),
                fixedSize: Size(170.0, 45.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              onPressed: () {
                if (formKey.currentState.validate()) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => search(search1, location)));
                }
              },
              icon: Icon(
                Icons.search,
                color: w,
                size: 35,
              ),
              label: Text(
                "Search",
                style: TextStyle(fontSize: 30, color: w),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getLocation() async {
    var lat, long;
    var position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    lat = position.latitude;
    long = position.longitude;
    final coordinates = new Coordinates(lat, long);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);

    adminarea = addresses.first.adminArea;
    setState(() {
      location = "$adminarea";
    });
  }

  Widget search(String bloodtype, location) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black,size: 30),
          elevation: 0.0,
        ),
        drawer: Drawer(
          child: DrawerScreen(),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Donor List',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Color.fromRGBO(249, 24, 24, 1),
                ),
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('users').where('BloodType', isEqualTo: bloodtype).where('adminarea', isEqualTo: location).snapshots(),
              builder: (context, snapshot) {
                return (snapshot.connectionState == ConnectionState.waiting)
                    ? CircularProgressIndicator()
                 :Column(
                   children:[

                     if(snapshot.data.docs.length == 0) Padding(
                       padding: const EdgeInsets.only(top: 50,left: 16.0),
                       child: Text(
                           'No Donor is found with blood type $bloodtype in your location',
                         style: TextStyle(
                           fontSize: 20,
                           color: Color.fromRGBO(183, 129, 129, 1)
                         ),
                       ),
                     ),
                     if(snapshot.data.docs.length >0) Text(
                       'Find ${snapshot.data.docs.length} donors with $bloodtype blood in your location',
                       style: TextStyle(
                         color: Color.fromRGBO(183, 129, 129, 1),
                       ),
                     ),
                     SizedBox(height: 10.0,),
                     ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot data = snapshot.data.docs[index];
                      return Card(
                          margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              color: Colors.grey[300],
                            ),
                          ),
                          child: Column(children: [
                            Container(
                              child: ListTile(
                                leading: Container(
                                  height: 50.0,
                                  width: 50.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(data['imageurl']),
                                    ),
                                  ),
                                ),
                                title: Text(
                                  data["name"],
                                  style: TextStyle(
                                      fontSize: 20, color: userName),
                                ),
                                subtitle: Text(
                                  data["adminarea"],
                                  style:
                                  TextStyle(fontSize: 18, color: titlee),
                                ),
                                onTap: () async {
                                  await FirebaseAuth.instance.currentUser;
                                  FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(data["userid"])
                                      .get()
                                      .then((snapshot) {
                                    if (snapshot.data()['donor validity'] == 'yes') {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                                  finalsearchGreen(data["userid"])));
                                    } else if (snapshot.data()['donor validity'] == 'no') {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                                  finalsearchRed(data["userid"])));
                                    } else {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                          finalsearch(data["userid"])));
                                    }
                                  });
                                },
                              ),
                            ),
                          ]));
                    },
                ),
                 ]);
              }
            ),
          ]),
        ));
  }
}

Widget finalsearch(finall) {
  var backG = Color.fromRGBO(229, 33, 33, 1);
  var userName = Color.fromRGBO(191, 49, 49, 1);
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Color(0xffe60000),
      elevation: 0.0,
    ),
    drawer: Drawer(
      child: DrawerScreen(),
    ),
    body: StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .where('userid', isEqualTo: finall)
          .snapshots(),
      builder: (context, snapshot) {
        return (snapshot.connectionState == ConnectionState.waiting)
            ? CircularProgressIndicator()
            : ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot data = snapshot.data.docs[index];
                  return Column(
                    children: <Widget>[
                      Stack(
                        alignment: Alignment.topCenter,
                        children: <Widget>[
                          Container(
                            height: 150.0,
                            color: backG,
                            width: double.infinity,
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.only(top:80.0),
                          child:Container(
                            height: 140.0,
                            width: 140.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(data['imageurl'])
                                ),
                                border: Border.all(
                                    color: Color.fromRGBO(213, 209, 209, 1), width: 6.0)),
                          ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.only(top: 230.0,start: 10.0),
                            child: Text(
                              data["name"],
                              style: TextStyle(
                                  fontSize: 27, color: userName),
                            ),
                          ),
                          chat(),
                        ],
                      ),
                      SizedBox(height: 20.0,),
                      defaultResultSearch(icon: Icons.phone, title: 'Phone', trailing: data["phone"]),
                      Divider(
                        color: Colors.grey,
                      ),
                      defaultResultSearch(icon: Icons.location_on, title: 'Location', trailing: data["adminarea"]),
                      Divider(
                        color: Colors.grey,
                      ),
                      defaultResultSearch(icon: Icons.perm_contact_calendar, title: 'Age', trailing: data["age"]),
                      Divider(
                        color: Colors.grey,
                      ),
                      defaultResultSearch(icon: Icons.local_fire_department_rounded, title: 'Blood Type', trailing: data["BloodType"]),
                      Divider(
                        color: Colors.grey,
                      ),
                      defaultResultSearch(icon: Icons.event_note, title: 'Blood Donation Validity', trailing: data["donor validity"]),
                    ],
                  );
                },
              );
      },
    ),
  );
}

Widget finalsearchRed(finall) {
  var backG = Color.fromRGBO(229, 33, 33, 1);
  var userName = Color.fromRGBO(191, 49, 49, 1);
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Color(0xffe60000),
      elevation: 0.0,
    ),
    drawer: Drawer(
      child: DrawerScreen(),
    ),
    body: StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .where('userid', isEqualTo: finall)
          .snapshots(),
      builder: (context, snapshot) {
        return (snapshot.connectionState == ConnectionState.waiting)
            ? CircularProgressIndicator()
            : ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot data = snapshot.data.docs[index];
                  return Column(
                    children: <Widget>[
                      Stack(
                        alignment: Alignment.topCenter,
                        children: <Widget>[
                          Container(
                            height: 150.0,
                            color: backG,
                            width: double.infinity,
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.only(top:80.0),
                            child:Container(
                              height: 140.0,
                              width: 140.0,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(data['imageurl'])
                                  ),
                                  border: Border.all(
                                      color: Color.fromRGBO(213, 209, 209, 1), width: 6.0)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.only(top: 230.0,start: 10.0),
                            child: Text(
                              data["name"],
                              style: TextStyle(
                                  fontSize: 27, color: userName),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.only(
                                top: 180, end: 120),
                            child: Icon(
                              Icons.circle,
                              color: Colors.red,
                              size: 15,
                            ),
                          ),
                          chat(),
                        ],
                      ),
                      SizedBox(height: 20.0,),
                      defaultResultSearch(icon: Icons.phone, title: 'Phone', trailing: data["phone"]),
                      Divider(
                        color: Colors.grey,
                      ),
                      defaultResultSearch(icon: Icons.location_on, title: 'Location', trailing: data["adminarea"]),
                      Divider(
                        color: Colors.grey,
                      ),
                      defaultResultSearch(icon: Icons.perm_contact_calendar, title: 'Age', trailing: data["age"]),
                      Divider(
                        color: Colors.grey,
                      ),
                      defaultResultSearch(icon: Icons.local_fire_department_rounded, title: 'Blood Type', trailing: data["BloodType"]),
                      Divider(
                        color: Colors.grey,
                      ),
                      defaultResultSearch(icon: Icons.event_note, title: 'Blood Donation Validity', trailing: data["donor validity"]),
                    ],
                  );
                },
              );
      },
    ),
  );
}

chat() {
  return Padding(
    padding: const EdgeInsetsDirectional.only(top: 130.0,end:270.0),
    child: Container(
      width: 40,
      height: 40,
      child: IconButton(
          icon: Icon(
            Icons.chat_rounded,
            color: Colors.white,
            size: 25,
          ),
          onPressed: () {}),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        color: Color.fromRGBO(229, 33, 33, 1),
        boxShadow: [
          BoxShadow(
            blurRadius: 3.0,
            color: Colors.grey,
            offset: Offset(0, 0),
          ),
        ],
      ),
    ),
  );
}

Widget finalsearchGreen(finall) {
  var backG = Color.fromRGBO(229, 33, 33, 1);
  var userName = Color.fromRGBO(191, 49, 49, 1);
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Color(0xffe60000),
      elevation: 0.0,
    ),
    drawer: Drawer(
      child: DrawerScreen(),
    ),
    body: StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .where('userid', isEqualTo: finall)
          .snapshots(),
      builder: (context, snapshot) {
        return (snapshot.connectionState == ConnectionState.waiting)
            ? CircularProgressIndicator()
            : ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot data = snapshot.data.docs[index];
                  return Column(
                    children: <Widget>[
                      Stack(
                        alignment: Alignment.topCenter,
                        children: <Widget>[
                          Container(
                            height: 150.0,
                            color: backG,
                            width: double.infinity,
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.only(top:80.0),
                            child:Container(
                              height: 140.0,
                              width: 140.0,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(data['imageurl'])
                                  ),
                                  border: Border.all(
                                      color: Color.fromRGBO(213, 209, 209, 1), width: 6.0)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.only(top: 230.0,start: 10.0),
                            child: Text(
                              data["name"],
                              style: TextStyle(
                                  fontSize: 27, color: userName),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.only(
                                top: 180, end: 120),
                            child: Icon(
                              Icons.circle,
                              color: Colors.green,
                              size: 15,
                            ),
                          ),
                          chat(),
                        ],
                      ),
                      SizedBox(height: 20.0,),
                      defaultResultSearch(icon: Icons.phone, title: 'Phone', trailing: data["phone"]),
                      Divider(
                        color: Colors.grey,
                      ),
                      defaultResultSearch(icon: Icons.location_on, title: 'Location', trailing: data["adminarea"]),
                      Divider(
                        color: Colors.grey,
                      ),
                      defaultResultSearch(icon: Icons.perm_contact_calendar, title: 'Age', trailing: data["age"]),
                      Divider(
                        color: Colors.grey,
                      ),
                      defaultResultSearch(icon: Icons.local_fire_department_rounded, title: 'Blood Type', trailing: data["BloodType"]),
                      Divider(
                        color: Colors.grey,
                      ),
                      defaultResultSearch(icon: Icons.event_note, title: 'Blood Donation Validity', trailing: data["donor validity"]),
                    ],
                  );
                },
              );
      },
    ),
  );
}


