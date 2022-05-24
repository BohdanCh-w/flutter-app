import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:savvy_time/SecondaryWidgets/Navigation.dart';
import 'package:savvy_time/constants/design.dart';
import 'package:savvy_time/models/customTimer.dart';
import 'package:savvy_time/services/Notifications.dart';

class Timer extends StatefulWidget {
  Timer({Key? key}) : super(key: key);

  @override
  State<Timer> createState() => _TimerState();
}

class _TimerState extends State<Timer> {
  bool notify = true;

  @override
  Widget build(BuildContext context) {
    CustomTimer timer = Provider.of<CustomTimer>(context);

    return Scaffold(
        backgroundColor: mainDark,
        appBar: AppBar(
          backgroundColor: mainDark,
          centerTitle: true,
          title: Text('Timer', style: TextStyle(color: mainWhite)),
          automaticallyImplyLeading: false,
        ),
        body: Column(
            children: timer.cancel
                ? [
                    Divider(thickness: 1, color: secondaryDarkGray),
                    Expanded(
                      child: Center(
                        child: CupertinoTimerPicker(
                          backgroundColor: mainWhite,
                          mode: CupertinoTimerPickerMode.ms,
                          onTimerDurationChanged: (value) {
                            setState(() {
                              timer.setTime = value;
                            });
                          },
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        timer.start();
                      },
                      child: Text('Start', style: TextStyle(color: mainWhite, fontSize: 16)),
                      style: buttonStyle.copyWith(
                          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.fromLTRB(35, 15, 35, 15))),
                    )
                  ]
                : [
                    Divider(thickness: 1, color: secondaryDarkGray),
                    Expanded(
                      child: Center(
                        child: Container(
                          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                            Text(
                              timer.time.inMinutes.toString() + ':',
                              style: TextStyle(fontSize: 32, color: mainWhite),
                            ),
                            Text(
                              (timer.time.inSeconds - timer.time.inMinutes * 60 < 10
                                  ? '0' + (timer.time.inSeconds - timer.time.inMinutes * 60).toString()
                                  : (timer.time.inSeconds - timer.time.inMinutes * 60).toString()),
                              style: TextStyle(fontSize: 32, color: mainWhite),
                            )
                          ]),
                          color: accentDarkRed,
                        ),
                      ),
                    ),
                    ElevatedButton(
                        style: buttonStyle.copyWith(
                            padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.fromLTRB(35, 15, 35, 15))),
                        onPressed: () {
                          timer.cancel = true;
                        },
                        child: Text('Stop', style: TextStyle(color: mainWhite, fontSize: 16))),
                  ]
            //fromLTRB
            ),
        bottomNavigationBar: Navigation(selectedIndex: 3));
  }
}
