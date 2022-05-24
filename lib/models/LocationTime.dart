import 'package:flutter/material.dart';

class LocalTime {
  final Key key = UniqueKey();
  final String abbreviation;
  final DateTime datetime;
  final DateTime utc_datetime;
  final String timezone;
  final String utc_offset;
  final int day_of_week;
  final int day_of_year;
  final int week_number;
  final int unixtime;

  LocalTime({
    required this.abbreviation,
    required this.timezone,
    required this.datetime,
    required this.day_of_week,
    required this.day_of_year,
    required this.week_number,
    required this.unixtime,
    required this.utc_datetime,
    required this.utc_offset,
  });
  Key getKey() {
    return key;
  }

  LocalTime.fromJson(Map<String, dynamic> json)
      : this(
          abbreviation: json['abbreviation'] as String,
          timezone: json['timezone'] as String,
          datetime: DateTime.parse((json['datetime'] as String).split('.')[0]),
          utc_datetime: DateTime.parse((json['utc_datetime'] as String).split('.')[0]),
          utc_offset: json['utc_offset'] as String,
          day_of_week: json['day_of_week'] as int,
          day_of_year: json['day_of_week'] as int,
          week_number: json['day_of_week'] as int,
          unixtime: json['day_of_week'] as int,
        );
}
