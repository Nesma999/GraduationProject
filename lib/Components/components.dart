import 'package:Conneect_Firebase/modules/test/editTest.dart';
import 'package:Conneect_Firebase/modules/usersProfile/editName.dart';
import 'package:Conneect_Firebase/modules/test/test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'constant.dart';

Widget defaultAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Color(0xffe60000),
    elevation: 0.0,
    actions: [
      Padding(
        padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
        child: FloatingActionButton(
            elevation: 0.0,
            mini: true,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.add,
              size: 22,
              color: Colors.red,
            ),
            onPressed: () {
              FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser.uid)
                  .get()
                  .then((snapshot) {
                if (snapshot.data()['flag'] == '0') {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Test()));
                } else {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TestEdit2()));
                }
              });
            }),
      ),
    ],
  );
}

Widget defaultTextField({
  @required String text,
  @required TextInputType keyboard,
  @required Function validate,
  Function onSave,
  Function onChange,
  bool isPass = false,
  IconData suffix,
  Function icon,
  Function onTap,
  Color color,
  double size,
  bool readOnly = false,
  bool showCursor = true,
  int maxLines,
  TextEditingController control,
  double radius = 10,
  Color colorFocused = Colors.blue,
}) {
  return TextFormField(
    controller: control,
    readOnly: readOnly,
    showCursor: showCursor,
    obscureText: isPass,
    onTap: onTap,
    decoration: InputDecoration(
      fillColor: Colors.grey[200],
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black12),
        borderRadius: BorderRadius.circular(radius),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: colorFocused,
        ),
        borderRadius: BorderRadius.circular(radius),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black12,
        ),
        borderRadius: BorderRadius.circular(radius),
      ),
      hintText: text,
      hintMaxLines: maxLines,
      hintStyle: TextStyle(
          //color: Color(0xff808080),
          ),
      suffixIcon: IconButton(
        icon: Icon(
          suffix,
          color: color,
          size: size,
        ),
        onPressed: icon,
      ),
    ),
    keyboardType: keyboard,
    validator: validate,
    onSaved: onSave,
    onChanged: onChange,
  );
}

Widget defaultButton({
  @required String text,
  @required Function tap,
  @required double size,
  @required double width,
  double height = 50.0,
  double fontSize: 25,
  @required Color backgroundColor,
  Color textColor = Colors.white,
  @required sideColor,
}) {
  return ElevatedButton(
    style: TextButton.styleFrom(
      fixedSize: Size(width, height),
      //Size(140.0, 50.0),
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(size),
        side: BorderSide(
          color: sideColor,
        ),
      ),
    ),
    onPressed: tap,
    child: Text(
      text,
      style: TextStyle(fontSize: fontSize, color: textColor),
    ),
  );
}

Widget defaultDrawer({
  @required String text,
  @required IconData icon,
  @required Function onTap,
}) {
  return Expanded(
    child: ListTile(
      leading: Icon(
        icon,
        color: Colors.white,
        size: 20,
      ),
      title: Text(
        text,
        style:
            TextStyle(fontFamily: 'Arial', color: Colors.white, fontSize: 20),
      ),
      onTap: onTap,
    ),
  );
}

