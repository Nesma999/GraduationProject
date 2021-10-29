import 'package:Conneect_Firebase/pages/EditAge.dart';
import 'package:Conneect_Firebase/pages/EditEmailScreen.dart';
import 'package:Conneect_Firebase/pages/EditLocation.dart';
import 'package:Conneect_Firebase/pages/EditName.dart';
import 'package:Conneect_Firebase/pages/EditPhone.dart';
import 'package:Conneect_Firebase/pages/home.dart';
import 'package:Conneect_Firebase/pages/image.dart';
import 'package:Conneect_Firebase/pages/login.dart';
import 'package:Conneect_Firebase/provider/auth_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); //دي اول حاجة لازم انادي عليها عشان استخدم الفايربيز
  await Firebase
      .initializeApp(); // دي بترجع future عشان كدة استخدمنا async-await
  return runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _showScreen(context),
        debugShowCheckedModeBanner: false,
        // initialRoute: '/imgprofile',
        // routes: <String,WidgetBuilder>{
        //   //'/imgprofile': (BuildContext context) => new Imagee(),
        //   //'/EditEmail': (BuildContext context) => new EditEmail(),
        //   //'/EditPhone': (BuildContext context) => new EditPhone(),
        //   //'/EditLocation': (BuildContext context) => new EditLocation(),
        //   //'/EditAge': (BuildContext context) => new EditAge(),
        //   //'/EditName': (BuildContext context) => new EditName(),
        //
        // }
    );
  }

  Widget _showScreen(context) {
    var provider = Provider.of<AuthProvider>(context);
    switch (provider.authStatus) {
      //يشوف حالة اليوزر
      case AuthStatus.authentecating:
      case AuthStatus.unAuthenticated:
        return LoginPage();
      case AuthStatus.authenticated:
        return MyHomePage(
            /*provider.user*/); //  بياخد اليوزرhome موجود في صفحة ال constructr ده

    }
    return Container();
  }
}
