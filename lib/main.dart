import 'package:Conneect_Firebase/modules/login/login.dart';
import 'package:Conneect_Firebase/shared/cubit/block_observe.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized(); //دي اول حاجة لازم انادي عليها عشان استخدم الفايربيز
  await Firebase.initializeApp();
  BlocOverrides.runZoned((){
    return runApp(MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme:AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.black,
              statusBarIconBrightness: Brightness.light,
            ),
          ),
        ),
    );
  }
}
