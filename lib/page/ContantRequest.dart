// ignore_for_file: file_names

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iot_switch/api/URL.dart';

import 'RequsetList.dart';
import '../componant/myDrawer.dart';

class Request extends StatefulWidget {
  @override
  _RequestState createState() => _RequestState();
}

class _RequestState extends State<Request> {
  var sn;
  Future getData() async {
    var url = Uri.parse("http://$api/getDataRequest.php");
    //var response = await http.get(url);
    // var data = {"": ""};

    var response = await http.get(url);
    var responsebody = jsonDecode(response.body);

    setState(() {
    });
    return responsebody;



  }

  @override
  void initState() {
    getData();
    //getpref();
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
          title: Text("قائمة الطلبات"),
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

                  return ListView.builder(

                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext ctx, index) {
                        List list = snapshot.data;

                          return
                            RequestList(

                              serial_number: list[index]['serial_number'],
                              name: list[index]['username'],
                              id: list[index]['id'],
                              validity:list[index]['validity'],
                              email:list[index]['email'],
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
