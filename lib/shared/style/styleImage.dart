import 'package:Conneect_Firebase/shared/cubit/cubit.dart';
import 'package:flutter/material.dart';

class StyleImage extends StatefulWidget {
  @override
  StyleImageState createState() => StyleImageState();
}
class StyleImageState extends State<StyleImage> {
  @override
  Widget build(BuildContext context) {
  }
  Widget bottomSheetImage(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext c) {
          return Container(
                  height: 100.0,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Choose Profile Photo",
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ElevatedButton.icon(
                            style: TextButton.styleFrom(
                              backgroundColor: Color(0xffe60000),
                              fixedSize: Size(110.0, 30.0),
                            ),
                            icon: Icon(Icons.camera),
                            onPressed: () {
                              CubitApp.get(context).photo(context);
                              //Navigator.of(context).pop();
                            },
                            label: Text("Camera"),
                          ),
                          SizedBox(width: 20.0,),
                          ElevatedButton.icon(
                            style: TextButton.styleFrom(
                              backgroundColor: Color(0xffe60000),
                              fixedSize: Size(110.0, 30.0),
                            ),
                            icon: Icon(Icons.image),
                            onPressed: () {
                              CubitApp.get(context).insertImage(context);
                            },
                            label: Text("Gallery"),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
      elevation: 25.0,
            );
  }
}
