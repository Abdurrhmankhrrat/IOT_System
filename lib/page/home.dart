// import 'dart:async';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'dart:io';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../componant/color_theme.dart';
// import 'myDrawer.dart';
//
//
// class Home extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return HomeState();
//   }
// }
//
// class HomeState extends State<Home> {
//   static final String title = 'IOT System';
//  // bool value = false;
//  //  bool value1 = false;
//  //  bool value2 = false;
//  //  bool value3 = false;
//  //  bool value4 = false;
//  //  bool value5 = false;
//  //  bool listvalue[4] = false;
//
//   var x="";
//   late int stat;
//   bool light = false;
//   late File _file;
//   late int id ;
//   bool state = false;
//   late Timer t;
//   List<dynamic> liststate = [];
//   List<String> listpinname = [];
//   List<bool> listvalue = [false ,false,false ,false,false ,false ,false ];
//
// //////////////////////////////////
//   @override
//   void initState() {
//
//    t = Timer.periodic(Duration(seconds: 5), (Timer y) => getData());
//
//     super.initState();
//   }
//
// //////////////////get//////////////////
//
//   Future getData() async {
//     print(listpinname);
//     int how = liststate.length;
//     liststate.length = liststate.length - how;
//     int how1 = listpinname.length;
//     listpinname.length = listpinname.length - how1;
//     var url = Uri.parse("http://192.168.43.12/2/getdata.php");
//     //var response = await http.get(url);
//     var data = {"": ""};
//     var response = await http.post(url, body: data);
//     var responsebody = jsonDecode(response.body);
//     //return responsebody;
//     print('//////////////////////////////////');
//     for (int i = 0; i < responsebody.length; i++) {
//       liststate.add(responsebody[i]['state']);
//       listpinname.add(responsebody[i]['name']);
//       ////////////////////
//
//       if (liststate[i] == '0') {
//         setState(() {
//           listvalue[i] = false;
//           print(listvalue[i]);
//         });
//       }
//       else if (liststate[i]== '1') {
//         setState(() {
//           listvalue[i] = true;
//           print(listvalue[i]);
//         });
//       }
//       else {
//         print("elseeeee");
//       }
//       }
//
//
//     print("liststate is  ${liststate}");
//     print(liststate[0]);
//     print(listpinname[0]);
//     print(listpinname);
// print('//////////////////////////////////');
//
//     return responsebody;
//   }
//
//   //////////////////////////update///////////////
//   Future updateState() async {
//     /* if(stat==0){setState(() {
//       value=false;
//     }
//     );}else if(stat==1) {setState(() {value=true;});}*/
//
//     var url = Uri.parse("http://192.168.43.12/2/test.php");
//     var data = {
//       "ID": id.toString(),
//       "State": stat.toString(),
//     };
//
//     ///print(value);print(id);print("stat");print(stat);
//     var response = await http.post(url, body: data);
//   }
//
//   /////////////////end//////////////
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//
//
//     return
//       ChangeNotifierProvider(create: (context)=>Model(),
//         child:
//
//
//         Scaffold(
//        //   bottomNavigationBar:button_bar(),
//             appBar: AppBar(
//
//               title: Text("IOT System"),
//
//               actions: [
//                 IconButton(
//                     icon: Icon(Icons.add_box),
//                     onPressed: () {
//                       Navigator.of(context).pushNamed('widght');
//
//                     }),
//               ],            ),
//           drawer: MyDrawer(),
//
//             body:
//             Container(
//                 child:
//
//                 Container(
//                   color: Colors.grey[400],// padding:EdgeInsets.all(50),
//
//                   child:
//
//                   Column(children: [  Padding(padding: EdgeInsets.all(10)),
//                     Container(
//
//                         height: 80,
//                         width: 310,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(30),
//                           color:GFTheme.lightYellow,
//                         ),
//                         child: Stack(clipBehavior: Clip.none, children: [
//                           Positioned(
//                             top: 15,
//                             left: 10,
//                             child: Image(
//                               image: AssetImage(
//                                   listpinname.isNotEmpty ? 'assets/on.png' : 'assets/off.png'),
//                               fit: BoxFit.fill,
//                               height: 50,
//                             ),
//                           ),  Positioned(
//                             bottom:listpinname.isNotEmpty?10:10,
//                             left: listpinname.isNotEmpty?50:50,
//                             child: Text(
//                               "        IOT  System" + '\n${listpinname.isNotEmpty?"         Connected":"Device is not connected"} ',
//
//                               style: TextStyle(
//                                   fontSize: 23
//                               ),
//
//                             ),
//                           ),
//                         ])
//                     ),
//                     ////////////////////////////////////////////////////////////
//                     Container( padding:EdgeInsets.only(top:40 ),
//                       child: Column(
//                           children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//
//                           children: [
//                             InkWell(
//                               child: Container(
//                                 height: 110,
//                                 width: 110,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(20),
//                                   color:Colors.greenAccent,
//                                 ),
//                                 child:
//                                 Stack(clipBehavior: Clip.none, children: [
//                                   Positioned(
//                                     top: 15,
//                                     left: 10,
//                                     child: CupertinoContextMenu(
//                                       child: Image(
//                                         image: AssetImage(
//                                             listvalue[0] ? 'assets/on.png' : 'assets/off.png'),
//                                         fit: BoxFit.fill,
//                                         height: 50,
//                                       ),
//                                       actions: [
//                                         CupertinoContextMenuAction(
//                                           onPressed: () {
//                                             Navigator.of(context).pushNamed('time');
//
//                                           },
//                                           child: Text(
//                                             "1",
//                                           ),
//                                         ),
//                                         CupertinoContextMenuAction(
//                                           onPressed: () {
//                                             Navigator.of(context).pushNamed('file');
//                                           },
//                                           child: Text(
//                                             " 2",
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   Positioned(
//                                     bottom: 70,
//                                     left: 65,
//                                     child: Text(listvalue[0]?"ON":"OFF"
//                                       ,style: TextStyle(
//                                           color: listvalue[0]?Colors.blue:Colors.red
//                                       ),),
//                                   ),
//                                   Selector<Model,int>(
//                                       selector: (context,model1)=>model1.showone,
//                                       builder: (context,model,child) {
//
//                                         return Positioned(
//                                           bottom: 25,
//                                           left: 50,
//                                           child: Switch(
//                                               value: listvalue[0],
//                                               onChanged: (value) {
//                                                 setState(() => this.listvalue[0]= value);
//                                                 id = 1;
//                                                 if (value == true) {
//                                                   setState(() {
//                                                     stat = 1;
//
//                                                   });
//                                                 } else if (value == false) {
//                                                   setState(() {
//                                                     stat = 0;
//                                                   });
//                                                 }
//
//
//                                               updateState();
//                                               }),
//
//                                         );
//
//                                       } ),
//                                   Positioned(
//                                     bottom: 15,
//                                     left: 10,
//                                     child: Text(listpinname.isEmpty?"Not Connected":listpinname[0]),
//                                   ),
//                                 ]),
//                               ),
//                               // onLongPress: () {
//                               //   Navigator.of(context).pushNamed('teat');
//                               //
//                               // },
//
//                             ),
//                             const Padding(   padding:EdgeInsets.all(30),) ,
//
//                             /////////////////////////////////////////////////////////////////////////////////////////////////
//                             Container(
//                               height: 110,
//                               width: 110,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(20),
//                                 color:GFTheme.lightPeach,
//                               ),
//                               child: Stack(clipBehavior: Clip.none, children: [
//                                 // Positioned(
//                                 //     top: 5,
//                                 //     left: 80,
//                                 //     child:Icon(Icons.edit
//                                 //       ,color: Colors.black,
//                                 //       size: 20,
//                                 //
//                                 //     )
//                                 // ),
//                                 Positioned(
//                                   top: 15,
//                                   left: 10,
//                                   child: InkWell(
//                                     child: Image(
//                                       image: AssetImage(
//                                           listvalue[1]? 'assets/freezing_on.png' : 'assets/freezing_off.png' ),
//
//                                       fit: BoxFit.fill,
//                                       height: 45,
//                                     ),
//                                     onLongPress:(){
//                                       print("11111111111111111111111111111111111111111111");
//                                     Navigator.of(context).pushNamed('info');
//                                     },
//                                   ),
//                                 ),
//                                 Positioned(
//                                   bottom: 70,
//                                   left: 65,
//                                   child: Text(listvalue[1]?"ON":"OFF"
//                                     ,style: TextStyle(
//                                         color: listvalue[1]?Colors.blue:Colors.red
//                                     ),),
//                                 ),
//                                 Positioned(
//                                   bottom: 25,
//                                   left: 50,
//                                   child: Switch(
//                                       value: listvalue[1],
//                                       onChanged: (value) {
//                                         setState(() => this.listvalue[1] = value);
//                                         id = 2;
//                                         if (value == true) {
//                                           setState(() {
//                                             stat = 1;
//                                           });
//                                         } else if (value == false) {
//                                           setState(() {
//                                             stat = 0;
//                                           });
//                                         }
//
//                                         updateState();
//
//                                       }),
//
//                                 ),
//                                 Positioned(
//                                   bottom: 15,
//                                   left: 10,
//                                   child: Text(listpinname.isEmpty?"Not Connected":listpinname[1]
//                                   ),
//                                 ),
//                               ]
//                               ),
//                             ),
//                           ],),
//
//                         const Padding(  padding:EdgeInsets.all(15),) ,
//
//
// ///////////////////////////////////////////////////////////////////////////
//
//                         Row
//                           (  mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//
//                           Container(
//                             height: 110,
//                             width: 110,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(20),
//                               color:GFTheme.lightBlue,
//                             ),
//                             child: Stack(clipBehavior: Clip.none, children: [
//                               Positioned(
//                                 top: 15,
//                                 left: 10,
//                                 child: Image(
//                                   image: AssetImage(
//                                       listvalue[2] ? 'assets/on.png' : 'assets/off.png'),
//                                   fit: BoxFit.fill,
//                                   height: 50,
//                                 ),
//                               ),
//                               Positioned(
//                                 bottom: 70,
//                                 left: 65,
//                                 child: Text(  listvalue[2]?"ON":"OFF"
//                                   ,style: TextStyle(
//                                       color:   listvalue[2]?Colors.blue:Colors.red
//                                   ),),
//                               ),
//
//                               Positioned(
//                                 bottom: 25,
//                                 left: 50,
//                                 child: Switch(
//                                     value:   listvalue[2],
//                                     onChanged: (value) {
//                                       setState(() => this.  listvalue[2] = value);
//                                       id = 3;
//                                       if (value == true) {
//                                         setState(() {
//                                           stat = 1;
//                                         });
//                                       } else if (value == false) {
//                                         setState(() {
//                                           stat = 0;
//                                         });
//                                       }
//
//                                       updateState();
//
//                                     }),
//
//                               ),
//                               Positioned(
//                                 bottom: 15,
//                                 left: 10,
//                                 child: Text(
//                                   listpinname.isEmpty?"Not Connected":listpinname[2],
//
//                                 ),
//                               ),
//                             ]),
//
//
//                           ),
//                           Padding(
//                             padding:EdgeInsets.all(30),
//                           ) ,
//                           Container(
//                             height: 110,
//                             width: 110,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(20),
//                               color:GFTheme.lightPurple,
//                             ),
//                             child: Stack(clipBehavior: Clip.none, children: [
//                               Positioned(
//                                 top: 15,
//                                 left: 10,
//                                 child: Image(
//                                   image: AssetImage(
//                                       listvalue[3] ? 'assets/on.png' : 'assets/off.png'),
//                                   fit: BoxFit.fill,
//                                   height: 50,
//                                 ),
//                               ),Positioned(
//                                 bottom: 70,
//                                 left: 65,
//                                 child: Text(  listvalue[3]?"ON":"OFF"
//                                   ,style: TextStyle(
//                                       color: listvalue[3]?Colors.blue:Colors.red
//                                   ),),
//                               ),
//                               Positioned(
//                                 bottom: 25,
//                                 left: 50,
//                                 child: Switch(
//                                     value: listvalue[3],
//                                     onChanged: (value) {
//                                       setState(() => this.listvalue[3] = value);
//                                       id = 4;
//                                       if (value == true) {
//                                         setState(() {
//                                           stat = 1;
//                                         });
//                                       } else if (value == false) {
//                                         setState(() {
//                                           stat = 0;
//                                         });
//                                       }
//                                       updateState();
//
//                                     }),
//
//                               ),
//                               Positioned(
//                                 bottom: 15,
//                                 left: 10,
//                                 child: Text(
//                                   listpinname.isEmpty?"Not Connected":listpinname[3],
//
//                                 ),
//                               ),
//                             ]),
//
//
//                           ),
//                         ],),
//
//                         Padding(
//                           padding:EdgeInsets.all(15),
//                         ) ,
//                         Row(  mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Container(
//                               height: 110,
//                               width: 110,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(20),
//                                 color:GFTheme.lightYellow,
//                               ),
//                               child: Stack(clipBehavior: Clip.none, children: [
//                                 Positioned(
//                                   top: 15,
//                                   left: 10,
//                                   child: Image(
//                                     image: AssetImage(
//                                         listvalue[4]? 'assets/on.png' : 'assets/off.png'),
//                                     fit: BoxFit.fill,
//                                     height: 50,
//                                   ),
//                                 ),
//                                 Positioned(
//                                   bottom: 70,
//                                   left: 65,
//                                   child: Text(listvalue[4]?"ON":"OFF"
//                                     ,style: TextStyle(
//                                         color: listvalue[4]?Colors.blue:Colors.red
//                                     ),),
//                                 ),
//                                 Positioned(
//                                   bottom: 25,
//                                   left: 50,
//                                   child: Switch(
//                                       value: listvalue[4],
//                                       onChanged: (value) {
//                                         setState(() => this.listvalue[4] = value);
//                                         id = 5;
//                                         if (value == true) {
//                                           setState(() {
//                                             stat = 1;
//                                           });
//                                         } else if (value == false) {
//                                           setState(() {
//                                             stat = 0;
//                                           });
//                                         }
//                                         updateState();
//
//                                       }),
//
//
//                                 ),
//                                 Positioned(
//                                   bottom: 15,
//                                   left: 10,
//                                   child: Text(
//                                       listpinname.isEmpty?"Not Connected":listpinname[4]
//
//                                   ),
//                                 ),
//                               ]),
//
//
//                             ),
//
//                             Padding(
//                               padding:EdgeInsets.all(30),
//                             ) ,
//                             Container(
//                               height: 110,
//                               width: 110,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(20),
//                                 color:GFTheme.lightCerulean,
//                               ),
//                               child: Stack(clipBehavior: Clip.none, children: [
//                                 Positioned(
//                                   top: 15,
//                                   left: 10,
//                                   child: Image(
//                                     image: AssetImage(
//                                         listvalue[5] ? 'assets/on.png' : 'assets/off.png'),
//                                     fit: BoxFit.fill,
//                                     height: 50,
//                                   ),
//                                 ),
//                                 Positioned(
//                                   bottom: 70,
//                                   left: 65,
//                                   child: Text(listvalue[5]?"ON":"OFF"
//                                     ,style: TextStyle(
//                                         color: listvalue[5]?Colors.blue:Colors.red
//                                     ),),
//                                 ),
//                                 Positioned(
//                                   bottom: 25,
//                                   left: 50,
//                                   child: Switch(
//                                       value: listvalue[5],
//                                       onChanged: (value) {
//                                         setState(() => this.listvalue[5] = value);
//                                         id = 6;
//                                         if (value == true) {
//                                           setState(() {
//                                             stat = 1;
//                                           });
//                                         } else if (value == false) {
//                                           setState(() {
//                                             stat = 0;
//                                           });
//                                         }
//                                         updateState();
//
//                                       }),
//
//                                 ),
//                                 Positioned(
//                                   bottom: 15,
//                                   left: 10,
//                                   child: Text(
//                                       listpinname.isEmpty?"Not Connected": listpinname[5]
//
//                                   ),
//                                 ),
//
//
//                               ]),
//
//
//                             ),
//
//                           ],
//                         ),
//
//
//
//                       ]),
//
//                     ),
//                     // Padding(
//                     //   padding:EdgeInsets.all(30),
//                     // ) ,
//                     // Container(
//                     //
//                     //   child: FloatingActionButton(
//                     //
//                     //     onPressed: () {
//                     //       Navigator.of(context).pushNamed('info');
//                     //
//                     //     },
//                     //     child: const Icon(Icons.add),
//                     //   ),
//                     // )
//                   ]
//                   ),) ,
//             ),
//
//         ),
//       );
//
//
//
//
//   }
//
// //------------------------------------------------
//
// //----------------------------------------------------------------
// }
//
//
// class Model extends ChangeNotifier{
//   var showsomething1=1;
//   var showsomething2="Show Something";
//   get showone => showsomething1;
//   get showtwo => showsomething2;
//   String name ='welcome';
//   changeName(){
//     name='wael';
//     notifyListeners();
//   }
//   dosomething(){
//     showsomething1++;
//     notifyListeners();
//   }
//   dosomething2(){
//     if(showsomething2=="Show Something"){showsomething2='yes provider 2 ';}
//     else if (showsomething2=='yes provider 2 '){showsomething2="Show Something";}
//
//     notifyListeners();
//   }
// }
