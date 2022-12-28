import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:iot_switch/api/URL.dart';

import 'gps.dart';


class gps_controllar{
  Future getData() async {
    var url = Uri.parse("http://$api/getLocation.php");
    //var response = await http.get(url);
    // var data = {"": ""};
    var response = await http.get(url);
    var responsebody = jsonDecode(response.body);



    for (int i = 0; i < responsebody.length; i++) {
    //print(responsebody[i]) ;

    }
    return responsebody;
  }

}