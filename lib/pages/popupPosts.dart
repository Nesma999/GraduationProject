import 'package:flutter/material.dart';
import 'login.dart';


class AdvanceCustomAlertPosts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0)),
            child: Stack(
              overflow: Overflow.visible,
              alignment: Alignment.topCenter,
              children: [
                Container(
                  height: 230,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
                    child: Column(
                      children: [
                        Text(
                          'Warning !!!',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Wait admin approve or reject your post',
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        RaisedButton(
                          padding: EdgeInsets.symmetric(vertical:10,horizontal:30),
                           shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          color: Colors.redAccent,
                          child: Text(
                            'Okay',
                            style: TextStyle(color: Colors.white,fontSize: 25),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                    top: -60,
                    child: CircleAvatar(
                      backgroundColor: Colors.redAccent,
                      radius: 60,
                      child: Icon(
                        Icons.assistant_photo,
                        color: Colors.white,
                        size: 50,
                      ),
                    )),
              ],
            )));
  }
}