Widget defaultBackground({
  @required Function image,
  Padding padding,
}) {
  return Stack(
    alignment: Alignment.topCenter,
    children: <Widget>[
      Container(
        height: 180.0,
        color: Color.fromRGBO(229, 33, 33, 1),
        width: double.infinity,
      ),
      userName(),
      userimageProfile(),
      Padding(
        padding: const EdgeInsetsDirectional.only(top: 200.0, start: 135.0),
        child: Container(
          width: 35,
          height: 35,
          child: IconButton(
            icon: Icon(
              Icons.camera_alt,
              color: Colors.white,
              size: 21,
            ),
            onPressed: image,
          ),
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
      ),
      padding,
    ],
  );
}

Widget defaultBackgroundNamw({
  @required Function image,
  Padding padding,
}) {
  return Stack(
    alignment: Alignment.topCenter,
    children: <Widget>[
      Container(
        height: 180.0,
        color: Color.fromRGBO(229, 33, 33, 1),
        width: double.infinity,
      ),
      userimageProfile(),
      Padding(
        padding: const EdgeInsetsDirectional.only(top: 200.0, start: 135.0),
        child: Container(
          width: 35,
          height: 35,
          child: IconButton(
            icon: Icon(
              Icons.camera_alt,
              color: Colors.white,
              size: 21,
            ),
            onPressed: image,
          ),
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
      ),
      padding,
    ],
  );
}

Widget userName() {
  return Padding(
    padding: const EdgeInsetsDirectional.only(top: 40.0, start: 40.0),
    child: FutureBuilder(
      future: db.getData(),
      builder: (context, snapshot) {
        return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Center(
            child: Text(
              "${db.name}",
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 1),
                fontFamily: 'Arial',
                fontSize: 30,
              ),
            ),
          ),
          IconButton(
              icon: Icon(
                Icons.edit,
                color: Color.fromRGBO(255, 255, 255, 1),
                size: 22.0,
              ),
              onPressed: () {
                final user = FirebaseAuth.instance.currentUser;
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
                              builder: (context) =>
                                  EditNameeState().editNameGreen()));
                    } else if (snapshot.data()['donor validity'] == 'no') {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  EditNameeState().editNameRed()));
                    } else {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => EditNamee()));
                    }
                  },
                );
              }),
        ]);
      },
    ),
  );
}

Widget userimageProfile() {
  return Padding(
    padding: const EdgeInsetsDirectional.only(top: 110.0),
    child: FutureBuilder(
        future: db.getData(),
        builder: (context, snapshot) {
          return Container(
            height: 150.0,
            width: 150.0,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: (db.img != null)
                      ? NetworkImage(db.img)
                      : NetworkImage(
                          'https://i.pinimg.com/564x/04/28/f5/0428f5706e19f681febc5aa677d7e282.jpg'),
                ),
                border: Border.all(
                    color: Color.fromRGBO(213, 209, 209, 1), width: 6.0)),
          );
        }),
  );
}

Widget defaultUserInfo({
  @required IconData icon,
  @required String text,
  IconData iconEdit,
  Function edit,
  FutureBuilder futureBuilder,
  @required double width,
}) {
  return Column(
    children: [
      Row(
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 10.0),
            child: Container(
              width: 30,
              height: 30,
              child: Icon(
                icon,
                color: Colors.white,
                size: 20,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                color: Colors.red,
              ),
            ),
          ),
          SizedBox(
            width: 7.0,
          ),
          Text(
            text,
            style: TextStyle(
              color: Color.fromRGBO(235, 125, 125, 1),
              fontFamily: 'Arial',
              fontSize: 16,
            ),
          ),
          SizedBox(
            width: width,
          ),
          futureBuilder,
          IconButton(
            icon: Icon(iconEdit, color: Colors.black),
            onPressed: edit,
          ),
        ],
      ),
    ],
  );
}

Widget defaultUserGet({
  @required var data,
}) {
  return Expanded(
      child: Row(children: [
    Expanded(
      child: Center(
        child: Text(
          "$data",
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Arial',
            color: Color.fromRGBO(191, 86, 86, 1),
          ),
        ),
      ),
    )
  ]));
}

Widget defaultEditTextField({
  @required Function update,
  @required IconData suffix,
  @required IconData icon,
  @required String text,
  @required String label,
  @required TextInputType keyboard,
  @required Function onChanged,
  TextEditingController control,
}) {
  return Row(children: [
    Padding(
      padding: const EdgeInsetsDirectional.only(start: 10.0),
      child: Container(
        width: 30,
        height: 30,
        child: Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
          color: Colors.red,
        ),
      ),
    ),
    SizedBox(
      width: 7.0,
    ),
    Text(
      text,
      style: TextStyle(
        color: Color.fromRGBO(235, 125, 125, 1),
        fontFamily: 'Arial',
        fontSize: 16,
      ),
    ),
    SizedBox(
      width: 10.0,
    ),
    Container(
      width: 250,
      child: TextFormField(
        controller: control,
        decoration: InputDecoration(
          contentPadding: EdgeInsetsDirectional.only(start: 10.0),
          hintText: label,
          hintStyle: TextStyle(
            color: Color.fromRGBO(154, 141, 141, 1),
            //fontSize: 18,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              suffix,
              color: Colors.red,
            ),
            onPressed: update,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black12),
            borderRadius: BorderRadius.circular(20),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black12,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black12,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        keyboardType: keyboard,
        onChanged: onChanged,
      ),
    ),
  ]);
}

