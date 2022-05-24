import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:savvy_time/SecondaryWidgets/Navigation.dart';
import 'package:savvy_time/constants/design.dart';
import 'package:savvy_time/models/ListOfLocations.dart';
import 'package:savvy_time/models/Timezones.dart';
import 'package:savvy_time/screens/AvailableLocations.dart';
import 'package:savvy_time/services/HttpService.dart';

class NewLocation extends StatefulWidget {
  NewLocation({Key? key}) : super(key: key);

  @override
  State<NewLocation> createState() => _NewLocationState();
}

class _NewLocationState extends State<NewLocation> {
  int selectedIndex = 0;

  HttpService httpService = HttpService();
  String queryLocations = '';
  @override
  Widget build(BuildContext context) {
    LocationList locations = Provider.of<LocationList>(context);
    return Scaffold(
        backgroundColor: mainDark,
        appBar: AppBar(
          backgroundColor: mainDark,
          centerTitle: true,
          title: Text(
            'Add location',
            style: TextStyle(color: mainWhite),
          ),
          automaticallyImplyLeading: false,
        ),
        body: FutureBuilder(
          future: httpService.getTimezones(),
          builder: (BuildContext context, AsyncSnapshot<Timezones> snapshot) {
            if (snapshot.hasData) {
              Timezones timezones = snapshot.data!;
              return Column(children: [
                Divider(thickness: 1, color: secondaryDarkGray),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: TextField(
                    style: TextStyle(color: mainWhite),
                    decoration: InputDecoration(
                        hintStyle: TextStyle(color: accentRed),
                        hintText: 'Enter city name',
                        contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: secondaryGray, width: 2.0)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: accentDarkRed, width: 2.0))),
                    onChanged: (String query) {
                      setState(() {
                        queryLocations = query;
                      });
                    },
                  ),
                ),
                AvailableLocations(timezones: timezones, queryLocations: queryLocations)
              ]);
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
        bottomNavigationBar: Navigation(selectedIndex: selectedIndex));
  }
}
