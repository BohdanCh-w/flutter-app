import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:savvy_time/models/ListOfLocations.dart';
import 'package:savvy_time/models/SettingsModel.dart';
import 'package:savvy_time/models/customTimer.dart';
import 'package:savvy_time/screens/NewLoaction.dart';
import 'package:savvy_time/screens/Settings.dart';
import 'package:savvy_time/screens/Home.dart';
import 'package:savvy_time/screens/Timer.dart';
import 'package:savvy_time/services/Notifications.dart';

final notifications = FlutterLocalNotificationsPlugin();
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

Map<String, WidgetBuilder> routes = {
  "/": (context) => Home(key: UniqueKey()),
  "/add": (context) => NewLocation(key: UniqueKey()),
  "/settings": (context) => Settings(key: UniqueKey()),
  "/timer": (context) => Timer(),
};

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LocationList()),
        ChangeNotifierProvider(create: (context) => SettingsModel()),
        ChangeNotifierProvider(create: (context) => CustomTimer()),
      ],
      child: MaterialApp(
        initialRoute: '/',
        routes: routes,
      ),
    );
  }
}
