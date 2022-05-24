import 'dart:collection';

class Timezones {
  SplayTreeMap<String, String> locations;
  Timezones({required this.locations});

  factory Timezones.fromJson(List json) {
    SplayTreeMap<String, String> templocs = SplayTreeMap();
    json.map((e) => e.toString()).toList().forEach((timezone) {
      List<String> parts = timezone.split('/');

      if (parts.length > 1 && parts[0] != 'Etc') {
        templocs[parts[parts.length - 1].replaceAll('_', ' ')] = timezone;
      }
    });

    return Timezones(locations: templocs);
  }
}
