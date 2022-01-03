import 'package:Conneect_Firebase/Components/components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import '../drawer/drawer.dart';

class Search extends StatefulWidget {
  @override
  SearchState createState() => SearchState();
}

class SearchState extends State<Search> {
  String title = "";
  Color g = Color.fromRGBO(105, 100, 100, 1);
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
        iconTheme: IconThemeData(color: Colors.black, size: 30),
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
                      defaultPageSearch(
                        text: 'A+',
                        backgroundColor: isColor ? Colors.red : w,
                        textColor: isColor ? Colors.white : g,
                        onPressed: () {
                          setState(() {
                            search1 = "A+";
                            isColor = !isColor;
                          });
                        },
                      ),
                      defaultPageSearch(
                        backgroundColor: isColorA ? Colors.red : w,
                        textColor: isColorA ? Colors.white : g,
                        text: 'A-',
                        onPressed: () {
                          setState(() {
                            search1 = "A-";
                            isColorA = !isColorA;
                          });
                        },
                      ),
                      defaultPageSearch(
                        backgroundColor: isColorB ? Colors.red : w,
                        textColor: isColorB ? Colors.white : g,
                        text: 'B+',
                        onPressed: () {
                          setState(() {
                            search1 = "B+";
                            isColorB = !isColorB;
                          });
                        },
                      ),
                      defaultPageSearch(
                        backgroundColor: isColorTextB ? Colors.red : w,
                        textColor: isColorTextB ? Colors.white : g,
                        text: 'B-',
                        onPressed: () {
                          setState(() {
                            search1 = "B-";
                            isColorTextB = !isColorTextB;
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      defaultPageSearch(
                        backgroundColor: isColorO ? Colors.red : w,
                        textColor: isColorO ? Colors.white : g,
                        text: 'O+',
                        onPressed: () {
                          setState(() {
                            search1 = "O+";
                            isColorO = !isColorO;
                          });
                        },
                      ),
                      defaultPageSearch(
                        backgroundColor: isColorText ? Colors.red : w,
                        textColor: isColorText ? Colors.white : g,
                        text: 'O-',
                        onPressed: () {
                          setState(() {
                            search1 = "O-";
                            isColorText = !isColorText;
                          });
                        },
                      ),
                      defaultPageSearch(
                        backgroundColor: isColorAB ? Colors.red : w,
                        textColor: isColorAB ? Colors.white : g,
                        text: 'AB+',
                        onPressed: () {
                          setState(() {
                            search1 = "AB+";
                            isColorAB = !isColorAB;
                          });
                        },
                      ),
                      defaultPageSearch(
                        backgroundColor: isColorTextAB ? Colors.red : w,
                        textColor: isColorTextAB ? Colors.white : g,
                        text: 'AB-',
                        onPressed: () {
                          setState(() {
                            search1 = "AB-";
                            isColorTextAB = !isColorTextAB;
                          });
                        },
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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: defaultTextField(
                  colorFocused: Colors.red,
                  radius: 30,
                  maxLines: 5,
                  text: location,
                  keyboard: TextInputType.number,
                  suffix: Icons.location_on,
                  size: 30,
                  showCursor: false,
                  readOnly: true,
                  color: Colors.black54,
                  icon: () {
                    getLocation();
                  },
                  onTap: () {
                    getLocation();
                  },
                  validate: (value) {
                    if (location.isEmpty) {
                      return "Please Enter Your Location";
                    }
                  },
                  onChange:(value) {
                    setState(() {
                      location = value;
                    });
                  },
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            defaultLikesButton(
              sideColor: Color(0xffe60000),
              iconSize: 35,
              textColor: Colors.white,
              backgroundColor: Color(0xffe60000),
              radius: 50,
              width: 170.0,
              height: 45.0,
              fontSize: 30,
              iconColor: Colors.white,
              icon: Icons.search,
              text: 'Search',
              function: () {
                if (formKey.currentState.validate()) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => search(search1, location)));
                }
              },
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
          iconTheme: IconThemeData(color: Colors.black, size: 30),
          elevation: 0.0,
        ),
        drawer: Drawer(
          child: DrawerScreen(),
        ),
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .where('BloodType', isEqualTo: bloodtype)
                    .where('adminarea', isEqualTo: location)
                    .snapshots(),
                builder: (context, snapshot) {
                  return (snapshot.connectionState == ConnectionState.waiting)
                      ? CircularProgressIndicator()
                      : Column(children: [
                          if (snapshot.data.docs.length == 0)
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 50, left: 16.0),
                              child: Text(
                                'No Donor is found with blood type $bloodtype in your location',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromRGBO(183, 129, 129, 1)),
                              ),
                            ),
                          if (snapshot.data.docs.length > 0)
                            Text(
                              'Find ${snapshot.data.docs.length} donors with $bloodtype blood in your location',
                              style: TextStyle(
                                color: Color.fromRGBO(183, 129, 129, 1),
                              ),
                            ),
                          SizedBox(
                            height: 10.0,
                          ),
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
                                              image: NetworkImage(
                                                  data['imageurl']),
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
                                          style: TextStyle(
                                              fontSize: 18, color: titlee),
                                        ),
                                        onTap: () {
                                          FirebaseAuth.instance.currentUser;
                                          FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(data["userid"])
                                              .get()
                                              .then((snapshot) {
                                            if (snapshot
                                                    .data()['donor validity'] ==
                                                'yes') {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          finalsearchGreen(
                                                              data["userid"])));
                                            } else if (snapshot
                                                    .data()['donor validity'] ==
                                                'no') {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          finalsearchRed(
                                                              data["userid"])));
                                            } else {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          finalsearch(
                                                              data["userid"])));
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                  ]));
                            },
                          ),
                        ]);
                }),
          ]),
        ));
  }
}

