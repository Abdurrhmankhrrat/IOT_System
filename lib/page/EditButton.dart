// ignore_for_file: file_names, no_logic_in_create_state

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:iot_switch/api/URL.dart';
import 'package:iot_switch/componant/alert.dart';
import '../controllar/SetParameter.dart';
import 'package:provider/provider.dart';

class editButton extends StatefulWidget {
  // const addButton({Key? key}) : super(key: key);

  @override
  _editButtonState createState() => _editButtonState();
}

class _editButtonState extends State<editButton> {
  String value = "abdurrhman";

//String ?id;

  TextEditingController name = new TextEditingController();

  List<String> listpinname = [];
  String dropdownValue1 = ' اختر اللون';

  var isCircle = false;
  String color = "green";

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future getData() async {
    var url = Uri.parse("http://$api/geteditname.php");
    var data = {"": ""};

    var response = await http.post(url, body: data);
    var responsebody = jsonDecode(response.body);
    listpinname.add(responsebody[0]['name']);
    print(listpinname);

    return responsebody;
  }

  Future UpdataName() async {
    var url = Uri.parse("http://$api/updataButtonName.php");
    var data = {
      "id": listpinname[0],
      "name": name.text,
    };
    var response = await http.post(url, body: data);
    //Navigator.of(context).pushNamed("widght");

    show(context, "نجحت العملية", "تم تعديل الجهاز بنجاح");
    Navigator.of(context).pop();
  }

  Future UpdataColor() async {
    var url = Uri.parse("http://$api/updateButtonColor.php");
    var data = {
      "id": listpinname[0],
      "color": color,
    };
    var response = await http.post(url, body: data);
    //Navigator.of(context).pushNamed("widght");

    show(context, "نجحت العملية", "تم تعديل اللون بنجاح");
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => Model(),

        child: Scaffold(
          // bottomNavigationBar: button_bar(),

          appBar: AppBar(
            title: Text("تعديل الجهاز "),
            backgroundColor: Colors.blueGrey[900],
            centerTitle: true,
            elevation: 6,
            // actions: <Widget>[
            //   IconButton(icon: Icon(Icons.exit_to_app), onPressed: () {}),
            // ],
          ),
          body: SingleChildScrollView(
            child: Container(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 220, bottom: 10, top: 10),
                      child: Text(
                        "تعديل اسم الجهاز ",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: name,
                        maxLength: 15,
                        maxLines: 1,
                        minLines: 1,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(right: 10),
                            hintText: " ادخل الاسم الجديد هنا ",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                    RaisedButton(
                      child: Text("حفظ "),
                      onPressed: () {
                        UpdataName();
                      },
                    ),
                    Divider(
                      color: Colors.blue,
                      thickness: 0.2,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 260, bottom: 10, top: 10),
                      child: Text(
                        "تعديل اللون  ",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: DropdownButton<String>(
                        value: dropdownValue1,
                        icon: const Icon(Icons.arrow_downward),
                        elevation: 16,
                        style: const TextStyle(color: Colors.black54),
                        underline: Container(
                          height: 2,
                          color: Colors.lightBlue,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue1 = newValue!;
                          });
                        },
                        items: <String>[
                          dropdownValue1,
                          'lightBlue',
                          'green',
                          'lightPurple',
                          'red',
                          'cyan',
                          'lightPeach',
                          'labelColor',
                          'primary'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                            onTap: () {
                              setState(() {
                                color = value;
                              });
                            },
                          );
                        }).toList(),
                      ),
                    ),
                    RaisedButton(
                      child: Text("حفظ "),
                      onPressed: () {
                        UpdataColor();
                      },
                    ),
                    Divider(
                      color: Colors.blue,
                      thickness: 0.2,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 260, bottom: 10, top: 10),
                      child: Text(
                        "حذف الجهاز ",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    RaisedButton(
                      child: Text("حذف الان "),
                      onPressed: () {
                        alert(context, listpinname[0]);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
