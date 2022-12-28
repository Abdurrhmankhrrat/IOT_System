import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iot_switch/api/URL.dart';
import 'package:iot_switch/page/button_bar.dart';
import '../componant/ButtomBar.dart';

import 'bottlist.dart';
import '../componant/myDrawer.dart';

class widghtt extends StatefulWidget {
  @override
  _widghttState createState() => _widghttState();
}

class _widghttState extends State<widghtt> {
  late Timer t;
var user;
  Future getData() async {
    var url = Uri.parse("http://$api/getdata.php");
    //var response = await http.get(url);
    // var data = {"": ""};
    var response = await http.get(url);
    var responsebody = jsonDecode(response.body);
    setState(() {});

    return responsebody;
  }

  getpref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    user = preferences.getString("username");
  //  print(user);

  }
  @override
  void initState() {
    getData();
    getpref();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
      //    bottomNavigationBar: button_bar(),
          //drawer: MyDrawer(),
          appBar: AppBar(
            title:Text("لوحة التحكم "),// Text("Control Panal"),
            backgroundColor: Colors.blueGrey[900],
            centerTitle: true,
            // actions: [
            //   IconButton(
            //       icon: Icon(Icons.add_box),
            //       onPressed: () {
            //         Navigator.of(context).pushNamed('addButton');
            //       }),
            // ],
          ),
          body: Container(
            color: Colors.grey[400],
            padding: EdgeInsets.only(top: 8),
            height: MediaQuery.of(context).size.height,

            child:
            FutureBuilder(
                future: getData(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {

                  if (snapshot.hasData) {
                    //     print("has data");

                    return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 1.0,
                            crossAxisCount: 3),
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext ctx, index) {
                          List list = snapshot.data;

                          return Container(
                            height: 20,
                            child:
                            BottList(

                              id: list[index]['id'],
                              state: list[index]['state'],
                              name: list[index]['name'],
                              urlimage:list[index]['urlimage'],
                              urlimage1:list[index]['urlimage1'],
                              bkcolor:list[index]['bkcolor'],
                              username:user,
                              //board: snapshot.data[i]['board']
                            ),
                          );
                        });
                  }

                  return Center(child: CircularProgressIndicator());
                }),
          )
      ,),
    );
  }
}
