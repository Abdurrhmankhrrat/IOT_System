import 'package:flutter/material.dart';
import 'package:iot_switch/componant/alert.dart';
import 'package:iot_switch/controllar/SetParameter.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyPluginn extends StatefulWidget {
  @override
  _MyPluginnState createState() => _MyPluginnState();
}

class _MyPluginnState extends State<MyPluginn> {
  bool lockInBackground = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("الاعدادات"),
        backgroundColor: Colors.blueGrey[900],
        centerTitle: true,
        elevation: 6,
        // actions: <Widget>[
        //   IconButton(icon: Icon(Icons.exit_to_app), onPressed: () {}),
        // ],
      ),
      body: Directionality(textDirection: TextDirection.rtl,
        child: SettingsList(
          sections: [

            SettingsSection(
              titlePadding: EdgeInsets.all(12),
              title: 'عام',
              tiles: [
                SettingsTile(
                  title: 'اللغة',
                  subtitle: 'قريباً',
                  leading: Icon(Icons.language),
                  onTap: () {

                  },
                ),
                SettingsTile(
                    title: 'الخطة',
                    subtitle: ' التشغيل وايقاف التشغيل المجدول',
                    leading: Icon(Icons.plagiarism_rounded)
                ,onPressed:(context) {
                  Navigator.of(context).pushNamed('schedule');
                },
                ), SettingsTile(
                    title: 'الموقع',
                    subtitle: 'تحديد الموقع ',
                    leading: Icon(Icons.place)
                ,onPressed:(context) {
                      alertLocation(context);
                },
                ),

              ],
            ),
            SettingsSection(
              title: 'الحساب',
              tiles: [
                SettingsTile(title: 'حول التطبيق', leading: Icon(Icons.info),
                  onPressed: (Context){       Navigator.of(context).pushNamed('info');},),
                SettingsTile(title: 'الحساب', leading: Icon(Icons.account_circle_outlined),
                  onPressed: (Context){Navigator.of(context).pushNamed('profile');},),
                SettingsTile(title: 'تسجيل الخروج', leading: Icon(Icons.exit_to_app),
                    onPressed: (Context)async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove("username");
    preferences.remove("email");
    Navigator.of(context).pushNamed("login");
    }),
              ],
            ),
            SettingsSection(
              title: 'الأمان',
              tiles: [
                SettingsTile.switchTile(
                  title: 'قفل التطبيق',subtitle:"قريباً" ,
                  leading: Icon(Icons.phonelink_lock),
                  switchValue: lockInBackground,
                  onToggle: (bool value) {
                    setState(() {
                      lockInBackground = value;
                    });
                  },
                ),
                SettingsTile.switchTile(
                    title: 'استخدام البصمة',subtitle: "قريباً",
                    leading: Icon(Icons.fingerprint),
                    onToggle: (bool value) {},
                    switchValue: false),
                SettingsTile.switchTile(
                  title: 'تغيير كلمة المرور',subtitle: "قريباً",
                  leading: Icon(Icons.lock),
                  switchValue: true,
                  onToggle: (bool value) {},
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}