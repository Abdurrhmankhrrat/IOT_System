import 'dart:core';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_storage/get_storage.dart';

import '../api/URL.dart';



class LogIn extends StatefulWidget {
  //LogIn({Key? key}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}
Pattern pattern =
    r'^(([^<>()[\]\\.'
    r',;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|'
    r'(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\'
    r'.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
var state=true;

showloading(context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            content: Row(
              children: <Widget>[
                Text("Loading .."),
                CircularProgressIndicator(),
              ],
            ));
      });
}
showdialogall(context, String mytitle, String mycontant) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(mytitle),
          content: Text(mycontant),
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("done"))
          ],
        );
      });
}

class _LogInState extends State<LogIn> {
  TextEditingController username = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController confirmpassword = new TextEditingController();

  GlobalKey<FormState> formstatesignin = new GlobalKey<FormState>();
  GlobalKey<FormState> formstatesignup = new GlobalKey<FormState>();
  String mytoken="d9ug0K4WT6ydEU2ZdnDhxB:-tGWpeAwv4-gYZPuYXiOND3";


var val;
var check;
  savePref(String username, String email, String id,bool vall) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("id", id);
    preferences.setString("username", username);
    preferences.setString("email", email);
     //check =false;preferences.setBool("check", check);


    preferences.setBool("validity", vall);

  }



  FirebaseMessaging messaging = FirebaseMessaging.instance;

   validusername(String val) {
    if (val.trim().isEmpty) {
      return "لايمكن ان يكون الاسم فارغ";
    }
    if (val.trim().length < 4) {
      return "لايمكن ان يكون الاسم اقل من 4 محارف";
    }
    if (val.trim().length > 20) {
      return "لايمكن ان يكون الاسم اكبر من 20 محرف";
    }
  }

   validpassword(String val) {
    if (val.trim().isEmpty) {
      return "لايمكن ان تكون كلمة المرور فارغة";
    }
    if (val.trim().length < 8) {
      return "لايمكن ان تكون كلمة المرور اقل من 8 محارف";
    }
    if (val.trim().length > 20) {
      return "لايمكن ان تكون كلمة المرور اكبر من 20 محرف";
    }
  }


  validconfirmpassword(String val) {
    if (val != password.text) {
      return "كلمة المرور غير متطابقة ";
    }
  }




  validemail(String val) {
    if (val.trim().isEmpty) {
      return "لايمكن ان يكون البريد الالكتروني فارغ";
    }
    if (val.trim().length < 4) {
      return "لايمكن ان يكون البريد الالكتروني اقل من 4 محارف";
    }
    if (val.trim().length > 25) {
      return "لايمكن ان يكون البريد الالكتروني اكبر من 25 محرف";
    }
    // RegExp regex = new RegExp(pattern.toString());
    // if (!regex.hasMatch(val)) {
    //   return "عنوان البريد غير صحيح مثال (Example@gmail.com)";
    // }
    print(val);
  }
  var isSignIn = false;

  final GetStorage authBox = GetStorage();
  signin() async {
    //
    var token;
    //print(messaging.getToken());
    await messaging.getToken().then((value) {
      token = value;
      setState(() {});
    });

    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("mytoken", token);
   // print(token.toString());
    print("ؤؤؤؤؤؤؤؤؤؤؤؤؤؤؤؤؤؤؤؤؤؤؤؤؤ");
    var fordata = formstatesignin.currentState!;
    if (fordata.validate()) {
      fordata.save();
      showloading(context);
      var data = {
        'email': email.text,
        'password': password.text,
        'token': token
      };

      print("ؤؤؤؤؤؤؤؤؤؤؤؤؤؤؤؤؤؤؤؤؤؤؤؤؤ");


      var url = Uri.parse("http://$api/login.php");
      var response = await http.post(url, body: data);
      var responsebody = jsonDecode(response.body);
       print(responsebody['status']);
      if (responsebody['status'] == "success") {
        savePref(responsebody['username'], responsebody['email'],
            responsebody['id'],true );
        isSignIn = true;
        authBox.write("auth", isSignIn);

        print("ؤؤؤؤؤؤؤؤؤؤؤؤؤؤؤؤؤؤؤؤؤؤؤؤؤ");
        Navigator.pushNamedAndRemoveUntil(context, "bar",(_)=>false);

      } else {
        print('Email or password invalid');
        Navigator.of(context).pop();

        showdialogall(context, "خطأ", "البريد الالكتروني او كلمة المرور خاطئة");
      }
    } else {
      print("not valid");
    }
  }
  signinGuest() async {
    var fordata = formstatesignin.currentState!;
    if (fordata.validate()) {
      // fordata.save();
      // showloading(context);
      var data = {
        'email': email.text,
        'password': password.text,
        'token': mytoken
      };
     // Navigator.pushNamedAndRemoveUntil(context,"adduser",(_)=>false);

      var url = Uri.parse("http://$api/loginGuest.php");
      var response = await http.post(url, body: data);
      var responsebody = jsonDecode(response.body);
    //  print(responsebody['status']);
      if (responsebody['status'] == "success") {
        // savePref(responsebody['username'], responsebody['email'],
        //     responsebody['id'] ,false);
        //print(	responsebody['validity']);
        //val?
        Navigator.pushNamedAndRemoveUntil(context,"adduser",(_)=>false);
        //   :Navigator.pushNamedAndRemoveUntil(context, "bar1",(_)=>false);

      } else {
       // print('Email or password invalid');
        Navigator.of(context).pop();

        showdialogall(context, "خطأ", "البريد الالكتروني او كلمة المرور خاطئة");
      }
    } else {
    //  print("not valid");
    }
  }

  signup() async {
  //  print("sign up ");
    var fordata = formstatesignup.currentState;

    if (fordata!.validate()) {
      fordata.save();
      showloading(context);

      var data = {
        'email': email.text,
        "password": password.text,
        "username": username.text,
      };
      var url =
      Uri.parse("http://$api/signup.php");
      var response = await http.post(url, body: data);
      var responsebody = jsonDecode(response.body);
      if (responsebody['status'] == "success") {
       // print('successful');
        Navigator.of(context).pushNamed("bar");
      } else {
       // print(responsebody['status']);
        Navigator.of(context).pop();
      }
    } else {
  //    print("not valid");
    }
  }
  signupGuest() async {
   // print("sign up ");
    var fordata = formstatesignup.currentState;

    if (fordata!.validate()) {
      fordata.save();
      showloading(context);

      var data = {
        'email': email.text,
        "password": password.text,
        "username": username.text,
      };
      var url =
      Uri.parse("http://$api/signupGuest.php");
      var response = await http.post(url, body: data);
      var responsebody = jsonDecode(response.body);
      if (responsebody['status'] == "success") {
       // print('successful');print('username');print('email');print('id');
        savePref( username.text,email.text,"",false);
        Navigator.of(context).pushNamed("adduser");
      } else {
        print(responsebody['status']);
        Navigator.of(context).pop();
      }
    } else {
    //  print("not valid");
    }
  }


  TapGestureRecognizer? _changesign;
  bool showsignin = true;
  @override
  void initState() {
   /// getpref();
    _changesign = new TapGestureRecognizer()
      ..onTap = () {
        //  print("click text create Account");
        setState(() {
          showsignin = !showsignin;
         // print(showsignin);
        });
      };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mdw = MediaQuery
        .of(context)
        .size
        .width;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
            ),
            Container(
              height: 1000,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    buildContainerAvatar(mdw),
                    showsignin? buildFormBoxSignin(mdw):
                   buildFormBoxSignUp(mdw),

                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: showsignin ? 20 : 15,
                          ),
                          //height: showsignin ? 20 : 15,
                          Row(
                            children: [
                              Padding(padding: EdgeInsets.only(right: 100)),
                          RaisedButton(
                                color: showsignin
                                    ? Colors.blue[300]
                                    : Colors.lightBlue[300],
                                elevation: 10,
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                onPressed: showsignin ? signin : signup,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(right: 8),
                                    ),
                                    Text(
                                      showsignin ? "مالك" : " مالك ",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),

                                  ],
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(right: 20)),

                              RaisedButton(
                                color: showsignin
                                    ? Colors.blue[300]
                                    : Colors.lightBlue[300],

                                elevation: 10,
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                onPressed: showsignin?signinGuest:signupGuest
                                //  Navigator.of(context).pushNamed("");
                                , child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(right: 8),
                                    ),
                                    Text(" زائر ", style: TextStyle(
                                          color: Colors.white,
                                        fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: RichText(
                              text: TextSpan(children: <TextSpan>[
                                TextSpan(
                                    text: showsignin
                                        ? "ليس لديك حساب "
                                        : "لدي حساب بالفعل ",
                                    style: TextStyle(color: Colors.black)),
                                TextSpan(
                                    recognizer: _changesign,
                                    text: showsignin
                                        ? "اضغط هنا"
                                        : "تسجيل الدخول ",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.w700,
                                        decoration: TextDecoration.underline,
                                        decorationStyle:
                                        TextDecorationStyle.solid))
                              ]),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          showsignin
                              ? Directionality(
                              textDirection: TextDirection.ltr,
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(right: 10),
                                  ),

                                  Padding(
                                      padding: EdgeInsets.only(right: 10)),
                                ],
                              ))
                              : Text("")
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Center buildFormBoxSignin(double mdw) {
    return Center(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOutBack,
        //margin: EdgeInsets.only(top: 1),
        height: 240,
        width: mdw / 1.2,
        decoration: const BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              color: Colors.blue,
              spreadRadius: 5,
              blurRadius: 21,
              offset: Offset(1, 1))
        ]),
        child: Form(
            autovalidate: true,
            key: formstatesignin,
            child: Container(
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      " البريد الالكتروني ",
                      style: TextStyle(color: Colors.blue),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    buildTextFormFieldAll(
                        "ادخل البريد الالكتروني هنا", false, email,validemail(email.text)),
                    const Text(
                      " كلمة السر",
                      style: TextStyle(color: Colors.blue),
                    ),
                    buildTextFormFieldAll(
                        "ادخل كلمة السر  هنا", true, password,validpassword(password.text)),
                  ],
                ),
              ),
            )),
      ),
    );
  }
   buildFormBoxSignUp(double mdw) {
    return Column(
      children: [
        Center(
          child: AnimatedContainer(
            duration: Duration(milliseconds: 700),
            curve: Curves.easeInOutBack,
            margin: EdgeInsets.only(top: showsignin ? 40 : 20),
            height: 350,
            width: mdw / 1.2,
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  color: Colors.cyan,
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: Offset(1, 1))
            ]),
            child: Form(
                autovalidate: true,
                key: formstatesignup,
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.all(10),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          " اسم المستخدم",
                          style: TextStyle(color: Colors.blue),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        buildTextFormFieldAll("ادخل اسم المستخدم هنا", false,
                            username,validusername(username.text)),
                        Text(
                          " كلمة السر",
                          style: TextStyle(color: Colors.blue),
                        ),
                        buildTextFormFieldAll(
                            "ادخل كلمة السر  هنا", true, password,validpassword(password.text)),
                        Text(
                          "تاكيد كلمة السر",
                          style: TextStyle(color: Colors.blue),
                        ),
                        buildTextFormFieldAll("ادخل كلمة السر  هنا", true,
                          confirmpassword,validconfirmpassword(confirmpassword.text)),
                        Text(
                          "البريد الالكتروني ",
                          style: TextStyle(color: Colors.blue),
                        ),
                        buildTextFormFieldAll("ادخل البريد الالكتروني  هنا", false,
                            email,validemail(email.text)),
                      ],
                    ),
                  ),
                )),
          ),
        ),
      ],
    );
  }

  TextFormField buildTextFormFieldAll(String myhinttext, bool pass,
      TextEditingController mycontroller,myvalid) {
    return TextFormField(
      controller: mycontroller,
      obscureText: pass,
       validator: (text) => myvalid,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(4),
          hintText: myhinttext,
          filled: true,
          fillColor: Colors.grey[200],
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
                style: BorderStyle.solid,
                width: 1,
              )),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.red, style: BorderStyle.solid, width: 1))),
    );
  }

   buildContainerAvatar(double mdw) {
    return Container(
padding:showsignin? EdgeInsets.only(bottom: 300):EdgeInsets.only(bottom: 200),
     decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/11.png"),
            fit: BoxFit.scaleDown),
      ),
);
  }
}