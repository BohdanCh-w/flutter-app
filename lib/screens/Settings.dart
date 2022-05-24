import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:savvy_time/SecondaryWidgets/Navigation.dart';
import 'package:savvy_time/constants/design.dart';
import 'package:savvy_time/models/SettingsModel.dart';

class Settings extends StatefulWidget {
  Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  int selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    SettingsModel settings = Provider.of<SettingsModel>(context);

    return Scaffold(
        backgroundColor: mainDark,
        appBar: AppBar(
          backgroundColor: mainDark,
          centerTitle: true,
          title: Text('Settings', style: TextStyle(color: mainWhite)),
          automaticallyImplyLeading: false,
        ),
        body: Container(
            child: ListView(
          children: [
            Divider(thickness: 1, color: secondaryDarkGray),
            SizedBox(height: 5),
            ListTile(
              title: Text("Time Format", style: TextStyle(color: mainWhite)),
              trailing: Text(settings.timeformat, style: TextStyle(color: accentRed)),
              onTap: () {
                settings.changeTimeFormat();
              },
            ),
            Divider(thickness: 1, color: secondaryDarkGray),
            ListTile(
              title: Text("Date", style: TextStyle(color: mainWhite)),
              trailing: Text(settings.date, style: TextStyle(color: accentRed)),
              onTap: () {
                settings.changeDateFormat();
              },
            ),
            Divider(thickness: 1, color: secondaryDarkGray),
            ListTile(
              title: Text("Timezone abbreviation", style: TextStyle(color: mainWhite)),
              trailing: Text(settings.timezone ? 'On' : 'Off', style: TextStyle(color: accentRed)),
              onTap: () {
                settings.changeTimezone();
              },
            ),
            Divider(thickness: 1, color: secondaryDarkGray),
            ListTile(
              title: Text("Time Ahead", style: TextStyle(color: mainWhite)),
              trailing: Text(settings.timeahead, style: TextStyle(color: accentRed)),
              onTap: () {
                settings.changeTimeahead();
              },
            ),
          ],
          padding: EdgeInsets.all(10),
        )),
        bottomNavigationBar: Navigation(selectedIndex: selectedIndex));
  }
}
