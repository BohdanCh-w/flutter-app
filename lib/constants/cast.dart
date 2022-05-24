String getCityFromTimezone(String timezone) {
  List<String> parts = timezone.split('/');
  return parts[parts.length - 1];
}

String getContinentFromTimezone(String timezone) {
  return timezone.split('/')[0];
}

Map<int, String> WeekDay = {
  0: 'Sun',
  1: 'Mon',
  2: 'Tue',
  3: 'Wed',
  4: 'Thu',
  5: 'Fri',
  6: 'Sat'
};

Map<int, String> Month = {
  1: 'January',
  2: 'February',
  3: 'March',
  4: 'April',
  5: 'May',
  6: 'June',
  7: 'July',
  8: 'August',
  9: 'September',
  10: 'October',
  11: 'November',
  12: 'December'
};

Duration intToDuration(int num) {
  return Duration(minutes: (num - 48).abs() * 15);
}

List<String> Timeformat = ['24 Hour', '12 Hour'];
List<String> Dateformat = ['Exact', 'Relative'];
List<String> TimeAheadformat = ['UTC-offset', 'Ahead/Behind'];