Widget defaultChangePassword({
  @required TextEditingController control,
  @required IconData suffix,
  bool isPassword = false,
  @required Function function,
  @required Function validate,
  Function changed,
  @required String label,
}) {
  return TextFormField(
    controller: control,
    decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(25)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(25)),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        hintText: label,
        // filled: true,
        // fillColor: Colors.white,
        hintStyle: TextStyle(
          color: Color.fromRGBO(178, 157, 157, 1),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            suffix,
            color: Color(0xffe60000),
          ),
          onPressed: function,
        )),
    keyboardType: TextInputType.visiblePassword,
    obscureText: isPassword,
    validator: validate,
    onChanged: changed,
  );
}

defaultNameEditTextField({
  @required String label,
  @required IconData suffix,
  @required Function update,
  @required TextInputType keyboard,
  @required Function onChanged,
}) {
  return Container(
    width: 250,
    child: TextFormField(
      decoration: InputDecoration(
        fillColor: Color.fromRGBO(254, 215, 215, 1),
        filled: true,
        contentPadding: EdgeInsetsDirectional.only(start: 10.0),
        hintText: label,
        hintStyle: TextStyle(
          color: Color.fromRGBO(154, 141, 141, 1),
          //fontSize: 18,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            suffix,
            color: Colors.red,
          ),
          onPressed: update,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black12),
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black12,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black12,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      keyboardType: keyboard,
      onChanged: onChanged,
    ),
  );
}

Widget defaultLikesButton({
  @required var icon,
  @required String text,
  @required Function function,
  double width = 0.0,
  double height = 30.0,
  Color iconColor = Colors.black,
  double fontSize = 11,
  Color backgroundColor = Colors.white,
  double radius = 20,
  @required Color textColor,
  double iconSize = 15,
  Color sideColor = Colors.black26,
}) {
  return ElevatedButton.icon(
    style: TextButton.styleFrom(
      fixedSize: Size(width, height),
      //Size(0.0, 30.0),
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
        side: BorderSide(
          color: sideColor,
        ),
      ),
    ),
    onPressed: function,
    icon: Icon(
      icon,
      color: iconColor,
      size: iconSize,
    ),
    label: Text(
      text,
      style: TextStyle(
        color: textColor,
        //Color.fromRGBO(222, 24, 24, 1),
        fontSize: fontSize,
      ),
    ),
  );
}

Widget defaultDashBoard({
  @required Color color,
  @required String text,
  @required FutureBuilder futureBuilder,
}) {
  return Expanded(
    child: Container(
        height: 70,
        width: 190,
        color: color,
        child: Row(children: [
          Container(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontFamily: 'Arial',
                ),
              )),
          SizedBox(
            width: 75,
          ),
          futureBuilder,
        ])),
  );
}

Widget defaultCountDash({
  @required String label,
}) {
  return Expanded(
    child: Row(children: [
      Expanded(
        child: Text(
          "$label",
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Arial',
            color: Colors.white,
          ),
        ),
      ),
    ]),
  );
}

Widget defaultResultSearch({
  @required IconData icon,
  @required String title,
  @required String trailing,
}) {
  return ListTile(
    leading: Container(
      width: 30,
      height: 30,
      child: Icon(
        icon,
        color: Colors.white,
        size: 20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        color: Colors.red,
      ),
    ),
    title: Text(
      title,
      style: TextStyle(
          color: Color.fromRGBO(235, 125, 125, 1),
          fontFamily: 'Arial',
          fontSize: 16),
    ),
    trailing: Text(
      trailing,
      style: TextStyle(
        fontSize: 16,
        fontFamily: 'Arial',
        color: Color.fromRGBO(191, 86, 86, 1),
      ),
    ),
  );
}

