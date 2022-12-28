// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenerateQRPage extends StatefulWidget {

  @override
  _GenerateQRPageState createState() => _GenerateQRPageState();
}

class _GenerateQRPageState extends State<GenerateQRPage> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Center(child: Text("الرقم التسلسلي")),// Text('Serial Number'),
        backgroundColor: Colors.blueGrey[900],

      ),
      body:
      Center(
        child: SingleChildScrollView(
          child:
        Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                QrImage(
                  data: "3165465",//controller.text,
                  size: 300,
                  embeddedImage: AssetImage('assets/1.png'),
                  embeddedImageStyle: QrEmbeddedImageStyle(
                      size: Size(80,80)
                  ),
                ),

                //
                // Container(
                //   margin: EdgeInsets.all(20),
                //   child: TextField(
                //     controller: controller,
                //     decoration: InputDecoration(
                //         border: OutlineInputBorder(), labelText: 'Enter Name'),
                //   ),
                // ),
                // ElevatedButton(
                //     onPressed: () {
                //       setState(() {
                //
                //       });
                //     },
                //     child: Text('GENERATE QR')),


              ],
            ),
          ),
        ),
      ),
    );
  }
}