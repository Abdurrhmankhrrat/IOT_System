// ignore_for_file: file_names, no_logic_in_create_state
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:iot_switch/api/URL.dart';
import 'loglist.dart';

class log extends StatefulWidget {
  @override
  _logState createState() => _logState();
}

class _logState extends State<log> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future getData() async {
      var url = Uri.parse("http://$api/getDateTime.php");
      var response = await http.get(url);
      var responsebody = jsonDecode(response.body);
      setState(() {});
      return responsebody;
    }

    return Scaffold(
        //bottomNavigationBar: button_bar(),
        appBar: AppBar(
          title: Text("سجل الأحداث"),//Text("LogButton"),
          backgroundColor: Colors.blueGrey[900],
          centerTitle: true,
          elevation: 6,
          // actions: <Widget>[
          //   IconButton(icon: Icon(Icons.exit_to_app), onPressed: () {}),
          // ],
        ),
        body: Container(
            color: Colors.grey[400],
            padding: EdgeInsets.only(top: 8),
            //height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Row(children: [
                  Padding(padding: EdgeInsets.all(12)),
                  Container(
                    child: Column(
                      children: [Text(" التاريخ و اليوم")],
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  Container(
                    child: Column(
                      children: [Text("الساعة")],
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  Container(
                    child: Column(
                      children: [Text("الجهاز")],
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  Container(
                    child: Column(
                      children: [Text("الحالة")],
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(7)),
                  Container(
                    child: Column(
                      children: [Text("اسم المستخدم")],
                    ),
                  ),
                ]),
                const Divider(
                  thickness: 1,
                  color: Colors.black,
                ),
                Container(
                  height: MediaQuery.of(context).size.height - 185,
                  child: FutureBuilder(
                      future: getData(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 7, crossAxisCount: 1),
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext ctx, index) {
                                List list = snapshot.data;
                                return Container(
                                    height: 1,
                                    child: (LogList(
                                      id: list[index]['id'],
                                      action: list[index]['action_time'],
                                      name: list[index]['name'],
                                      state: list[index]['state'],
                                      user:list[index]['actor'],
                                    )));
                              });
                        }
                        return Center(child: CircularProgressIndicator());
                      }),
                ),
              ],
            )));
  }
}