Widget defaultPageSearch({
  @required Color backgroundColor,
  @required Color textColor,
  @required Function onPressed,
  @required String text,
}) {
  return Expanded(
    child: ElevatedButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
            side: BorderSide(width: 1, color: Colors.black12)),
      ),
      onPressed: onPressed,
      child: Container(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Text(text,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w400,
                color: textColor,
              ))),
    ),
  );
}

Widget defaultSearch({
  @required String img,
  @required String name,
  Padding padding,
}) {
  return Stack(
    alignment: Alignment.topCenter,
    children: <Widget>[
      Container(
        height: 150.0,
        color: Color.fromRGBO(229, 33, 33, 1),
        width: double.infinity,
      ),
      Padding(
        padding: const EdgeInsetsDirectional.only(top: 80.0),
        child: Container(
          height: 140.0,
          width: 140.0,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(img),
              ),
              border: Border.all(
                  color: Color.fromRGBO(213, 209, 209, 1), width: 6.0)),
        ),
      ),
      Padding(
        padding: const EdgeInsetsDirectional.only(top: 230.0, start: 10.0),
        child: Text(
          name,
          style: TextStyle(fontSize: 27, color: Color.fromRGBO(191, 49, 49, 1)),
        ),
      ),
      padding,
      Padding(
        padding: const EdgeInsetsDirectional.only(top: 130.0, end: 270.0),
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
      ),
    ],
  );
}

Widget defaultCircle({
  @required Color color,
}) {
  return Padding(
    padding: EdgeInsetsDirectional.only(top: 180, end: 120),
    child: Icon(
      Icons.circle,
      color: color,
      size: 15,
    ),
  );
}

Widget defaultPosts({
  @required String img,
  @required String name,
  @required String description,
  Padding padding,
}) {
  return Card(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
      color: Colors.white,
      //elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
        side: BorderSide(
          color: Colors.black26,
        ),
      ),
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: Container(
              height: 60.0,
              width: 60.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(img),
                ),
              ),
            ),
            title: Text(
              name,
              style: TextStyle(
                  fontSize: 20, color: Color.fromRGBO(200, 125, 125, 1)),
            ),
          ),
        ),
        Container(
            padding: EdgeInsets.fromLTRB(25, 0, 0, 15),
            child: Row(children: [
              Expanded(
                child: Text(
                  description,
                  style: TextStyle(
                      fontSize: 18, color: Color.fromRGBO(59, 45, 45, 1)),
                ),
              ),
            ])),
        padding,
      ]));
}

Widget defaultButtonAdmin({
  @required Function function,
  @required String text,
}) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Row(children: [
      Expanded(
        child: ElevatedButton(
          onPressed: function,
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          style: TextButton.styleFrom(
            backgroundColor: Color.fromRGBO(233, 101, 101, 1),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Colors.grey[300],
              ),
            ),
          ),
        ),
      ),
    ]),
  );
}

Widget defaultPostsAppBar(BuildContext context, String text) {
  return AppBar(
    title: Center(
      child: Text(text,
          style: TextStyle(
            fontFamily: 'Comic Sans MS',
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Color.fromRGBO(233, 101, 101, 1),
            fontStyle: FontStyle.italic,
          )),
    ),
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
  );
}

Widget defaultHomeAdmin({
  @required Function function,
  @required IconData icon,
  @required String text,
  @required FutureBuilder futureBuilder,
  @required Color color,
}) {
  return Expanded(
    child: ElevatedButton(
      onPressed: function,
      style: TextButton.styleFrom(
        backgroundColor: color,
      ),
      child: new Column(children: [
        SizedBox(
          height: 40,
        ),
        Icon(
          icon,
          size: 60,
          color: Colors.white,
        ),
        SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontFamily: 'Arial',
              ),
            ),
            futureBuilder,
          ],
        ),
        SizedBox(
          height: 10.0,
        ),
      ]),
    ),
  );
}
