import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:savvy_time/constants/design.dart';
import 'package:savvy_time/constants/network.dart';
import 'package:savvy_time/models/ListOfLocations.dart';
import 'package:savvy_time/models/Timezones.dart';
import 'package:savvy_time/services/HttpService.dart';

class AvailableLocations extends StatefulWidget {
  Timezones timezones;
  String queryLocations;
  AvailableLocations({Key? key, required this.timezones, required this.queryLocations}) : super(key: key);

  @override
  State<AvailableLocations> createState() => _AvailableLocationsState();
}

class _AvailableLocationsState extends State<AvailableLocations> {
  @override
  Widget build(BuildContext context) {
    LocationList locations = Provider.of<LocationList>(context);

    return Expanded(
        child: ListView(
      children: widget.timezones.locations.keys
          .where((element) => element.toLowerCase().contains(widget.queryLocations.toLowerCase()))
          .map(
            (String location) => ListTile(
              title: Text(
                location,
                style: TextStyle(color: mainWhite),
              ),
              onTap: () async {
                var s = await HttpService().getLocalTimes(uriTimezones + '/' + widget.timezones.locations[location]!);
                locations.addLocation(s);
                Navigator.pushNamed(context, '/');
              },
            ),
          )
          .toList(),
    ));
  }
}
