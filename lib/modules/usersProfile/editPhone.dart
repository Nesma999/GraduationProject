import 'package:Conneect_Firebase/Components/components.dart';
import 'package:Conneect_Firebase/Components/constant.dart';
import 'package:Conneect_Firebase/shared/cubit/cubit.dart';
import 'package:Conneect_Firebase/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'drawer.dart';
import 'editLoc.dart';

class EditPhone extends StatefulWidget {
  @override
  EditPhoneState createState() => EditPhoneState();
}

class EditPhoneState extends State<EditPhone> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => CubitApp(),
        child: BlocConsumer<CubitApp, CubitStatesApp>(
          listener: (context, state) {
            if (state is GetDataState) {
              Navigator.pop(
                  context); //3shan 3yza ll bottom sheet t2fl b3d ma a3ml update
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: defaultAppBar(context),
              drawer: Drawer(
                child: DrawerScreen(),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    state is AppGetDatabaseLoadingState
                        ? Center(
                            child: Column(children: [
                            LinearProgressIndicator(),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Loading....',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ]))
                        : defaultBackground(
                            image: () {
                              pic.bottomSheetImage(context);
                            },
                            padding: Padding(padding: EdgeInsets.all(0.0)),
                          ),
                    SizedBox(
                      height: 20,
                    ),
                    defaultUserInfo(
                        futureBuilder: FutureBuilder(
                            future: db.getCurrentUserInfo(),
                            builder: (context, snapshot) {
                              return defaultUserGet(
                                data: db.user_email,
                              );
                            }),
                        icon: Icons.email_rounded,
                        text: 'Email',
                        width: 20,
                        iconEdit: Icons.edit,
                        // width: 112.0,
                        edit: () {
                          db.navigatorEmail(context);
                        }),
                    SizedBox(
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                    defaultEditTextField(
                      update: () {
                        db.updateMobile(context);
                      },
                      suffix: Icons.add_box_outlined,
                      icon: Icons.phone,
                      text: 'Phone',
                      label: 'Enter your Phone',
                      keyboard: TextInputType.phone,
                      onChanged: (value) {
                        setState(() {
                          db.updatePhone = value;
                        });
                      },
                    ),
                    SizedBox(
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                    defaultUserInfo(
                        futureBuilder: FutureBuilder(
                            future: db.getData(),
                            builder: (context, snapshot) {
                              return defaultUserGet(
                                data: db.subadmin,
                              );
                            }),
                        icon: Icons.location_on,
                        text: 'Location',
                        iconEdit: Icons.edit,
                        width: 30.0,
                        edit: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditLoc()));
                        }),
                    SizedBox(
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                    defaultUserInfo(
                        futureBuilder: FutureBuilder(
                            future: db.getData(),
                            builder: (context, snapshot) {
                              return defaultUserGet(
                                data: db.age,
                              );
                            }),
                        icon: Icons.perm_contact_calendar,
                        text: 'Age',
                        iconEdit: Icons.edit,
                        width: 65.0,
                        edit: () {
                          db.navigatorAge(context);
                        }),
                    SizedBox(
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                    defaultUserInfo(
                      futureBuilder: FutureBuilder(
                          future: db.getData(),
                          builder: (context, snapshot) {
                            return defaultUserGet(
                              data: db.type,
                            );
                          }),
                      icon: Icons.local_fire_department_rounded,
                      text: 'Blood Type',
                      width: 20.0,
                    ),
                    SizedBox(
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                    defaultUserInfo(
                      futureBuilder: FutureBuilder(
                          future: db.getData(),
                          builder: (context, snapshot) {
                            return defaultUserGet(
                              data: db.validity,
                            );
                          }),
                      icon: Icons.event_note,
                      text: 'Blood Donation Validity',
                      width: 0.0,
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }

  Widget editPhoneGreen(){
    return  BlocProvider(
        create: (context) => CubitApp(),
        child: BlocConsumer<CubitApp, CubitStatesApp>(
          listener: (context, state) {
            if (state is GetDataState) {
              Navigator.pop(
                  context); //3shan 3yza ll bottom sheet t2fl b3d ma a3ml update
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: defaultAppBar(context),
              drawer: Drawer(
                child: DrawerScreen(),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Stack(alignment: Alignment.centerLeft, children: [
                      state is AppGetDatabaseLoadingState
                          ? Center(
                          child: Column(children: [
                            LinearProgressIndicator(),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Loading....',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ]))
                          : defaultBackground(
                        image: () {
                          pic.bottomSheetImage(context);
                        },
                        padding: Padding(
                          padding: EdgeInsetsDirectional.only(
                              top: 215, end: 130),
                          child: Icon(
                            Icons.circle,
                            color: Colors.green,
                            size: 15,
                          ),
                        ),
                      ),
                    ]),
                    SizedBox(
                      height: 20,
                    ),
                    defaultUserInfo(
                        futureBuilder: FutureBuilder(
                            future: db.getCurrentUserInfo(),
                            builder: (context, snapshot) {
                              return defaultUserGet(
                                data: db.user_email,
                              );
                            }),
                        icon: Icons.email_rounded,
                        text: 'Email',
                        width: 20,
                        iconEdit: Icons.edit,
                        // width: 112.0,
                        edit: () {
                          db.navigatorEmail(context);
                        }),
                    SizedBox(
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                    defaultEditTextField(
                      update: () {
                        db.updateMobile(context);
                      },
                      suffix: Icons.add_box_outlined,
                      icon: Icons.phone,
                      text: 'Phone',
                      label: 'Enter your Phone',
                      keyboard: TextInputType.phone,
                      onChanged: (value) {
                          db.updatePhone = value;
                      },
                    ),
                    SizedBox(
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                    defaultUserInfo(
                        futureBuilder: FutureBuilder(
                            future: db.getData(),
                            builder: (context, snapshot) {
                              return defaultUserGet(
                                data: db.subadmin,
                              );
                            }),
                        icon: Icons.location_on,
                        text: 'Location',
                        iconEdit: Icons.edit,
                        width: 30.0,
                        edit: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditLoc()));
                        }),
                    SizedBox(
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                    defaultUserInfo(
                        futureBuilder: FutureBuilder(
                            future: db.getData(),
                            builder: (context, snapshot) {
                              return defaultUserGet(
                                data: db.age,
                              );
                            }),
                        icon: Icons.perm_contact_calendar,
                        text: 'Age',
                        iconEdit: Icons.edit,
                        width: 65.0,
                        edit: () {
                          db.navigatorAge(context);
                        }),
                    SizedBox(
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                    defaultUserInfo(
                      futureBuilder: FutureBuilder(
                          future: db.getData(),
                          builder: (context, snapshot) {
                            return defaultUserGet(
                              data: db.type,
                            );
                          }),
                      icon: Icons.local_fire_department_rounded,
                      text: 'Blood Type',
                      width: 20.0,
                    ),
                    SizedBox(
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                    defaultUserInfo(
                      futureBuilder: FutureBuilder(
                          future: db.getData(),
                          builder: (context, snapshot) {
                            return defaultUserGet(
                              data: db.validity,
                            );
                          }),
                      icon: Icons.event_note,
                      text: 'Blood Donation Validity',
                      width: 0.0,
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }

  Widget editPhoneRed(){
    return BlocProvider(
        create: (context) => CubitApp(),
        child: BlocConsumer<CubitApp, CubitStatesApp>(
          listener: (context, state) {
            if (state is GetDataState) {
              Navigator.pop(
                  context); //3shan 3yza ll bottom sheet t2fl b3d ma a3ml update
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: defaultAppBar(context),
              drawer: Drawer(
                child: DrawerScreen(),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Stack(alignment: Alignment.centerLeft, children: [
                      state is AppGetDatabaseLoadingState
                          ? Center(
                          child: Column(children: [
                            LinearProgressIndicator(),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Loading....',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ]))
                          : defaultBackground(
                          image: () {
                            pic.bottomSheetImage(context);
                          },
                          padding: Padding(
                            padding: EdgeInsetsDirectional.only(
                                top: 215, end: 130),
                            child: Icon(
                              Icons.circle,
                              color: Colors.red,
                              size: 15,
                            ),
                          )),
                    ]),
                    SizedBox(
                      height: 20,
                    ),
                    defaultUserInfo(
                        futureBuilder: FutureBuilder(
                            future: db.getCurrentUserInfo(),
                            builder: (context, snapshot) {
                              return defaultUserGet(
                                data: db.user_email,
                              );
                            }),
                        icon: Icons.email_rounded,
                        text: 'Email',
                        width: 20,
                        iconEdit: Icons.edit,
                        // width: 112.0,
                        edit: () {
                          db.navigatorEmail(context);
                        }),
                    SizedBox(
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                    defaultEditTextField(
                      update: () {
                        db.updateMobile(context);
                      },
                      suffix: Icons.add_box_outlined,
                      icon: Icons.phone,
                      text: 'Phone',
                      label: 'Enter your Phone',
                      keyboard: TextInputType.phone,
                      onChanged: (value) {
                          db.updatePhone = value;
                      },
                    ),
                    SizedBox(
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                    defaultUserInfo(
                        futureBuilder: FutureBuilder(
                            future: db.getData(),
                            builder: (context, snapshot) {
                              return defaultUserGet(
                                data: db.subadmin,
                              );
                            }),
                        icon: Icons.location_on,
                        text: 'Location',
                        iconEdit: Icons.edit,
                        width: 30.0,
                        edit: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditLoc()));
                        }),
                    SizedBox(
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                    defaultUserInfo(
                        futureBuilder: FutureBuilder(
                            future: db.getData(),
                            builder: (context, snapshot) {
                              return defaultUserGet(
                                data: db.age,
                              );
                            }),
                        icon: Icons.perm_contact_calendar,
                        text: 'Age',
                        iconEdit: Icons.edit,
                        width: 65.0,
                        edit: () {
                          db.navigatorAge(context);
                        }),
                    SizedBox(
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                    defaultUserInfo(
                      futureBuilder: FutureBuilder(
                          future: db.getData(),
                          builder: (context, snapshot) {
                            return defaultUserGet(
                              data: db.type,
                            );
                          }),
                      icon: Icons.local_fire_department_rounded,
                      text: 'Blood Type',
                      width: 20.0,
                    ),
                    SizedBox(
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                    defaultUserInfo(
                      futureBuilder: FutureBuilder(
                          future: db.getData(),
                          builder: (context, snapshot) {
                            return defaultUserGet(
                              data: db.validity,
                            );
                          }),
                      icon: Icons.event_note,
                      text: 'Blood Donation Validity',
                      width: 0.0,
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
