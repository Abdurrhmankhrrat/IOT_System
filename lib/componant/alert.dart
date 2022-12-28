
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:iot_switch/achievement/achievement_view.dart';
import 'package:iot_switch/api/URL.dart';
import 'package:iot_switch/controllar/SetParameter.dart';

void show(BuildContext context ,String Title,String Subtitle) {
  var isCircle =false;
  AchievementView(
    context,
    alignment: Alignment.topCenter,
    title: Title,
    subTitle: Subtitle,
    textStyleSubTitle: TextStyle(
      fontSize: 12.0,
    ),
    isCircle: isCircle =false,
  )..show();
}



Future deleteDevise(BuildContext context , String val) async {

  var url = Uri.parse("http://$api/deleteDevise.php");
  var data = {
    "id": val,
  };
  var response = await http.post(url, body: data);
  //Navigator.of(context).pushNamed("widght");

  show(context,"نجحت العملية","تم حذف الجهاز بنجاح");

  ///Navigator.of(context).pop();
}



void alert(BuildContext context,String val) {
  AwesomeDialog(
      context: context,
      //btnCancelColor: Colors.lightBlue,
      dialogType: DialogType.WARNING,
      btnCancelIcon: Icons.cancel_outlined,
      btnOkIcon: Icons.check_outlined,
      headerAnimationLoop: false,
      animType: AnimType.TOPSLIDE,
      title: 'تحذير',
      desc: 'هل أنت متأكد من حذف الجهاز',
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        deleteDevise(context,val);
      })
      .show();
}


void alertLocation(BuildContext context) {
  AwesomeDialog(
      context: context,
      //btnCancelColor: Colors.lightBlue,
      dialogType: DialogType.QUESTION,
      btnCancelIcon: Icons.cancel,
      btnOkIcon: Icons.check_outlined,
      headerAnimationLoop: false,
      animType: AnimType.TOPSLIDE,
      title: "مهلاً",// 'Quastion',
      desc:" (A&F)هل أنت متأكد من تعيين موقع جديد للمتحكم",//'Are you sure you want to set new Locaton',
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        SelectLocation().getPirmission();
show(context, "الموقع", "تم تحديد الموقع بنجاح");
      })
      .show();
}

//                    Tooltip(message: "dssdf"),