Widget finalsearch(finall) {
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
                      defaultSearch(
                          img: data['imageurl'],
                          name: data['name'],
                          padding: Padding(padding: EdgeInsets.all(0.0))),
                      SizedBox(
                        height: 20.0,
                      ),
                      defaultResultSearch(
                          icon: Icons.phone,
                          title: 'Phone',
                          trailing: data["phone"]),
                      Divider(
                        color: Colors.grey,
                      ),
                      defaultResultSearch(
                          icon: Icons.location_on,
                          title: 'Location',
                          trailing: data["adminarea"]),
                      Divider(
                        color: Colors.grey,
                      ),
                      defaultResultSearch(
                          icon: Icons.perm_contact_calendar,
                          title: 'Age',
                          trailing: data["age"]),
                      Divider(
                        color: Colors.grey,
                      ),
                      defaultResultSearch(
                          icon: Icons.local_fire_department_rounded,
                          title: 'Blood Type',
                          trailing: data["BloodType"]),
                      Divider(
                        color: Colors.grey,
                      ),
                      defaultResultSearch(
                          icon: Icons.event_note,
                          title: 'Blood Donation Validity',
                          trailing: data["donor validity"]),
                    ],
                  );
                },
              );
      },
    ),
  );
}

Widget finalsearchRed(finall) {
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
                      defaultSearch(
                          img: data['imageurl'],
                          name: data["name"],
                          padding: defaultCircle(color: Colors.red)),
                      SizedBox(
                        height: 20.0,
                      ),
                      defaultResultSearch(
                          icon: Icons.phone,
                          title: 'Phone',
                          trailing: data["phone"]),
                      Divider(
                        color: Colors.grey,
                      ),
                      defaultResultSearch(
                          icon: Icons.location_on,
                          title: 'Location',
                          trailing: data["adminarea"]),
                      Divider(
                        color: Colors.grey,
                      ),
                      defaultResultSearch(
                          icon: Icons.perm_contact_calendar,
                          title: 'Age',
                          trailing: data["age"]),
                      Divider(
                        color: Colors.grey,
                      ),
                      defaultResultSearch(
                          icon: Icons.local_fire_department_rounded,
                          title: 'Blood Type',
                          trailing: data["BloodType"]),
                      Divider(
                        color: Colors.grey,
                      ),
                      defaultResultSearch(
                          icon: Icons.event_note,
                          title: 'Blood Donation Validity',
                          trailing: data["donor validity"]),
                    ],
                  );
                },
              );
      },
    ),
  );
}

Widget finalsearchGreen(finall) {
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
                      defaultSearch(
                        img: data['imageurl'],
                        name: data["name"],
                        padding: defaultCircle(color: Colors.green),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      defaultResultSearch(
                          icon: Icons.phone,
                          title: 'Phone',
                          trailing: data["phone"]),
                      Divider(
                        color: Colors.grey,
                      ),
                      defaultResultSearch(
                          icon: Icons.location_on,
                          title: 'Location',
                          trailing: data["adminarea"]),
                      Divider(
                        color: Colors.grey,
                      ),
                      defaultResultSearch(
                          icon: Icons.perm_contact_calendar,
                          title: 'Age',
                          trailing: data["age"]),
                      Divider(
                        color: Colors.grey,
                      ),
                      defaultResultSearch(
                          icon: Icons.local_fire_department_rounded,
                          title: 'Blood Type',
                          trailing: data["BloodType"]),
                      Divider(
                        color: Colors.grey,
                      ),
                      defaultResultSearch(
                          icon: Icons.event_note,
                          title: 'Blood Donation Validity',
                          trailing: data["donor validity"]),
                    ],
                  );
                },
              );
      },
    ),
  );
}
