import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'profile.dart';

class EditLoc extends StatefulWidget {
  _EditLocState createState() => _EditLocState();
}

class _EditLocState extends State<EditLoc> {
  var backG = Color.fromRGBO(229, 33, 33, 1);
  final GlobalKey<FormState> _formKey = GlobalKey();
  var adminArea = "AdminArea";
  var countries = " Country ";
  var addressLine = " Addressline ";
  var subAdminArea = " SubadminArea ";
  var lat, long, country, adminarea, addressline, subadmin;

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
      adminArea = "$adminarea";
      countries = "$country";
      addressLine = "$addressline";
      subAdminArea = "$subadmin";
    });
  }

  Widget build(BuildContext cx) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: backG,
        title: Text(
          "Set Location",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Column(
              children: [
                Card(
                  margin: EdgeInsets.all(20),
                  color: Colors.white,
                  elevation: 20,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                            child: Text(
                              "Current Location",
                              style: TextStyle(
                                color: backG,
                                fontFamily: 'Arial',
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                            child: TextFormField(
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black12,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black12,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black12,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                filled: true,
                                fillColor: Colors.grey[200],
                                hintMaxLines: 5,
                                hintText: adminArea,
                                hintStyle: TextStyle(
                                  color: backG,
                                  fontFamily: 'Arial',
                                ),
                              ),
                                showCursor: false,
                                readOnly: true,
                            ),
                          ),
                          //SizedBox(height: 50,),
                          Container(
                            padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                            child: TextFormField(
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black12,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black12,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black12,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                filled: true,
                                fillColor: Colors.grey[200],
                                hintMaxLines: 5,
                                hintText: countries,
                                hintStyle: TextStyle(
                                  color: backG,
                                  fontFamily: 'Arial',
                                ),
                              ),
                              showCursor: false,
                              readOnly: true,
                            ),
                          ),
                          //SizedBox(height: 50,),
                          Container(
                            padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                            child: TextFormField(
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black12,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black12,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black12,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                filled: true,
                                fillColor: Colors.grey[200],
                                hintMaxLines: 5,
                                hintText: addressLine,
                                hintStyle: TextStyle(
                                  color: backG,
                                  fontFamily: 'Arial',
                                ),
                              ),
                              showCursor: false,
                              readOnly: true,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                            child: TextFormField(
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black12,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black12,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black12,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                filled: true,
                                fillColor: Colors.grey[200],
                                hintMaxLines: 5,
                                hintText: subAdminArea,
                                hintStyle: TextStyle(
                                  color: backG,
                                  fontFamily: 'Arial',
                                ),
                              ),
                              showCursor: false,
                              readOnly: true,
                            ),
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 30, 10, 0),
                  child: InkWell(
                    child: Icon(
                      Icons.location_on,
                      color: backG,
                      size: 90,
                    ),
                    onTap: () {
                      _getLocation();
                    },
                  ),
                ),
                text(),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 70, 0, 0),
                  child: ElevatedButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      elevation: 0.0,
                    ),
                    onPressed: () {
                      update();
                    },
                    child: Text(
                      'OK',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          //color: Color.fromRGBO(130, 130, 130, 1)
                        color: backG,
                        ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget text() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
      child: Text(
        "Press here",
        style: TextStyle(fontSize: 20, color: backG),
      ),
    );
  }
  void update() {
    final user = FirebaseAuth.instance.currentUser;
    DocumentReference ref =
        FirebaseFirestore.instance.collection('users').doc(user.uid);
    ref.update({
      'long': long,
      'lat': lat,
      'adminarea': adminarea,
      'addressline': addressline,
      'subadminarea': subadmin,
      'country': country,
    });
    Navigator.push(context, MaterialPageRoute(builder: (context) => Imagee()));
  }
}
