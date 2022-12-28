// ignore: file_names
// ignore: file_names
// ignore_for_file: file_names


import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:iot_switch/api/URL.dart';



class Model extends ChangeNotifier {
  var showsomething1 = 0;
  var showsomething2 = "Show Something";

  get showone => valuee;
  get showtwo => statee;
  get showtwo2 => numid;
  late int id;
  bool value = false;
  bool valuee = false;
  String? numid;
  bool? v;
  late int state;
  late int statee;

  dosomething(String number) {
    numid = number;
    Edit_Name.updateName(number);

  }
  dosomething2() {
    return showtwo2;
  }
  Future state_parameter(String stt) async {
    if (stt == "1") {
      statee = 1;
      valuee = true;
    } else {
      statee = 0;
      valuee = false;
    }

    //  notifyListeners();
    //value=true;
    // if(showsomething2=="Show Something"){showsomething2='yes provider 2 ';}
    // else if (showsomething2=='yes provider 2 '){showsomething2="Show Something";}
  }

  value_parameter(bool val, String id, String name,String actor) {
    //print("${value}");
    if (val == true) {
      state = 0;
      value = false;
      log(name, val,actor);
      //  notifyListeners();
    } else if (val == false) {
      state = 1;
      value = true;
      log(name, val,actor);

      //    notifyListeners();
    } else {
      value = false;
      state = 0;
      //  notifyListeners();
    }

    updata.updateState(state, id);
    //   notifyListeners();
  }

  log(String name, bool st,String acotr) {

    time_action.SetActionTime(
        DateTime.now().toString(), st ? "Turn OFF" : "Turn ON ", name,acotr);
  }
}

class updata {
  static updateState(int sta, String id) async {
    var url = Uri.parse("http://$api/test.php");
    var data = {
      "ID": id,
      "State": sta.toString(),
    };

    var response = await http.post(url, body: data);
  }
}

class Edit_Name {
  static updateName(String id) async {
    var url = Uri.parse("http://$api/editName.php");
    var data = {
      "id": "1",
      "name": id,
    };

    var response = await http.post(url, body: data);
  }
}

class time_action {
  static SetActionTime(String time, String state, String name,String actor) async {
    var url = Uri.parse("http://$api/updatetime.php");
    var data = {
      "action": time,
      "state": state,
      "name": name,
      "actor": actor,
    };
    var response = await http.post(url, body: data);
  }
}

////////////////////gps///////////////////////////////


class SelectLocation {
  var latitude;
  var longitude;
  late bool services;
  late LocationPermission per;

  SetLocation()async{

    var url = Uri.parse("http://$api/SetLocation.php");
    var data = {
      "id":"9",
      "latitude": latitude.toString(),
      "longitude": longitude.toString(),
    };

    var response = await http.post(url, body: data);
  }

  Future getPirmission() async {
   // print("-----------5");
    services = await Geolocator.isLocationServiceEnabled();
  // print("***********");

    if (services == false) {
    //  print("service is false");
    }
    per = await Geolocator.checkPermission();
   // print("per saccess");
    if (per == LocationPermission.denied) {
      per == await Geolocator.requestPermission();
   //   print("//////55");
      //
    }

    var latlong = await Geolocator.getCurrentPosition().then((value) => value);
    latitude = latlong.latitude;
    longitude = latlong.longitude;
    //print(latitude);
    //print(longitude);

    SetLocation();
  }
}

