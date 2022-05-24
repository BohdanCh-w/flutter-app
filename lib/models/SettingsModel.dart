import 'package:flutter/material.dart';
import 'package:savvy_time/constants/cast.dart';

class SettingsModel extends ChangeNotifier {
  String _timeFormat = Timeformat[0];
  String _date = Dateformat[0];
  bool _timezone = false;
  String _timeahead = TimeAheadformat[0];

  int date_ = 0;
  int timeahead_ = 0;
  bool timezone_ = true;
  int timeformat_ = 0;

  void changeDateFormat() {
    date_++ % Dateformat.length;
    _setDate(date_);
  }

  void changeTimeahead() {
    timeahead_++ % TimeAheadformat.length;
    _setTimeahead(timeahead_);
  }

  void changeTimezone() {
    timezone_ = !timezone;
    _setTimezone(timezone_);
  }

  void changeTimeFormat() {
    timeformat_++ % Timeformat.length;
    _setTimeformat(timeformat_);
  }

  String get timeformat {
    return _timeFormat;
  }

  String get date {
    return _date;
  }

  bool get timezone {
    return _timezone;
  }

  String get timeahead {
    return _timeahead;
  }

  void _setTimeformat(int number) {
    _timeFormat = Timeformat[number % Timeformat.length];
    notifyListeners();
  }

  void _setDate(int number) {
    _date = Dateformat[number % Dateformat.length];
    notifyListeners();
  }

  void _setTimezone(bool timezone) {
    _timezone = timezone;
    notifyListeners();
  }

  void _setTimeahead(int number) {
    _timeahead = TimeAheadformat[number % TimeAheadformat.length];
    notifyListeners();
  }
}
