// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cellz_m3/game_logic/lists_of_objects.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';
import 'home.dart';
import 'patrios.dart';
import 'journey.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  initLists();
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

File? imageFile;
File? _tempImageFile;

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

String userName = 'Load from localStorage';
String _tempUserName = '';

class _CellzM3State extends State<CellzM3> {
  bool useMaterial3 = true;
  bool useLightMode = true;
  int colorSelected = 0;
  int screenIndex = 0;

  late ThemeData themeData;

  //create a controller for userName;
  TextEditingController userNameController = TextEditingController();

  @override
  initState() {
    super.initState();
    _loadSettings();
  }

  void _loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      useLightMode = prefs.getBool('useLightMode') ?? true;
      colorSelected = prefs.getInt('colorSelected') ?? 0;
      themeData = updateThemes(colorSelected, useMaterial3, useLightMode);
      print('Loaded the sharedPrefrences themeData');
    });
  }

  void _saveSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('useLightMode', useLightMode);
    prefs.setInt('colorSelected', colorSelected);
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
      _saveSettings();
    });
  }

  void handleColorSelect(int value) {
    setState(() {
      colorSelected = value;
      themeData = updateThemes(colorSelected, useMaterial3, useLightMode);
      _saveSettings();
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

  void _getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    _cropImage(pickedFile!.path);

    Navigator.pop(context);
  }

  void _cropImage(filePath) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
      sourcePath: filePath,
      maxWidth: 1080,
      maxHeight: 1080,
    );

    if (croppedImage != null) {
      setState(() {
        _tempImageFile = File(croppedImage.path);
      });
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
                              _saveSettings();
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
                          _saveSettings();
                        },
                      ),
                    ),
                  ),

                  //creating account settings:
                  const ListTile(
                    title: Text('Account Settings', style: TextStyle(fontSize: 17)),
                  ),

                  //creating a text button to launch the alert dialogue box
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 12, top: 5, bottom: 5),
                          child: ElevatedButton(
                            onPressed: () {
                              //create an alert dialogue box to change the name and picture of the user
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Change Profile'),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: <Widget>[
                                            //create a container with a gesture detector with logic to pick an image from the gallery:

                                            Container(
                                              height: 100,
                                              width: 100,
                                              child: GestureDetector(
                                                onTap: () {
                                                  //pick image from gallery
                                                  print('tapped on the image');
                                                  _getFromGallery();
                                                },
                                                //create a rounded rectangle with a child of an icon
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 50.0),

                                                  //if the imageFile is not null then show the image else show the icon
                                                  child: _tempImageFile != null
                                                      ? ClipRRect(
                                                          borderRadius: BorderRadius.circular(10),
                                                          child: Container(
                                                            color: Theme.of(context)
                                                                .colorScheme
                                                                .secondaryContainer
                                                                .withOpacity(1),
                                                            child: Image.file(_tempImageFile!, fit: BoxFit.cover),
                                                          ))
                                                      : ClipRRect(
                                                          borderRadius: BorderRadius.circular(10),
                                                          child: Container(
                                                            color: Theme.of(context).colorScheme.secondaryContainer,
                                                            child: Icon(FluentIcons.camera_add_48_filled,
                                                                color: Theme.of(context).colorScheme.primary),
                                                          ),
                                                        ),
                                                ),
                                              ),
                                            ),

                                            const SizedBox(
                                              height: 20,
                                            ),

                                            //creating a text field to enter the text
                                            TextField(
                                              controller: userNameController,
                                              decoration: InputDecoration(
                                                contentPadding: EdgeInsets.all(10),
                                                border: OutlineInputBorder(),
                                                labelText: userName,
                                              ),
                                              onChanged: (value) {
                                                _tempUserName = value;
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        //create a cancel button
                                        TextButton(
                                          child: const Text('Cancel'),
                                          onPressed: () {
                                            setState(() {
                                              userNameController.clear();
                                              _tempImageFile = imageFile;
                                              Navigator.of(context).pop();
                                            });
                                          },
                                        ),
                                        //create a save button with rounded border outline

                                        ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              if (_tempUserName.isNotEmpty) {
                                                userName = _tempUserName;
                                              }
                                              userNameController.clear();
                                              //change the user Image here
                                              imageFile = _tempImageFile;
                                            });
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Save'),
                                          //make elevation 0 and rounded corners
                                          style: ElevatedButton.styleFrom(
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            backgroundColor:
                                                Theme.of(context).colorScheme.secondaryContainer.withOpacity(1),
                                          ),
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
