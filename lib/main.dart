// ignore_for_file: prefer_const_constructors

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import 'home.dart';
import 'patrios.dart';
import 'journey.dart';

void main() {
  runApp(const CellzM3());
}

class CellzM3 extends StatefulWidget {
  const CellzM3({super.key});

  @override
  State<CellzM3> createState() => _CellzM3State();
}

// NavigationRail shows if the screen width is greater or equal to
// screenWidthThreshold; otherwise, NavigationBar is used for navigation.
const double narrowScreenWidthThreshold = 450;

const Color m3BaseColor = Color(0xff6750a4);
const List<Color> colorOptions = [
  m3BaseColor,
  Colors.blue,
  Colors.teal,
  Colors.green,
  Colors.amber,
  Colors.orange,
  Colors.pink
];
const List<String> colorText = <String>[
  "M3 Baseline",
  "Blue",
  "Teal",
  "Green",
  "Yellow",
  "Orange",
  "Pink",
];

class _CellzM3State extends State<CellzM3> {
  bool useMaterial3 = true;
  bool useLightMode = true;
  int colorSelected = 0;
  int screenIndex = 0;

  late ThemeData themeData;

  @override
  initState() {
    super.initState();
    themeData = updateThemes(colorSelected, useMaterial3, useLightMode);
  }

  ThemeData updateThemes(int colorIndex, bool useMaterial3, bool useLightMode) {
    return ThemeData(
        colorSchemeSeed: colorOptions[colorSelected],
        useMaterial3: useMaterial3,
        brightness: useLightMode ? Brightness.light : Brightness.dark);
  }

  var openedScreen;
  void handleScreenChanged(int selectedScreen) {
    setState(() {
      screenIndex = selectedScreen;
      openedScreen = selectedScreen;
    });
  }

  void handleBrightnessChange() {
    setState(() {
      useLightMode = !useLightMode;
      themeData = updateThemes(colorSelected, useMaterial3, useLightMode);
    });
  }

  void handleMaterialVersionChange() {
    setState(() {
      useMaterial3 = !useMaterial3;
      themeData = updateThemes(colorSelected, useMaterial3, useLightMode);
    });
  }

  void handleColorSelect(int value) {
    setState(() {
      colorSelected = value;
      themeData = updateThemes(colorSelected, useMaterial3, useLightMode);
    });
  }

  Widget createScreenFor(int screenIndex, bool showNavBarExample) {
    switch (screenIndex) {
      case 0:
        return ComponentScreen(showNavBottomBar: showNavBarExample);
      case 1:
        return const TypographyScreen();
      case 2:
        return const ElevationScreen();

      default:
        return ComponentScreen(showNavBottomBar: showNavBarExample);
    }
  }

  PreferredSizeWidget createAppBar() {
    return AppBar(
      title: appBarText(),
    );
  }

