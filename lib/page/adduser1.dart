import 'dart:async';
import 'dart:convert';
import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:iot_switch/api/URL.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);
  @override
  _AddUserState createState() => _AddUserState();
}
class _AddUserState extends State<AddUser> {
  ScanResult? scanResult;

  final _flashOnController = TextEditingController(text: 'Flash on');
  final _flashOffController = TextEditingController(text: 'Flash off');
  final _cancelController = TextEditingController(text: 'Cancel');
  var language =true;
  var _aspectTolerance = 0.00;
  var _numberOfCameras = 0;
  var _selectedCamera = -1;
  var _useAutoFocus = true;
  var _autoEnableFlash = false;
  var username;
  var email;
var val;
  static final _possibleFormats = BarcodeFormat.values.toList()
    ..removeWhere((e) => e == BarcodeFormat.unknown);

  List<BarcodeFormat> selectedFormats = [..._possibleFormats];
  getGuestInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    username = preferences.getString("username");
    email = preferences.getString("email") ;


    if (username != null) {
      setState(() {
        username = preferences.getString("username") ;
        email = preferences.getString("email") ;
       // isSignIn = true;
      }); print("/*/*/*/*/*/*/*/*/*/*/*/*/*/**/*/*/*/*/*/*");
      print(email);
      print("/*/*/*/*/*/*/*/*/*/*/*/*/*/**/*/*/*/*/*/*");
    }
  }



  Future getval() async {
    var url = Uri.parse("http://$api/getVal.php");
    //var response = await http.get(url);
    // var data = {"": ""};
    var response = await http.get(url);
    var responsebody = jsonDecode(response.body);
  //   for (int i = 0; i < responsebody.length; i++) {
  //
  // if( responsebody[i]['email']==email){
  //
  //   if(responsebody[i]['validity']=='false') {
  //     val=false;
  //
  //   }else if(responsebody[i]['validity']=='true') {
  //     val=true;}
  //
  // }
  //   }
    setState(() {});

    return responsebody;
  }

  Future checkpassed() async {
  var url = Uri.parse("http://$api/checkpassed.php");
  //var response = await http.get(url);
    // var data = {"": ""};
    var response = await http.get(url);
    var responsebody = jsonDecode(response.body);
    for (int i = 0; i < responsebody.length; i++) {
      print("++++++++++++++++++++ ") ;
      // print(responsebody[i]['board_id']);
      // print(responsebody[i]['serial_number']);
      // print(responsebody[i]['validity']);
      if(responsebody[i]['email']==email ) {
      if(responsebody[i]['validity']=='true' ) {
if (responsebody[i]['board_id']=='9'){
//  Navigator.of(context).pushNamed('bar1');
  Navigator.pushNamedAndRemoveUntil(context, "bar1",(_)=>false);

}
    }}
      else if(responsebody[i]['validity']=='false') {

    }
    }
    setState(() {});
//print(val);
    return responsebody;
  }
   late Timer t;

  @override
  void initState() {
   // t = Timer.periodic(Duration(seconds: 5), (Timer y) => checkpassed());

  getGuestInfo();
  getval();

  //checkpassed();
    super.initState();

    Future.delayed(Duration.zero, () async {
      _numberOfCameras = await BarcodeScanner.numberOfCameras;
      setState(() {});
    });
  }


  
  @override
  Widget build(BuildContext context) {
    final scanResult = this.scanResult;
    return  Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey[900],
          centerTitle: true,

          title: const Text('معلومات الجهاز'),
          actions: [
            IconButton(
              icon: const Icon(Icons.camera),
              tooltip: 'Scan',
              onPressed: _scan,

            )
          ],
        ),
        body:  Center(
          child: Directionality(
            textDirection:language? TextDirection.rtl:TextDirection.ltr
            ,child:

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text("مرحباً $username "),
                Text("انت على بعد خطوة واحدة من التسجيل",style: TextStyle(color: Colors.red),),
                Row(
                  children: [
                    Text("  الخطوات:"),
                  ],
                ),
                Row(
                  children: [
                    Text("1. قم بمسح الرقم التسلسلي للوصول للوحة التحكم الخاصة بك.",),
                  ],
                ),
                Row(
                  children: [
                    Text("2. للحصول على الرقم التسلسلي قم بالتواصل مع صاحب المنزل\n او المكتب او .. "),
                  ],
                ),
                Row(
                  children: [
                    Text("3. اضغط على مسح الرمز لمسح الرمز من الهاتف المقابل. "),
                  ],
                ),

                OutlineButton	(onPressed:_scan, child: Text("مسح الرمز"),color: Colors.blueGrey,
                  highlightColor: Colors.blueGrey,
                  splashColor: Colors.blue,
                  borderSide: BorderSide(width: 1,color: Colors.black) ,
                ),
Padding(padding: EdgeInsets.all(10)),
                     if (scanResult != null)
                        Card(
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                title: const Text('الرقم التسلسلي'),
                                subtitle: Text(scanResult.rawContent),
                              ),
                              ListTile(
                                title: const Text('الحالة'),
                                subtitle: Text("في انتظار موافقة المالك ..."),
                              ),
                              OutlineButton	(onPressed:_request, child: Text("طلب موافقة "),color: Colors.blueGrey,
                                highlightColor: Colors.blueGrey,
                                splashColor: Colors.blue,
                                borderSide: BorderSide(width: 1,color: Colors.black) ,
                              ),



                              // ListTile(
                              //   title: const Text('Format note'),
                              //   subtitle: Text(scanResult.formatNote),
                              // ),
                            ],
                          ),
                        ),
              ],
            ),

          ),),
        )


    );
  }


  Future<void> _scan() async {
    try {
      final result = await BarcodeScanner.scan(
        options: ScanOptions(
          strings: {
            'cancel': _cancelController.text,
            'flash_on': _flashOnController.text,
            'flash_off': _flashOffController.text,
          },
          restrictFormat: selectedFormats,
          useCamera: _selectedCamera,
          autoEnableFlash: _autoEnableFlash,
          android: AndroidOptions(
            aspectTolerance: _aspectTolerance,
            useAutoFocus: _useAutoFocus,
          ),
        ),

      );
      setState(() => scanResult = result);
    } on PlatformException catch (e) {
      setState(() {
        scanResult = ScanResult(
          type: ResultType.Error,
          format: BarcodeFormat.unknown,
          rawContent: e.code == BarcodeScanner.cameraAccessDenied
              ? 'The user did not grant the camera permission!'
              : 'Unknown error: $e',
        );
      });

    }
  }

  Future getData() async {
    var url = Uri.parse("http://$api/getdata.php");
    //var response = await http.get(url);
    // var data = {"": ""};
    var response = await http.get(url);
    var responsebody = jsonDecode(response.body);
    setState(() {});

    return responsebody;
  }

  Future<void>  _request()async{
    checkpassed();
   // getGuestInfo();
  //  getval();
    UpdateSn(email,scanResult!.rawContent);
   // print("ddsc${scanResult!.rawContent}${username.toString()}");
  }
}


Future UpdateSn(String email,String sn) async {
  var url = Uri.parse("http://$api/updataSN.php");
  var data = {
    "email":email ,
    "SN":sn,
  };
  var response = await http.post(url, body: data);
  print(email);
  print(sn);
  //Navigator.of(context).pushNamed("widght");

//  Navigator.of(context).pop();
}
