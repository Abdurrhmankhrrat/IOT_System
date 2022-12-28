import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class profile extends StatefulWidget {
  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile> {
  var username;
  var email;
  bool isSignIn = false;

  getpref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    username = preferences.getString("username");

    email = preferences.getString("email");
    print(username);
    print(email);
    if (username != null) {
      setState(() {
        isSignIn = true;
      });
    }
  }

  @override
  void initState() {
    getpref();
    // TODO: implement initState
    super.initState();
  }

  DateTime? _selectedDate;
  DateTime _initialDate = DateTime.now();
  DateTime date = DateTime.now();

//  TextEditingController date = TextEditingController(text: '16/10/1996');
//  TextEditingController name = TextEditingController(text: 'saeed abdullah');

  // TextEditingController email = TextEditingController(text: 'saeedabdullah17@gmail.com');
 TextEditingController phone = TextEditingController(text: '0096771666');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("الملف الشخصي             ")),
        backgroundColor: Colors.blueGrey[900],            centerTitle: true,

      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Stack(
                children: [
                  //Center(child: Image(image: AssetImage('assets/11.png'))),
                  Container(
                    child: Center(
                      child: Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 50),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Container(
                                width: 200.0,
                                height: 200.0,
                                decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: Image.asset('assets/face.png'),
                              ),
                            ),
                          ),
                          Container(
                            width: 200,
                            height: 250,
                            alignment: Alignment.bottomRight,
                            child: InkWell(
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.indigoAccent,
                                size: 50,
                              ),
                              onTap: () async {
                                await showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          content: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              IconButton(
                                                  onPressed: () async {
                                                    await openCamera();
                                                    Navigator.pop(context);
                                                  },
                                                  icon: Icon(Icons.camera_alt)),
                                              IconButton(
                                                  onPressed: () async {
                                                    await openGallery();
                                                    Navigator.pop(context);
                                                  },
                                                  icon: Icon(Icons.image)),
                                            ],
                                          ),
                                        ));
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),


                    Center(

                      child: InkWell(
                        onTap: ()async{
                          await showDialog(context: context, builder: (context)=>AlertDialog(
                            content: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                IconButton(onPressed: ()async{
                                  await openCamera();
                                  Navigator.pop(context);
                                  },
                                    icon: Icon(Icons.camera_alt)),
                                IconButton(onPressed: ()async{
                                  await openGallery();
                                  Navigator.pop(context);
                                }, icon: Icon(Icons.image)),
                              ],
                            ),
                          ));
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 50),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Container(
                                width: 200.0,
                                height: 200.0,
                                decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                ),
                              //child: (path != null) ? Image.file(path ?? File('')) : Image.asset('assest/images/main.png'),
                            ),
                          ),
                        ),
                      ),
                    ),

                ],
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      username,
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      onPressed: () async {
                        await showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                                  title: Text('Name'),
                                  content: TextField(
                                    controller: username,
                                  ),
                                  actions: [
                                    InkWell(
                                      child: Text('Save'),
                                      onTap: () => Navigator.pop(
                                        context,
                                      ),
                                    )
                                  ],
                                ));
                        setState(() {});
                      },
                      icon: Icon(Icons.edit),
                    )
                  ],
                ),
              ),
              Directionality(textDirection: TextDirection.rtl,
                child: Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Icon(
                              Icons.phone,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'الرقم',
                                  style: TextStyle(
                                    fontSize: 22,
                                  ),
                                ),
                                Text(
                                  "09XXXXXXXX",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black12),
                                )
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              await showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                        title: Text('الرقم'),
                                        content: TextField(
                                          keyboardType: TextInputType.number,
                                          controller: phone,
                                        ),
                                        actions: [
                                          InkWell(
                                            child: Text('Save'),
                                            onTap: () => Navigator.pop(
                                              context,
                                            ),
                                          )
                                        ],
                                      ));
                              setState(() {});
                            },
                            icon: Icon(Icons.edit),
                          )
                        ],
                      ),
                      Divider(),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Icon(
                              Icons.email,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'البريد',
                                  style: TextStyle(
                                    fontSize: 22,
                                  ),
                                ),
                                Text(
                                  email,
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black12),
                                )
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              await showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                        title: Text('البريد'),
                                        content: TextField(
                                          controller: email,
                                        ),
                                        actions: [
                                          InkWell(
                                            child: Text('Save'),
                                            onTap: () => Navigator.pop(
                                              context,
                                            ),
                                          )
                                        ],
                                      ));
                              setState(() {});
                            },
                            icon: Icon(Icons.edit),
                          )
                        ],
                      ),
                      Divider(),
                      SizedBox(
                        height: 20,
                      ),

                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

openCamera() async {
  //path = File(image?.path ?? '');
}

openGallery() async {}