  Text? appBarText() {
    if (openedScreen == 0) {
      return const Text(
        'Home',
        style: TextStyle(fontSize: 20),
      );
    } else if (openedScreen == 1) {
      return const Text(
        'Journey',
        style: TextStyle(fontSize: 20),
      );
    } else if (openedScreen == 2) {
      return const Text(
        'Patrios',
        style: TextStyle(fontSize: 20),
      );
    } else {
      return const Text(
        'Home',
        style: TextStyle(fontSize: 20),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cellz',
      themeMode: useLightMode ? ThemeMode.light : ThemeMode.dark,
      theme: themeData,
      home: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth < narrowScreenWidthThreshold) {
          return Scaffold(
            appBar: createAppBar(),
            //create a drawer for the app bar that contains all the setting as described in the readme

            drawer: Drawer(
              //reduce the height of the drawer header
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  Container(
                    height: 150,
                    child: DrawerHeader(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: Text(
                          'Settings',
                          style: TextStyle(fontSize: 32),
                        ),
                      ),
                    ),
                  ),
                  const ListTile(
                    title: Text('Colors Picker'),
                  ),

                  //create a gridview of 7 colors having an icon at each index value: index, remove the scrolling

                  Container(
                    height: 120,
                    child: GridView.count(
                      scrollDirection: Axis.horizontal,
                      crossAxisCount: 2,
                      children: List.generate(colorOptions.length, (index) {
                        return Center(
                          child: IconButton(
                            icon: Icon(
                              index == colorSelected
                                  ? FluentIcons.checkmark_square_24_filled
                                  : FluentIcons.checkbox_unchecked_24_filled,
                              color: colorOptions[index],
                              size: 33,
                            ),
                            onPressed: () {
                              handleColorSelect(index);
                            },
                          ),
                        );
                      }),
                    ),
                  ),

                  const ListTile(
                    title: Text('Dark Mode'),
                  ),
                  //creating a toggle button to turn on and off the dark theme
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(12, 5, 0, 0),
                      child: Switch(
                        value: !useLightMode,
                        onChanged: (value) {
                          handleBrightnessChange();
                        },
                      ),
                    ),
                  ),

                  //creating account settings:
                  const ListTile(
                    title: Text('Account Settings', style: TextStyle(fontSize: 17)),
                  ),

//                   Details of the drawer:
// On the home screen, we have a hamburger icon which opens up the drawer, following is the content of the drawer:
// On top we have a label that says Settings, below it we will have a color picker using a gridview that has icons which can be selected to change the colors of the ui. Below the colorPicker we have the option to select dark or light theme. After this we have the account settings where the user will be able to change his name and picture using an AlertDialoguebox. After this we have the send Feedback button which lauch the email app and send an email to ‘haseebkahn365@gmail.com’ and at the end we will have a ‘reset all’ button which will make all the list of the unlockedExperienceList empty but this will be done via an alert dialogue box where the user has to type ‘reset all’ in order to reset the all his data.

                  //creating a text button to launch the alert dialogue box
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 12, top: 5, bottom: 5),
                          child: ElevatedButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Account Settings'),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: const <Widget>[
                                            Text('Change your name and picture'),
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('Change Name'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          child: const Text('Change Picture'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  });
                            },
                            child: const Text('Change Profile'),
                            //make elevation 0 and rounded corners
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              backgroundColor: Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.5),
                            ),
                          ),
                        ),
                        //icon for change
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child:
                              Icon(FluentIcons.edit_16_filled, color: Theme.of(context).colorScheme.secondaryContainer),
                        )
                      ],
                    ),
                  ), //end of the alert dialogue box

                  //creating an alert dialogue box to send feedback in the same fashion as above

                  const ListTile(
                    title: Text('Send Feedback', style: TextStyle(fontSize: 17)),
                  ),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 12, top: 5, bottom: 5),
                          child: ElevatedButton(
                            onPressed: () {
                              //launch
                            },
                            child: const Text('Send Feedback'),
                            //make elevation 0 and rounded corners
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              backgroundColor: Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.5),
                            ),
                          ),
                        ),

                        //icon for feedback

                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Icon(FluentIcons.alert_12_filled,
                              color: Theme.of(context).colorScheme.secondaryContainer),
                        )
                      ],
                    ),
                  ), //end of the feedback button

                  //working on the reset button
                  const ListTile(
                    title: Text('Reset Everything'),
                  ),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 12, top: 5, bottom: 5),
                          child: ElevatedButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Reset Everything'),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: const <Widget>[
                                            Text(
                                                'Are you sure you want to reset everything? Type \'reset all\' to confirm\n\n'),

                                            //creating a text field to enter the text
                                            TextField(
                                              decoration: InputDecoration(
                                                contentPadding: EdgeInsets.all(10),
                                                border: OutlineInputBorder(),
                                                labelText: 'reset all',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('Yes'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          child: const Text('No'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  });
                            },
                            child: const Text('Reset my Data'),
                            //make elevation 0 and rounded corners
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              backgroundColor: Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.5),
                            ),
                          ),
                        ),

                        //icon for reset

                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Icon(FluentIcons.delete_16_filled,
                              color: Theme.of(context).colorScheme.secondaryContainer),
                        )
                      ],
                    ),
                  ), //end of the reset button
                ],
              ),
            ),
            body: Row(children: <Widget>[
              createScreenFor(screenIndex, false),
            ]),
            bottomNavigationBar: NavigationBars(
              onSelectItem: handleScreenChanged,
              selectedIndex: screenIndex,
              isExampleBar: false,
            ),
          );
        } else {
          return Scaffold(
            appBar: createAppBar(),
            body: SafeArea(
              bottom: false,
              top: false,
              child: Row(
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: NavigationRailSection(onSelectItem: handleScreenChanged, selectedIndex: screenIndex)),
                  const VerticalDivider(thickness: 1, width: 1),
                  createScreenFor(screenIndex, true),
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}
