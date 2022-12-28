import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:iot_switch/controllar/gps.dart';
import 'package:iot_switch/controllar/gps_controllar.dart';
import 'package:provider/provider.dart';
import 'dart:math';

import '../controllar/SetParameter.dart';
import '../componant/color_theme.dart';

class BottList extends StatelessWidget {
  var id;
  final String state;
  final name;
  final urlimage;
  final urlimage1;
  final bkcolor;
final username ;
  BottList({
    this.id,
    required this.state,
    this.name,
    this.urlimage,
    this.urlimage1,
    this.bkcolor,
    this.username,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Model(),
      child: Column(children: [

      Consumer<Model>(builder: (context, model, child) {
          model.state_parameter(state);
        // print(bkcolor.replaceAll('"', ''));
         // print(bkcolor.trim());
          //  var random = new Random();
         //  Color element;
         //  for(int i=0; i<=1 ;i++){
         //    List<Color> list=[Colors.lightBlue,Colors.red,Colors.grey,Colors.greenAccent,Colors.cyanAccent];
         //    element = list[random.nextInt(list.length)];
         // }
          var d;

          if (bkcolor=="lightBlue"){
             d = GFTheme.lightBlue;
          }
          if (bkcolor=="green"){
           d = GFTheme.green;
          }
          if (bkcolor=="lightPurple"){
           d = GFTheme.lightPurple;
          }
          if (bkcolor=="red"){
           d = GFTheme.red;
          }
          if (bkcolor=="cyan"){
           d = GFTheme.cyan;
          }
          if (bkcolor=="lightPeach"){
           d = GFTheme.lightPeach;
          }
          if (bkcolor=="lightYellow"){
           d = GFTheme.lightYellow;
          } if (bkcolor=="white2"){
           d = GFTheme.white2;
          }if (bkcolor=="labelColor"){
           d = GFTheme.labelColor;
          }if (bkcolor=="selectColor"){
           d = GFTheme.green;
          }

          return Column(
            children: [
              Container(
                height: 110,
                width: 110,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color:d,
                ),
                child: Stack(clipBehavior: Clip.none, children: [
                  Selector<Model, bool>(
                      selector: (context, model1) => model1.showone,
                      builder: (context, model, child) {
                        return Consumer<Model>(
                            builder: (context, model, child) {
                          return Positioned(
                            top: 15,
                            left: 10,
                            child: CupertinoContextMenu(
                              child: Image(
                                image: AssetImage(model.showone
                                  //  ? 'assets/on.png'
                                    ? urlimage
                                    : urlimage1),
                                fit: BoxFit.fill,
                                height: 50,
                              ),
                              actions: [
                                CupertinoContextMenuAction(
                                  onPressed: () {
                                    Navigator.of(context).pushNamed('time');
                                  },
                                  child: Text(
                                    "1",
                                  ),
                                ),
                                CupertinoContextMenuAction(
                                  onPressed: () {
                                    Navigator.of(context).pushNamed('file');
                                  },
                                  child: Text(
                                    " 2",
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                      }),

                  ///////////////////////////////////////
                  Positioned(
                    bottom: 60,
                    left: 65,
                    child: Text(
                      model.showone ? "ON" : "OFF",
                      style: TextStyle(
                          color: model.showone ? Colors.blue : Colors.red),
                    ),
                  ),

                  Consumer<Model>(builder: (context, model, child) {
                    return Positioned(
                      bottom: 20,
                      left: 50,
                      child: Switch(
                          value: model.showone,//
                          onChanged: (value) {
                            model.value_parameter(model.value, this.id,name,username); ///UpdataState

                            gps().getData(context);

                          //  model.log(name,model.showone);
                          }),
                    );
                  }),

                  Positioned(
                    bottom: 10,
                    left: 20,
                    child: Text("${name}",textDirection: TextDirection.ltr,),
                  ),
                  Positioned(
                    bottom: 80,
                    left: 75,
                    child: InkWell(child: Icon(Icons.settings,)
                    ,onTap: (){
                        Navigator.of(context).pushNamed("editButton");
                       model.dosomething(this.id);
                      },
                    ),
                  ),
                  // Positioned(
                  //   bottom: 15,
                  //   left: 50,
                  //   child: Text(""),
                  // ),
                ]),
              ),
            ],
          );
        }),
      ]),
    );

    //end list
  }

}
