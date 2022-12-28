// ignore: file_names
// ignore_for_file: file_names
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:iot_switch/componant/notification.dart';
// import 'package:iot_switch/componant/notification.dart';
import 'package:iot_switch/controllar/gps.dart';
import 'package:iot_switch/page/ContantRequest.dart';
import 'package:iot_switch/page/addButton.dart';
import 'package:iot_switch/page/adduser1.dart';
import 'package:iot_switch/page/log.dart';
import 'package:iot_switch/page/schedule.dart';
import 'package:iot_switch/page/setting.dart';
import 'package:iot_switch/page/widght.dart';
import '../page/Qr_gnerator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AnimatedBottomBar extends StatefulWidget {
  static final String path = "lib/src/pages/animations/anim4.dart";

  @override
  _AnimatedBottomBarState createState() => _AnimatedBottomBarState();
}

class _AnimatedBottomBarState extends State<AnimatedBottomBar> {
  int? _currentPage;


        @override
        void initState() {
      gps().getPirmission();
      // gps().locationUser();
      // gps().getpref(context);//
      // gps_page
      NotificationBaraa.requestPermission();
      NotificationBaraa.loadFCM();
      NotificationBaraa.listenFCM();
gps().getData(context);
      _currentPage = 0;
      super.initState();
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.grey.shade300,
      body: getPage(_currentPage),
      bottomNavigationBar: AnimatedBottomNav(
          currentIndex: _currentPage,
          onChange: (index) {
            setState(() {
              _currentPage = index;
            });
          }),
    );
  }

  getPage(int? page) {
    switch (page) {
      case 0:
        return widghtt();
      case 1:
        return GenerateQRPage();
      case 2:
        return log();
      case 3:
        return addButton();
      case 4:
        return MyPluginn();
      case 5:
      //return schedule();
      return Request();
      case 6:
      //return schedule();
      return Schedule();
    }
  }
}

class AnimatedBottomNav extends StatelessWidget {
  final int? currentIndex;
  final Function(int)? onChange;


  const AnimatedBottomNav({Key? key, this.currentIndex, this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight,
      decoration: BoxDecoration(color: Colors.white),
      child: Row(
        children: <Widget>[
          Expanded(
            child: InkWell(
              onTap: () => onChange!(0),
              child: BottomNavItem(
                icon: Icons.home,
                title:"التحكم",// "Home",
                isActive: currentIndex == 0,
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () => onChange!(1),
              child: BottomNavItem(
                icon: Icons.qr_code,
                title: "الكود",//"QR",
                isActive: currentIndex == 1,
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () => onChange!(2),
              child: BottomNavItem(
                icon: Icons.event_note,
                title: "سجل",//"Event",
                isActive: currentIndex == 2,
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () => onChange!(3),
              child: BottomNavItem(
                icon: Icons.add_circle_outline,
                title: "إضافة",//"Add",
                isActive: currentIndex == 3,
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () => onChange!(4),
              child: BottomNavItem(
                icon: Icons.settings,
                title: "الاعداد",//"Seting",
                isActive: currentIndex == 4,
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () => onChange!(5),
              child: BottomNavItem(
                icon: Icons.person_add,
                title:"الطلبات",// "Plan",
                isActive: currentIndex == 5,
              ),
            ),
          ),
          // Expanded(
          //   child: InkWell(
          //     onTap: () => onChange!(6),
          //     child: BottomNavItem(
          //       icon: Icons.pending_actions,
          //       title:"خطة",// "Plan",
          //       isActive: currentIndex == 6,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

class BottomNavItem extends StatelessWidget {
  final bool isActive;
  final IconData? icon;
  final Color? activeColor;
  final Color? inactiveColor;
  final String? title;

  const BottomNavItem(
      {Key? key,
      this.isActive = false,
      this.icon,
      this.activeColor,
      this.inactiveColor,
      this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      transitionBuilder: (child, animation) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, 1.0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
      duration: Duration(milliseconds: 500),
      reverseDuration: Duration(milliseconds: 200),
      child: isActive
          ? Container(
              color: Colors.white,
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    title!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color:Colors.blue// activeColor ?? Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Container(
                    width: 5.0,
                    height: 5.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:Colors.blue //activeColor ?? Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            )
          : Icon(
              icon,
              color: inactiveColor ?? Colors.blueGrey,
            ),
    );
  }
}

