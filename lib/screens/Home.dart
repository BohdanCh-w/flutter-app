import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:savvy_time/SecondaryWidgets/Navigation.dart';
import 'package:savvy_time/constants/cast.dart';
import 'package:savvy_time/constants/design.dart';
import 'package:savvy_time/models/ListOfLocations.dart';
import 'package:savvy_time/models/LocationTime.dart';
import 'package:savvy_time/models/SettingsModel.dart';
import 'package:savvy_time/services/Notifications.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 1;
  DateTime current = DateTime.now();
  double counter = 48;
  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    LocationList locations = Provider.of<LocationList>(context);
    SettingsModel settings = Provider.of<SettingsModel>(context);

    return Scaffold(
        backgroundColor: mainDark,
        appBar: AppBar(
          backgroundColor: mainDark,
          centerTitle: true,
          title: Text('Home', style: TextStyle(color: mainWhite)),
          automaticallyImplyLeading: false,
        ),
        body: Container(
          child: locations.length > 0
              ? Column(children: [
                  Divider(thickness: 1, color: secondaryDarkGray),
                  SizedBox(height: 5),
                  ElevatedButton(
                      style: buttonStyle,
                      onPressed: () {
                        setState(() {
                          counter = 48;
                          current = DateTime.now();
                        });
                      },
                      child: Text('Current Time', style: TextStyle(color: mainWhite))),
                  SizedBox(height: 5),
                  Expanded(
                    child: Theme(
                      data: ThemeData(canvasColor: mainDark),
                      child: ReorderableListView.builder(
                          onReorder: (oldIndex, newIndex) => {
                                setState(() {
                                  if (oldIndex < newIndex) {
                                    newIndex -= 1;
                                  }
                                  final LocalTime item = locations.removeAt(oldIndex);
                                  locations.insert(newIndex, item);
                                })
                              },
                          itemCount: locations.length,
                          itemBuilder: (BuildContext context, int index) {
                            List<int> offset = [
                              int.parse(locations.selectedLocations[index].utc_offset.substring(1, 3)),
                              int.parse(locations.selectedLocations[index].utc_offset.substring(4, 6))
                            ];
                            now = locations.selectedLocations[index].utc_offset.substring(0, 1) == '+'
                                ? current.add(Duration(hours: offset[0], minutes: offset[1]))
                                : current.subtract(Duration(hours: offset[0], minutes: offset[1]));
                            return Dismissible(
                              key: locations.selectedLocations[index].getKey(),
                              onDismissed: (direction) {
                                String timezone = locations.selectedLocations[index].timezone;

                                setState(() {
                                  locations.removeAt(index);
                                });

                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(content: Text('${getCityFromTimezone(timezone)} removed')));
                              },
                              background: Container(color: accentDarkRed),
                              child: Card(
                                color: mainDark,
                                child: Container(
                                  decoration: BoxDecoration(
                                    //color: secondaryDarkGray,
                                    border: Border.all(color: accentDarkRed, width: 2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
                                    child: Column(children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                              getCityFromTimezone(
                                                  locations.selectedLocations[index].timezone.replaceAll('_', ' ')),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500, fontSize: 24, color: mainWhite),
                                              textAlign: TextAlign.center),
                                          Text(
                                              settings.timeformat == '24 Hour'
                                                  ? '${now.hour}:${now.minute < 10 ? '0${now.minute}' : now.minute}'
                                                  : '${now.hour % 12}:${now.minute < 10 ? '0${now.minute}' : now.minute} ${now.hour >= 12 ? 'pm' : 'am'}',
                                              style: TextStyle(fontSize: 24, color: mainWhite),
                                              textAlign: TextAlign.center),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                              '${getContinentFromTimezone(locations.selectedLocations[index].timezone)} ${settings.timezone ? '| ${locations.selectedLocations[index].abbreviation}' : ''}',
                                              style: TextStyle(fontSize: 15, color: mainWhite),
                                              textAlign: TextAlign.center),
                                          Row(
                                            children: [
                                              Text(
                                                  settings.timeahead == 'Ahead/Behind'
                                                      ? (index != 0 ? locations.getTimeAheadBehind(index) + ' |' : '')
                                                      : locations.selectedLocations[index].utc_offset,
                                                  style: TextStyle(fontSize: 12, color: mainWhite)),
                                              const SizedBox(width: 5),
                                              Text(
                                                  settings.date == 'Exact'
                                                      ? '${WeekDay[now.weekday % 7]}, ${Month[now.month]} ${now.day}'
                                                      : now.day == DateTime.now().day
                                                          ? 'Today'
                                                          : now.compareTo(DateTime.now()) == 1
                                                              ? 'Tomorrow'
                                                              : 'Yesterday',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: now.day == DateTime.now().day ? mainWhite : accentRed),
                                                  textAlign: TextAlign.center),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ]),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                  Slider(
                      activeColor: accentRed,
                      inactiveColor: accentDarkRed,
                      // thumbColor: accentRed,
                      min: 0,
                      max: 96,
                      divisions: 96,
                      value: counter,
                      onChanged: (double n) {
                        setState(() {
                          counter = n;
                          current = n > 48
                              ? DateTime.now().add(intToDuration(counter.round()))
                              : DateTime.now().subtract(intToDuration(counter.round()));
                        });
                      })
                ])
              : Center(
                  child: ElevatedButton(
                      style: buttonStyle,
                      onPressed: () {
                        Navigator.pushNamed(context, '/add');
                      },
                      child: const Text('Add first time location'))),
        ),
        bottomNavigationBar: Navigation(selectedIndex: selectedIndex));
  }
}
