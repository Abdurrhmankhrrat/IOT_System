// ignore: file_names
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';




class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  var username;
  var email;
  bool isSignIn = false;
  var validity=false;
  getpref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    username = preferences.getString("username");
    validity = preferences.getBool("validity")!;
    email = preferences.getString("email");
    if (username != null) {
      setState(() {
        username = preferences.getString("username");
        email = preferences.getString("email");
        isSignIn = true;
      });
    }
  }


  void initState() {
    getpref();
    super.initState();
  }




  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountEmail: isSignIn ? Text(email) : Text(""),
              accountName: isSignIn ? Text(username) : Text(""),
              currentAccountPicture: CircleAvatar(
                child: Icon(
                  Icons.person,
                ),
                backgroundColor: Colors.lightBlueAccent,
              ),
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                image: DecorationImage(
                    image: AssetImage("assets/info.png"), fit: BoxFit.cover
                  // fit: BoxFit.fill

                ),
              ),
            ),
            ListTile(
              title: Text(
                "الصفحة الرئيسية ",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              leading: Icon(
                Icons.home,
                color: Colors.lightBlueAccent,
                size: 25,
              ),
              onTap: () {
                Navigator.of(context).pushNamed('home');
              },
            ),
            ListTile(
              title: Text(
                "الاقسام ",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              leading: Icon(
                Icons.category,
                color: Colors.lightBlueAccent,
                size: 25,
              ),
              onTap: () {
                Navigator.of(context).pushNamed('widght');
              },
            ),
            validity
                ? ListTile(
              title: Text(
                "الزائرين ",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              leading: Icon(
                Icons.person_pin_rounded,
                color: Colors.lightBlueAccent,
                size: 25,
              ),
              onTap: () {
                Navigator.of(context).pushNamed('log');
              },
            )
                : SizedBox(
              height: 0,
            ),
            Divider(
              color: Colors.lightBlueAccent,
            ),
            ListTile(
              title: Text(
                "حول التطبيق ",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              leading: Icon(
                Icons.info,
                color: Colors.lightBlueAccent,
                size: 25,
              ),
              onTap: () {
                Navigator.of(context).pushNamed('info');
              },
            ),
            validity
                ? ListTile(
              title: Text(
                " سجل الاحداث ",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              leading: Icon(
                Icons.timeline
                ,
                color: Colors.lightBlueAccent,
                size: 25,
              ),
              onTap: () {
                Navigator.of(context).pushNamed('log');
              },
            )   : SizedBox(
              height: 0,
            ),
            isSignIn
                ? ListTile(
                title: Text(
                  " تسجيل الخروج ",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
                leading: Icon(
                  Icons.exit_to_app,
                  color: Colors.lightBlueAccent,
                  size: 25,
                ),
                onTap: () async {
                  SharedPreferences preferences = await SharedPreferences.getInstance();
                 preferences.remove("username");
                 preferences.remove("email");
                 Navigator.of(context).pushNamed("login");
                })
                : ListTile(
              title: Text(
                " تسجيل الدخول ",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              leading: Icon(
                Icons.person,
                color: Colors.lightBlueAccent,
                size: 25,
              ),
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(context, "login",(_)=>false);

               // Navigator.of(context).pushNamed('login');
              },
            ),
          ],
        ));
  }
}

/*
class MyDrawer extends StatelessWidget {
  var username;
  var email;
  @override
  Widget build(BuildContext context) {}
}
*/
