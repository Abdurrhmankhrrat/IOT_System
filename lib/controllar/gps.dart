import 'dart:async';
import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:iot_switch/api/URL.dart';
import 'package:iot_switch/componant/notification.dart';
//import 'package:iot_switch/componant/notification.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:geolocator/geolocator.dart';

class gps extends ChangeNotifier {
  var latitude;
  var longitude;
  late bool services;
  late LocationPermission per;
  var validity;

  Future getPirmission() async {
    // print("-----------5");
    services = await Geolocator.isLocationServiceEnabled();
    //  print("***********");

    if (services == false) {
      print("nooooooooo");
    }
    per = await Geolocator.checkPermission();
    //print("55555");
    if (per == LocationPermission.denied) {
      per == await Geolocator.requestPermission();
      // print("//////55");
      //
    }
  }

  Future locationUser(lat, long, context) async {

    SharedPreferences preferences = await SharedPreferences.getInstance();
 //   preferences.getString("mytoken");
  // var token ="c9vJhg2yTNynXz3293DGXV:APA91bF7TeybsFmD6nXDTiSx0MEL3twENcWilihVaXBDB_UGft7Bty_onbrXYGalzzDE87vFiyS7QzaXkCvY0LGSO_etsmdGp71AWd0hTmM9ABIG5TKA3VvErK2zlqticQhCBRtDW00I" ;
  //   var token= "d8nYEeCPSmukZOKb3G12L-:APA91bHDkVczW5BsfbzdGaF4GDC75usTqNegFG6CNI83_lVXbVrRt2WwZo3zLJEEnmfDHv6KV-H4DreYRk5uiOX_htnkWIwVB3glTQ2zCjSvZ3e6kQG56n0lyQRoaF_EGStcWswWOgHw";
    var token=preferences.getString("mytoken");
    print("333333333333333333");
    var latlong = await Geolocator.getCurrentPosition(
        forceAndroidLocationManager: true,
        desiredAccuracy: LocationAccuracy.high)
        .then((value) => value);
    latitude = latlong.latitude;
    longitude = latlong.longitude;
    print("------");
    double distanceInMeters =
    Geolocator.distanceBetween(lat, long, latitude, longitude);
    // print("545454545");
  //  SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setDouble("distanceInMeters", distanceInMeters);
    print(distanceInMeters);
    var i=0;
    if (distanceInMeters > 80 && distanceInMeters < 400) {
      if(i==0){NotificationBaraa.sendPushMessage(token.toString(), "يوجد اجهزة تعمل", "تنبيه");i++;notifyListeners();}
     //NotificationBaraa.sendPushMessage(token.toString(), "تنبيه", "يوجد اجهزة تعمل");
      print("----4444--");
    } else if (distanceInMeters > 1500 && distanceInMeters < 1600) {
      print("4444444444444");
      // return AwesomeDialog(
      //   context: context,
      //   animType: AnimType.BOTTOMSLIDE,
      //   dialogType: DialogType.SUCCES,
      //   body: Center(
      //     child: Text(
      //       "نسيت اجهزة تعمل",
      //       style: const TextStyle(fontStyle: FontStyle.italic),
      //       textAlign: TextAlign.center,
      //     ),
      //   ),
      //   //  title: title,
      //   desc: 'This is also Ignored',
      //   btnOkOnPress: () {},
      // )..show();
      //NotificationBaraa.sendPushMessage(token, "تنبيه", "يوجد اجهزة تعما");

    } else if (distanceInMeters > 1600) {
      // timer1.cancel();
      print("5555555555555555555");
    }

    // print("545454545");
  }


  var latb;
  var longb;
  late double latitude2;

  late double longitude2;

  late bool ff;

  Timer timer1 = Timer(Duration(milliseconds: 500), () {
    // SOMETHING
  });

  Future getData(context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var response = await http.get(Uri.parse('http://$api/abd.php'));
    var responsebody = jsonDecode(response.body);
    if (responsebody['status'] == 'success') {
      getpref(context);

    }
    else {

      timer1.cancel();
      print("////");
    }

    return responsebody;
  }

  Future fetch_lat_long(idUser, context) async {
    try {
      print("111111111111111");

      var data = {"idUser": idUser};

      var response = await http.get(Uri.parse('http://$api/bb.php'));

      var responsebody = jsonDecode(response.body);
      print("*******");
      print(responsebody[0]["latitude"]);
      latb = responsebody[0]["latitude"];
      print(responsebody[0]["longitude"]);
      longb = responsebody[0]["longitude"];
      latitude2 = double.parse(latb);
      longitude2 = double.parse(longb);
      timer1 = Timer.periodic(const Duration(seconds: 10),
          (Timer t) => locationUser(latitude2, longitude2, context));

      print("*******");

      return responsebody;
    } catch (e) {}
  }

  var idUser;

  //
  getpref(context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

  print("22222222222222222");
    idUser = preferences.getString("id");
    fetch_lat_long(idUser, context);
    notifyListeners();
    print(idUser);
  }
}
