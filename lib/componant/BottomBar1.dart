// ignore: file_names
// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:iot_switch/controllar/gps.dart';
import 'package:iot_switch/page/addButton.dart';
import 'package:iot_switch/page/log.dart';
import 'package:iot_switch/page/profile.dart';
import 'package:iot_switch/page/setting.dart';
import 'package:iot_switch/page/widght.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AnimatedBottomBarr extends StatefulWidget {
  static final String path = "lib/src/pages/animations/anim4.dart";

  @override
  _AnimatedBottomBarrState createState() => _AnimatedBottomBarrState();
}

class _AnimatedBottomBarrState extends State<AnimatedBottomBarr> {
  int? _currentPage;

  @override
  void initState() {

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
        return profile();
      case 2:
        return log();

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
                title: "لوحة",
                isActive: currentIndex == 0,
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () => onChange!(1),
              child: BottomNavItem(
                icon: Icons.person,
                title: "الحساب",
                isActive: currentIndex == 1,
              ),
            ),
          ),
          // Expanded(
          //   child: InkWell(
          //     onTap: () => onChange!(2),
          //     child: BottomNavItem(
          //       icon: Icons.pending_actions,
          //       title: "Event",
          //       isActive: currentIndex == 2,
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
                      color: activeColor ?? Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Container(
                    width: 5.0,
                    height: 5.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: activeColor ?? Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            )
          : Icon(
              icon,
              color: inactiveColor ?? Colors.grey,
            ),
    );
  }
}
