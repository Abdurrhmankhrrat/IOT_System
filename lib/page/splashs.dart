import 'package:fancy_on_boarding/fancy_on_boarding.dart';
import 'package:flutter/material.dart';
import 'package:iot_switch/componant/color_theme.dart';

class MyHomePagee extends StatefulWidget {


  @override
  _MyHomePageStatee createState() => new _MyHomePageStatee();
}

class _MyHomePageStatee extends State<MyHomePagee >{
  //Create a list of PageModel to be set on the onBoarding Screens.
  final pageList = [
    PageModel(
        color: Colors.black54,
        heroImagePath: 'assets/22.png',
        title: Text('أهلاً بك',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Colors.white,
              fontSize: 34.0,
            )),
        body: Text('سيبدو كل شئ سهلا بعد قليل',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            )),
        iconImagePath: 'assets/on.png',),
    PageModel(
        color: const Color(0xFF65B0B4),
        heroImagePath: 'assets/on.png',
        title: Text('Banks',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Colors.white,
              fontSize: 34.0,
            )),
        body: Text(
            'We carefully verify all banks before adding them into the app',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            )),
        iconImagePath: 'assets/on.png',),
    PageModel(
      color: const Color(0xFF9B90BC),
      heroImagePath: 'assets/on.png',
      title: Text('Store',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Colors.white,
            fontSize: 34.0,
          )),
      body: Text('All local stores are categorized for your convenience',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          )),
      icon: Icon(
        Icons.shopping_cart,
        color: const Color(0xFF9B90BC),
      ),
    ),
    // SVG Pages Example
    PageModel(
        color: const Color(0xFF678FB4),
        heroImagePath:'assets/on.png',
        title: Text('Hotels SVG',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Colors.white,
              fontSize: 34.0,
            )),
        body: Text('All hotels and hostels are sorted by hospitality rating',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            )),
        iconImagePath: 'assets/on.png',
        heroImageColor: Colors.white),
    PageModel(
        color: const Color(0xFF65B0B4),
        heroImagePath: 'assets/on.png',
        title: Text('Banks SVG',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Colors.white,
              fontSize: 34.0,
            )),
        body: Text(
            'We carefully verify all banks before adding them into the app',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            )),
        iconImagePath: 'assets/on.png',
        heroImageColor: Colors.white),
    PageModel(
      color: const Color(0xFF9B90BC),
      heroImagePath: 'assets/on.png',
      title: Text('Store SVG',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Colors.white,
            fontSize: 34.0,
          )),
      body: Text('All local stores are categorized for your convenience',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          )),
      iconImagePath: 'assets/on.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Pass pageList and the mainPage route.
      body: FancyOnBoarding(
        doneButtonText: "انهاء",
        skipButtonText: "تجاوز",
        pageList: pageList,
        onDoneButtonPressed: () =>
            Navigator.of(context).pushReplacementNamed('login'),
        onSkipButtonPressed: () =>
            Navigator.of(context).pushReplacementNamed('login'),
      ),
    );
  }
}