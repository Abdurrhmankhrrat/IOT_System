// ignore_for_file: file_names


import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:iot_switch/achievement/achievement_view.dart';
import 'package:iot_switch/api/URL.dart';
import 'package:iot_switch/componant/ButtomBar.dart';
import 'package:iot_switch/componant/alert.dart';

import 'button_bar.dart';

class addButton extends StatefulWidget {
  // const addButton({Key? key}) : super(key: key);

  @override
  _addButtonState createState() => _addButtonState();
}

class _addButtonState extends State<addButton> {
  TextEditingController name = new TextEditingController();
  List<String> selected = [];
  String dropdownValue = 'SelectPin';
  String dropdownValue1 = 'selectColor';
  Image ?IMAGE ;
  bool isCircle = false;
   int ?SelectedRadio;
   int ?SelectedRadiostate;
String GPIO='1';
  int BoardID =1;
String UrlImage="assets/on.png";
String UrlImage1="assets/off.png";
String color="green";

  @override
  void initState() {
  super.initState();
  SelectedRadio = 0;
  }

  Future AddButton() async {
    var state = 1;

    var url = Uri.parse("http://$api/addbutton.php");
    var data = {
      "name": name.text,
      "board":BoardID.toString(),
      "gpio":GPIO.toString(),
      "state":SelectedRadiostate.toString(),
      "image":UrlImage,
      "image1":UrlImage1,
      "color":color,

    };
    var response = await http.post(url, body: data);
    show(context,"نجحت العملية","تمت إضافة الجهاز بنجاح ");
    //Navigator.of(context).pushNamed("widght");
    //Navigator.of(context).pop();

  }
Future setIcon()async{
    print(SelectedRadio);
    if(SelectedRadio==1){
      UrlImage="assets/on.png";
      UrlImage1="assets/off.png";
    }
else if (SelectedRadio ==2){
      UrlImage="assets/freezing_on.png";
      UrlImage1="assets/freezing_off.png";

    }
else if(SelectedRadio==3){
      UrlImage="assets/fan_on.png";
      UrlImage1="assets/fan_off.png";

    }
else{
  print("SelectedRadio is null");
    }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //bottomNavigationBar: button_bar(),
      appBar: AppBar(
        title: Text("إضافة جهاز"),//Text("addButton"),
        backgroundColor: Colors.blueGrey[900],
        centerTitle: true,
        elevation: 6,
        actions: <Widget>[
          // IconButton(icon: Icon(Icons.exit_to_app), onPressed: () {}),
        ],
      ),
      body: ListView(
        children: [
          Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Container(
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 250,bottom: 10),
                      child: Text(
                        "اسم الجهاز ",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: name,
                      maxLength: 15,
                      maxLines: 1,
                      minLines: 1,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(right: 10),
                          hintText: " ادخل الاسم هنا ",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10))),
                    ),

