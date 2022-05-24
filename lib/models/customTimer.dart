import 'dart:async';

import 'package:flutter/material.dart';
import 'package:savvy_time/services/Notifications.dart';

class CustomTimer extends ChangeNotifier {
  Duration time = Duration.zero;
  bool _cancel = true;

  Duration get getTime {
    return time;
  }

  bool get cancel {
    return _cancel;
  }

  set cancel(bool cancel) {
    _cancel = cancel;
    notifyListeners();
  }

  set setTime(Duration customTime) {
    time = customTime;
    notifyListeners();
  }

  void start() {
    cancel = false;
    Timer timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (time > Duration.zero && !_cancel) {
        time -= Duration(seconds: 1);
      } else {
        timer.cancel();
        cancel = true;
        Notifications.showNotifications(title: 'Timer', body: 'Time`s up', payload: 'timer.abs');
      }
      notifyListeners();
    });
  }
}
