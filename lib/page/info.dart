import 'package:flutter/material.dart';
//import 'package:iot_switch/page/button_bar.dart';

class HomeSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       // bottomNavigationBar:button_bar(),
        appBar: AppBar(
          title: Text("حول"),
          backgroundColor: Colors.blueGrey[900],

        ),

        body: ListView(
          children: [
            Image.asset('assets/info.png',
                width: 600, height: 240, fit: BoxFit.fill),
            titleSection,
            _buildButtonSection,
            textSection
          ],
        ));
  }

  Widget titleSection = Container(
    padding: const EdgeInsets.all(32),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  'Abdurrhman AlKhrrat ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
      Container(padding: const EdgeInsets.only(bottom: 8),
        child: Text(
                    'Firas Alhinde ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
      ),

              Text(
                'Damascus, Syria',
                style: TextStyle(
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ),
        Icon(
          Icons.star,
          color: Colors.red[500],
        ),
        Text('100'),
      ],
    ),
  );

  Widget _buildButtonSection = Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildButtonColumn(Colors.blue, Icons.call, 'CALL'),
        _buildButtonColumn(Colors.blue, Icons.near_me, 'ROUTE'),
        _buildButtonColumn(Colors.blue, Icons.share, 'SHARE'),
      ],
    ),
  );

  static Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }

  Widget textSection = Container(
    padding: const EdgeInsets.all(32),
    child: Text(
      'IT Engenner                                                                           '
      'Web Developer And Flutter Devloper                                          '
      'Email: akhrrat@gmail.com                                                                  '
      'Mobile:  0932158475                                                          ',
      softWrap: true,
    ),
  );
}
