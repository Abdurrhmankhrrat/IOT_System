import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:iot_switch/api/URL.dart';
import 'package:http/http.dart' as http;

class Schedule extends StatefulWidget {
  const Schedule({Key? key}) : super(key: key);

  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  DateTime? datePicked;
  TimeOfDay? timePicked;
  late String date;
  DateTime? datePicked2;
  TimeOfDay? timePicked2;
  late String date2;
  var runDate;
  var stopDate;
  late Timer timer1;
  late Timer timer2;

  Future getData() async {
    var url = Uri.parse("http://$api/getdata.php");
    var response = await http.get(url);
    var responsebody = jsonDecode(response.body);
    setState(() {});

    return responsebody;
  }

  Future runDevice(idDevice) async {
    var url = Uri.parse("http://$api/schedule/run_device.php");
    var data = {"idDevice": idDevice};
    var response = await http.post(url, body: data);
    var responsebody = jsonDecode(response.body);
    return responsebody;
  }

  Future stopDevice(idDevice) async {
    var url = Uri.parse("http://$api/schedule/stopDevice.php");
    var data = {"idDevice": idDevice};
    var response = await http.post(url, body: data);
    var responsebody = jsonDecode(response.body);
    return responsebody;
  }

  timerRunDevice(idDevice) async {
    print("timerRunDevice");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    DateTime now = DateTime.now();
    String oo = DateFormat("yyyy-MM-dd HH").format(now).toString();
    if (oo == preferences.getString("runDevice")) {
      print("----------");
      runDevice(idDevice);
      timer1.cancel();
      timer2 = Timer.periodic(
          const Duration(minutes: 1), (Timer t) => timerStopDevice(idDevice));
      print("----------");
    }
  }

  timerStopDevice(idDevice) async {
    print("timerStopDevice");

    SharedPreferences preferences = await SharedPreferences.getInstance();

    DateTime now = DateTime.now();
    String oo = DateFormat("yyyy-MM-dd HH").format(now).toString();
    if (oo == preferences.getString("stopDevice")) {
      print("**************");
      stopDevice(idDevice);

      print("*********");
    }
  }

  Future<void> showDateTimePickerStart(idDevice) async {
    datePicked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (datePicked != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        initialTime: TimeOfDay.now(),
        context: context, //context of current state
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child ?? Container(),
          );
        },
      );
      DateTime parsedTime =
      DateFormat.jm().parse(pickedTime!.format(context).toString());
      String formattedTime = DateFormat('HH').format(parsedTime);
      if (pickedTime != null) {
        date =
            DateFormat("yyyy-MM-dd").format(datePicked!) + " " + formattedTime;
        SharedPreferences preferences = await SharedPreferences.getInstance();

        runDate = preferences.setString("runDevice", date);
        timer1 = Timer.periodic(
            const Duration(minutes: 1), (Timer t) => timerRunDevice(idDevice));
      }

      print(date);
    }
  }

  showDateTimePickerStop(idDevice) async {
    datePicked2 = await showDatePicker(
        confirmText: "تحديد وقت اطفاء الجهاز",
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (datePicked2 != null) {
      TimeOfDay? pickedTime2 = await showTimePicker(
        initialTime: TimeOfDay.now(),
        context: context, //context of current state
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child ?? Container(),
          );
        },
      );
      DateTime parsedTime =
      DateFormat.jm().parse(pickedTime2!.format(context).toString());
      String formattedTime = DateFormat('HH').format(parsedTime);
      if (pickedTime2 != null) {
        date2 =
            DateFormat("yyyy-MM-dd").format(datePicked2!) + " " + formattedTime;
        SharedPreferences preferences = await SharedPreferences.getInstance();

        stopDate = preferences.setString("stopDevice", date2);
        stopDevice(idDevice);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("تعيين أوقات"),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.blue.shade50,
        height: MediaQuery.of(context).size.height - 20,
        child: FutureBuilder(
            future: getData(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) print(snapshot.error);
              return snapshot.hasData
                  ? ListView.builder(
                  itemCount: snapshot.data.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    List list = snapshot.data;
                    return Container(
                      margin: EdgeInsets.only(top: 10),
                      color: Colors.blue.shade100,
                      height: 100,
                      width: 100,
                      child: Card(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                padding: EdgeInsets.only(top: 10),

                                color: Colors.blue.shade50,
                                height: 100,
                                //alignment: Alignment.topRight,
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: [
                                    Text("الجهاز : " + list[index]['name']),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                      children: [
                                        ElevatedButton(
                                            onPressed: () {

                                              showDateTimePickerStop(list[index]['id']);

                                            },
                                            child: Text("وقت الأطفاء")),
                                        const SizedBox(width: 5,),
                                        ElevatedButton(
                                            onPressed: () {
                                              showDateTimePickerStart(
                                                  list[index]['id']);
                                            },
                                            child: Text("وقت تشغيل")),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  })
                  : Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }
}
