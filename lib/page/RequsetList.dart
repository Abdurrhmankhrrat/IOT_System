
// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:iot_switch/api/URL.dart';
import 'package:http/http.dart' as http;


class RequestList extends StatelessWidget {
  var id;
  var serial_number;
  var validity;
 final name;
 final email;

var x=true;
var y=true;
  RequestList({
    this.id,
    this.serial_number,
    this.validity,
   this.name,
   this.email
  });
void get(){

}

void check(){
  if(validity=="false"){
    x=false;y=true;

  }
  else  if(validity=="true"){
    x=true;  y=false;
  }
  //else x="non";
}

  Future setvalidity(String val ) async {
    var url = Uri.parse("http://$api/setvalidity.php");
    var data = {
      "id": id,
      "validity": val,
      "board_id": "9",
    };
    var response = await http.post(url, body: data);

  }


  Future Updateboardid() async {
    var url = Uri.parse("http://$api/updataSNid.php");
    var data = {
      "email":email ,
      "SN":"9$serial_number",
      "board_id":9,
    };
    var response = await http.post(url, body: data);

  }

  @override
  Widget build(BuildContext context) {
check();
    return Directionality(textDirection: TextDirection.ltr,
      child: Column(
        children: [

          Row(children: [
            Padding(padding: EdgeInsets.all(7)),
            Container(
              child: Column(
                children: [
                  x?y?RaisedButton(
                      child:

                      Center(child: Text("حذف الطلب")),
                      color: Colors.redAccent,
                      onPressed: () {
                 //       print("حذف");
                        setvalidity("false");


                      }):Text("                      "):Text("تم الحذف"),
                ],
              ),
            ),
            Padding(padding: EdgeInsets.all(7)),
            Container(
              child: Column(
                children: [
                 x?y?RaisedButton(
                      child: Text("موافق"),
                      color: Colors.lightGreen,
                      onPressed: () {
                       // checkpassed();
                       setvalidity("true");
                      }):Text("تمت الاضافة"):Text("                          "),
                ],
              ),
            ), Padding(padding: EdgeInsets.only(left: 100,bottom:1,top:1)),
            Container(width:90,
              child: Column(
                children: [
                  Text("$name")
                ],
              ),
            ),
          ]),
          Divider(
            color: Colors.grey[800],
           // thickness: 0.4,
          )
        ],
      ),
    ) ;


  }
}
