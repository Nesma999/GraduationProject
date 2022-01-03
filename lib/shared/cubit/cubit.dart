import 'dart:io';
import 'package:Conneect_Firebase/modules/usersProfile/profile.dart';
import 'package:Conneect_Firebase/shared/cubit/states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class CubitApp extends Cubit<CubitStatesApp>{
  CubitApp() : super(InitialState());
  static CubitApp get(context)=>BlocProvider.of(context);
  ImageeState skey=ImageeState();
   String img;
  final ImagePicker _picker = ImagePicker();
  PickedFile _imageFile;

  photo(BuildContext context) async {
    final pickedFile = await _picker.getImage(
      source: ImageSource.camera,
    ).then((value){
      _imageFile=value;
      emit(GetDataState());
      emit(ChangedPhotoState());
    });
    //_imageFile = pickedFile;
    var file = File(_imageFile.path);

    final ref1 = FirebaseStorage.instance
        .ref()
        .child('user_image')
        .child(_imageFile.path);
    await ref1.putFile(file).then((p0) { emit(AppGetDatabaseLoadingState());});
    final url = await ref1.getDownloadURL();

    final user = await FirebaseAuth.instance.currentUser;
    DocumentReference ref =
    FirebaseFirestore.instance.collection('users').doc(user.uid);
    ref.update({'imageurl': url}).then((value){
      //Navigator.pop(context);
      print('Image Updated');
      final scaffold = ScaffoldMessenger.of(context);
      scaffold.showSnackBar(
        SnackBar(
          content: const Text('Your Picture Updated'),
        ),
      );
      emit(ChangedPhotoState());
    }).catchError((error){
      print('${error.toString()}');
    });;
  }

  insertImage(BuildContext context) async {
    final pickedFile = await _picker.getImage(
      source: ImageSource.gallery,
    ).then((value){
      _imageFile=value;
      emit(GetDataState());
      emit(ChangedPhotoState());

    });
    var file = File(_imageFile.path);
    final ref1 = FirebaseStorage.instance
        .ref()
        .child('user_image')
        .child(_imageFile.path);
    await ref1.putFile(file).then((p0){ emit(AppGetDatabaseLoadingState());});
    final url = await ref1.getDownloadURL();
    final user = await FirebaseAuth.instance.currentUser;

    DocumentReference ref =
    FirebaseFirestore.instance.collection('users').doc(user.uid);
    ref.update({'imageurl': url}).then((value){
      print('Image Updated');
      final scaffold = ScaffoldMessenger.of(context);
      scaffold.showSnackBar(
        SnackBar(
          content: const Text('Your Picture Updated'),
        ),
      );
      emit(ChangedPhotoState());
    }).catchError((error){
      print('${error.toString()}');
    });
  }

  getData() async {
    final user = await FirebaseAuth.instance.currentUser;
    if (user != null)
      return await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get()
          .then((value) {
        img = value.data()['imageurl'];
        emit(GetDataState());
      }).catchError((e) {
        print(e);
      });
  }

}