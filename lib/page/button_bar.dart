import 'package:flutter/material.dart';
import 'widght.dart';

class button_bar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Color(0xFFfcfcfc),
      elevation: 0.0,
      unselectedItemColor: Colors.black,
      selectedItemColor: Color(0xFFfc6a26),
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
          ),
          title: Text("Home"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.store),
          title: Text("Our Shop"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          title: Text("Favorite"),
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.person), title: Text("Profile")),
        BottomNavigationBarItem(
          icon: Icon(Icons.access_alarms),
          title: Text("access_alarms"),
        )
      ],
    );
  }
}
