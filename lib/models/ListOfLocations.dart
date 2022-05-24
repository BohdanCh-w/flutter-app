import 'package:flutter/material.dart';
import 'package:savvy_time/models/LocationTime.dart';

class LocationList extends ChangeNotifier {
  List<LocalTime> _selectedLocations = [];
  List<LocalTime> get selectedLocations {
    return _selectedLocations;
  }

  set selectedLocations(List<LocalTime> newList) {
    _selectedLocations = newList;
  }

  int get length {
    return _selectedLocations.length;
  }

  double _getOffsetOf(int index) {
    double temp = double.parse(_selectedLocations[index].utc_offset.substring(1, 3));

    if (double.parse(_selectedLocations[index].utc_offset.substring(4, 6)) > 0) {
      temp += double.parse(_selectedLocations[index].utc_offset.substring(4, 6)) / 60;
    }

    if (_selectedLocations[index].utc_offset.substring(0, 1) == '-') {
      temp *= -1;
    }

    return temp;
  }

  String getTimeAheadBehind(int index) {
    String str = '';
    double offset1 = _getOffsetOf(0);
    double offset2 = _getOffsetOf(index);
    offset2 -= offset1;

    List<String> s = offset2.toString().split('.');

    if (offset2 > 0) str += '+';
    str += s[0] + ':';

    int.parse(s[1]) == 0 ? str += '00' : str += (int.parse(s[1]) * 6).toString();

    return str;
  }

  void addLocation(LocalTime newLocation) {
    _selectedLocations.add(newLocation);
    notifyListeners();
  }

  void removeLocation(String timezone) {
    _selectedLocations.removeWhere((element) => element.timezone == timezone);
    notifyListeners();
  }

  LocalTime removeAt(int index) {
    LocalTime s = _selectedLocations.removeAt(index);
    notifyListeners();
    return s;
  }

  void insert(int index, LocalTime item) {
    _selectedLocations.insert(index, item);
    notifyListeners();
  }
}
