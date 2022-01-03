import 'package:Conneect_Firebase/modules/chat/message_bubbles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class message extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        //دا علشان يظهر الداتا ع الشاشه
        stream: FirebaseFirestore.instance.collection('chat').orderBy('Time', descending: true).snapshots(),
        //ال stream  دا بيربط ما بين الstream و ال  snapshot
        // الييانات اللى عندى هى ال firebasefirestoer
        builder: (ctx, snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          final docs = snapShot.data
              .docs; //دا علشان يحطلى كل الداتا للى ف ال dos  يحطه ف ال var  اللى اسمه docs
          final user = FirebaseAuth.instance.currentUser;
          return ListView.builder(
              //ال snapshot  بتيجيب البيانات بعد ما ال stream  ينتهى
              reverse: true,
              itemCount: docs.length,
              itemBuilder: (ctx, index) => messageBubble(
                  docs[index]['Text'],
                  docs[index]['name'],
                  docs[index]['imageurl'],
                  docs[index]['userId'] == user.uid,

                  key: ValueKey(docs[index].documentID),));

        }
        );
  }



}
