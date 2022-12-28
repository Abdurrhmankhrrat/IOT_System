
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


class LogList extends StatelessWidget {
  var id;
  final String state;
  final name;
  final action;
  final user;

  LogList({this.id, required this.state, this.name, this.action, this.user});



  @override
  Widget build(BuildContext context) {
    //print( action.toString().split("."));
    var s = action.toString().split(" ");
    var m = s[1].split(".");

    return Column(
      children: [
        Row(children: [
          Padding(padding: EdgeInsets.all(10)),
          Container(
            child: Column(
              children: [
                //  Text("${s[0]}${m[0]}${m[2]}${name}${state}")
                Text("${s[0]}")
              ],
            ),
          ),
          Padding(padding: EdgeInsets.all(7)),
          Container(
            child: Column(
              children: [
                //  Text("${s[0]}${m[0]}${m[2]}${name}${state}")
                Text("${m[0]}")
              ],
            ),
          ),
          Padding(padding: EdgeInsets.all(7)),
          Container(
            child: Column(
              children: [
                //  Text("${s[0]}${m[0]}${m[2]}${name}${state}")
                Text("$name")
              ],
            ),
          ),
          Padding(padding: EdgeInsets.all(7)),
          Container(
            child: Column(
              children: [
                //  Text("${s[0]}${m[0]}${m[2]}${name}${state}")
                Text("$state")
              ],
            ),
          ),
          Padding(padding: EdgeInsets.all(7)),
          Container(
            child: Column(
              children: [
                //  Text("${s[0]}${m[0]}${m[2]}${name}${state}")
                Text("$user")
              ],
            ),
          ),
        ]),
        Divider(
          color: Colors.grey[800],
          thickness: 0.4,
        )
      ],
    ) ;
// DataTable(dataRowHeight: 50,columnSpacing: 3,showBottomBorder: true,
//     columns: [
//
//   DataColumn(label:  Text("" ),),
//   DataColumn(label:  Text(" " ),),
//   DataColumn(label:  Text(" " ),),
//   DataColumn(label:  Text(" " ),),
//
//
// ],
//
//  rows: [
//   DataRow(cells:[
//     DataCell(Text("")),
//     DataCell(Text("")),
//     DataCell(Text("")),
//     DataCell(Text("")),
//
//   ]
//   ),
// DataRow(cells: [
//   DataCell(Text(" ${s[0]}")),
//   DataCell(Text(" ${m[0]}")),
//    DataCell(Text(" ${state}")),
//
//   DataCell(Text(" ${name}")),
// ])
// ])

    //end list
  }
}