                    Divider(
                      color: Colors.blue,thickness: 0.2,
                    ),Row(
              children: [
                    Padding(
                      padding:
                      const EdgeInsets.only(left: 10, top: 10),
                      child:
                          Padding(
                            padding: const EdgeInsets.only(right: 15, top: 10),
                            child: Text(
                              "اختر نوع الجهاز : ",textAlign: TextAlign.end,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.blue,
                              ),
                            ),
                          ),

            ),
                          Padding(
                            padding: const EdgeInsets.only(right:1,top: 17),
                            child: Text("الافنراضي لمبة"
                                ,style: TextStyle(color: Colors.grey[500],fontSize: 12),
                               // ,textAlign: TextAlign.start,
                            ),
                          ),

                        ],
                      ),



                    RadioListTile(value: 1,
                      controlAffinity: ListTileControlAffinity.trailing,
                      title:Text("لمبة") ,
                      subtitle:Text("ستظهر بالقرب من المفتاح") ,
                      groupValue: SelectedRadio,
                      onChanged: ( val){
                        print("radio $val");
                        setSelectedRadio1();
                      }
                      ,activeColor: Colors.red,
                      secondary:  Image.asset("assets/on.png" ,width: 30,),
                    ),
                    RadioListTile(value: 2,
                      controlAffinity: ListTileControlAffinity.trailing,

                      title: Text("براد") ,
                      subtitle:Text("ستظهر بالقرب من المفتاح") ,
                      groupValue: SelectedRadio,
                      onChanged: ( val){
                        print("radio $val");
                        setSelectedRadio2();
                      }
                      ,activeColor: Colors.red,
                      secondary: Image.asset("assets/freezing_on.png" ,width: 30,),


                    ),
                    RadioListTile(value: 3,
                      controlAffinity: ListTileControlAffinity.trailing,

                      title: Text("أُخرى") ,
                      subtitle:Text("ستظهر بالقرب من المفتاح") ,
                      groupValue: SelectedRadio,
                      onChanged: ( val){
                        print("radio $val");
                        setSelectedRadio3();
                      }
                      ,activeColor: Colors.red,
                      secondary:

                    DropdownButton<Image>(
                      value: IMAGE,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (Image ?newValue) {
                        setState(() {
                          IMAGE = newValue;
                        });
                      },
                      items: <Image>[Image.asset("assets/conon.png" ,width: 30,),Image.asset("assets/fan_on.png" ,width: 30,),
               ]
                          .map<DropdownMenuItem<Image>>((Image valuee) {
                        return DropdownMenuItem<Image>(
                          value: valuee,
                          child: valuee,
                          onTap: (){

                          },

                        );
                      }).toList(),
                    ),
                    ),
                    Divider(
                      color: Colors.blue,thickness: 0.2,
                    ),
                    Padding(
                      padding:  EdgeInsets.only(left: 240, top: 10),
                      child: Text(
                        "الحالة الأولية للجهاز ",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    RadioListTile(value: 1,
                      controlAffinity: ListTileControlAffinity.trailing,
                      title:Text("يعمل") ,
                      subtitle:Text("ستظهر بالقرب من المفتاح") ,
                      groupValue: SelectedRadiostate,
                      onChanged: ( sta){
                        print("state $sta");
                        setSelectedRadiostate1();
                      }
                      ,activeColor: Colors.red,
                    ),
                    RadioListTile(value: 0,
                      controlAffinity: ListTileControlAffinity.trailing,

                      title: Text("لايعمل") ,
                      subtitle:Text("ستظهر بالقرب من المفتاح") ,
                      groupValue: SelectedRadiostate,
                      onChanged: (  sta){
                        print("state $sta");
                      setSelectedRadiostate0();
                      }
                      ,activeColor: Colors.red,
                     // secondary: Image.asset("assets/freezing_on.png" ,width: 30,),

                    ),
                    Divider(
                      color: Colors.blue,thickness: 0.2,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 180, top: 10),
                      child: Text(
                        "اختر رقم المفتاح على الدارة ",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    DropdownButton<String>(
                      value: dropdownValue,

                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: const TextStyle(color: Colors.black54),
                      underline: Container(
                        height: 2,
                        color: Colors.lightBlue,
                      ),

                      onChanged: (String ?newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },

                      items: <String>["SelectPin",'0','2','4','5','16','17','18','19']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                          onTap: (){
                          setState(() {
                            GPIO=value;
                          });
                          },
                        );
                      }).toList(),
                    ),
                    //Padding(padding: EdgeInsets.all(10)),
                    Divider(
                      color: Colors.blue,thickness: 0.2,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:300, top: 1),
                      child: Text(
                        "اللون ",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    Padding(
            padding: const EdgeInsets.all(0.0),
              child:  DropdownButton<String>(
                value: dropdownValue1,

                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.black54),
                underline: Container(
                  height: 2,
                  color: Colors.lightBlue,
                ),

                onChanged: (String ?newValue) {
                  setState(() {
                    dropdownValue1 = newValue!;
                  });
                },

                items: <String>["selectColor",'lightBlue', 'green', 'lightPurple', 'red',
                  'cyan','lightPeach','labelColor','primary']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,

                    child: Text(value),
                    onTap: (){
                      setState(() {
                        color=value;
                      });
                    },

                  );
                }).toList(),
              ),
          ),
                    Divider(
                      color: Colors.blue,thickness: 0.2,
                    ),
                    RaisedButton(
                        child: Text("موافق"),
                        color: Colors.lightBlue,
                        onPressed: () {
                          isCircle = true;
                          AddButton();
                        }),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  setSelectedRadio1() {
    setState(() {
      SelectedRadio = 1;
    });setIcon();
  }
  setSelectedRadio2() {
    setState(() {
      SelectedRadio = 2;
      setIcon();
    });
  }
  setSelectedRadio3() {
    setState(() {
      SelectedRadio = 3;
    });setIcon();
  }
  setSelectedRadiostate0() {
    setState(() {
      SelectedRadiostate = 0;
    });
  }
  setSelectedRadiostate1() {
    setState(() {
      SelectedRadiostate = 1;
    });
  }

}

/////////////////
