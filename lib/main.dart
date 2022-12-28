import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:iot_switch/page/ContantRequest.dart';
import 'package:iot_switch/page/EditButton.dart';
import 'package:iot_switch/page/addButton.dart';
import 'package:iot_switch/page/adduser1.dart';
import 'package:iot_switch/page/profile.dart';
import 'package:iot_switch/page/schedule.dart';
import 'package:iot_switch/page/setting.dart';
import 'package:iot_switch/page/log.dart';
import 'page/splashs.dart';
import 'componant/BottomBar1.dart';
import 'componant/ButtomBar.dart';
import 'controllar/SetParameter.dart';
import 'page/widght.dart';
import 'package:provider/provider.dart';
import 'page/info.dart';
import 'page/login.dart';
import 'page/splashs.dart';
import 'package:get_storage/get_storage.dart';

import 'package:shared_preferences/shared_preferences.dart';
//Abdurrhmankhrrat
var check=true;
var username;
var email;



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();

  runApp(
      ChangeNotifierProvider(child:MyApp(),create: (context) => Model(),)
  );
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // cc().getpref();

    return MaterialApp(
      //start project
        debugShowCheckedModeBanner: false,
        title: "IOT|A&F ",
        theme: ThemeData(primarySwatch:Colors.blueGrey),
        home: GetStorage().read<bool>("auth") == true
            ? AnimatedBottomBar():LogIn(),
        routes: {
          'home': (context) {
            return widghtt();
          },
          'info': (context) {
            return HomeSample();
          },
          'widght': (context) {
            return widghtt();
          },
          'addButton': (context) {
            return addButton();
          },
          'log': (context) {
            return log();
          },
          'setting': (context) {
            return MyPluginn();
          },
          'editButton': (context) {
            return editButton();
          },
          'bar': (context) {
            return AnimatedBottomBar();
          }, 'bar1': (context) {
            return AnimatedBottomBarr();
          },
          'login': (context) {
            return LogIn();
          },
          'schedule': (context) {
            return Schedule();
          },'adduser': (context) {
            return AddUser();
          },'requset': (context) {
            return Request();
          }, 'profile': (context) {
            return profile();
          },'MyHomePage': (context) {
            return MyHomePagee();
          },

        }
      //end project
    );
  }
}
