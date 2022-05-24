import 'dart:convert';
import 'package:http/http.dart';
import 'package:savvy_time/constants/network.dart';
import 'package:savvy_time/models/LocationTime.dart';
import 'package:savvy_time/models/Timezones.dart';

class HttpService {
  Future<LocalTime> getLocalTimes(String url) async {
    Response res = await get(Uri.parse(url));

    if (res.statusCode == 200) {
      final body = jsonDecode(res.body);
      LocalTime local = LocalTime.fromJson(body);
      return local;
    } else {
      throw "Unable to retrieve posts.";
    }
  }

  Future<Timezones> getTimezones() async {
    Response res = await get(Uri.parse(uriTimezones));

    if (res.statusCode == 200) {
      final body = jsonDecode(res.body);
      Timezones timezones = Timezones.fromJson(body);
      return timezones;
    } else {
      throw "Unable to retrieve posts.";
    }
  }
}
