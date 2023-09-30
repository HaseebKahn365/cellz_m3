// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

import 'app_ui/home_buttons.dart';

class ComponentScreen extends StatelessWidget {
  ComponentScreen({super.key, required this.showNavBottomBar});

  final bool showNavBottomBar;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: _maxWidthConstraint,
            child: ListView(
              shrinkWrap: true,
              children: [
                ...buildHomeButtons(context),
                // showNavBottomBar
                //     ? const NavigationBars(
                //         selectedIndex: 0,
                //         isExampleBar: true,
                //       )
                //     : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

const _rowDivider = SizedBox(width: 10);
const _colDivider = SizedBox(height: 10);
const double _cardWidth = 115;
const double _maxWidthConstraint = 400;

class ButtonsWithIcon extends StatelessWidget {
  const ButtonsWithIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Column(),
    );
  }
}

class Cards extends StatelessWidget {
  const Cards({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Wrap(
        alignment: WrapAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: _cardWidth,
            child: Card(
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: const [
                    Align(
                      alignment: Alignment.topRight,
                      child: Icon(Icons.more_vert),
                    ),
                    SizedBox(height: 35),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text("Elevated"),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: _cardWidth,
            child: Card(
              color: Theme.of(context).colorScheme.surfaceVariant,
              elevation: 0,
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: const [
                    Align(
                      alignment: Alignment.topRight,
                      child: Icon(Icons.more_vert),
                    ),
                    SizedBox(height: 35),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text("Filled"),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: _cardWidth,
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Theme.of(context).colorScheme.outline,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: const [
                    Align(
                      alignment: Alignment.topRight,
                      child: Icon(Icons.more_vert),
                    ),
                    SizedBox(height: 35),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text("Outlined"),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Dialogs extends StatefulWidget {
  const Dialogs({super.key});

  @override
  State<Dialogs> createState() => _DialogsState();
}

class _DialogsState extends State<Dialogs> {
  void openDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Basic Dialog Title"),
        content: const Text(
            "A dialog is a type of modal window that appears in front of app content to provide critical information, or prompt for a decision to be made."),
        actions: <Widget>[
          TextButton(
            child: const Text('Dismiss'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: const Text('Action'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextButton(
        child: const Text(
          "Open Dialog",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        onPressed: () => openDialog(context),
      ),
    );
  }
}

const List<NavigationDestination> appBarDestinations = [
  NavigationDestination(
    tooltip: "",
    icon: Icon(
      FluentIcons.home_24_regular,
      size: 30,
    ),
    label: 'Home',
    selectedIcon: Icon(
      FluentIcons.home_24_filled,
      size: 30,
    ),
  ),
  NavigationDestination(
    tooltip: "",
    icon: Icon(
      FluentIcons.poll_24_regular,
      size: 30,
    ),
    label: 'Journey',
    selectedIcon: Icon(
      FluentIcons.poll_24_filled,
      size: 30,
    ),
  ),
  NavigationDestination(
    tooltip: "",
    icon: Icon(
      FluentIcons.people_28_regular,
      size: 32,
    ),
    label: 'Patrios',
    selectedIcon: Icon(
      FluentIcons.people_28_filled,
      size: 32,
    ),
  )
];

final List<NavigationRailDestination> navRailDestinations = appBarDestinations
    .map(
      (destination) => NavigationRailDestination(
        icon: Tooltip(
          message: destination.label,
          child: destination.icon,
        ),
        selectedIcon: Tooltip(
          message: destination.label,
          child: destination.selectedIcon,
        ),
        label: Text(destination.label),
      ),
    )
    .toList();

const List<Widget> exampleBarDestinations = [
  NavigationDestination(
    tooltip: "",
    icon: Icon(Icons.explore_outlined),
    label: 'Home',
    selectedIcon: Icon(Icons.explore),
  ),
  NavigationDestination(
    tooltip: "",
    icon: Icon(Icons.pets_outlined),
    label: 'Journey',
    selectedIcon: Icon(Icons.pets),
  ),
  NavigationDestination(
    tooltip: "",
    icon: Icon(Icons.account_box_outlined),
    label: 'Patrios',
    selectedIcon: Icon(Icons.account_box),
  )
];

class NavigationBars extends StatefulWidget {
  final void Function(int)? onSelectItem;
  final int selectedIndex;
  final bool isExampleBar;

  const NavigationBars({super.key, this.onSelectItem, required this.selectedIndex, required this.isExampleBar});

  @override
  State<NavigationBars> createState() => _NavigationBarsState();
}

class _NavigationBarsState extends State<NavigationBars> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: _selectedIndex,
      onDestinationSelected: (index) {
        setState(() {
          _selectedIndex = index;
        });
        if (!widget.isExampleBar) widget.onSelectItem!(index);
      },
      destinations: widget.isExampleBar ? exampleBarDestinations : appBarDestinations,
    );
  }
}

class NavigationRailSection extends StatefulWidget {
  final void Function(int) onSelectItem;
  final int selectedIndex;

  const NavigationRailSection({super.key, required this.onSelectItem, required this.selectedIndex});

  @override
  State<NavigationRailSection> createState() => _NavigationRailSectionState();
}

class _NavigationRailSectionState extends State<NavigationRailSection> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      minWidth: 50,
      destinations: navRailDestinations,
      selectedIndex: _selectedIndex,
      useIndicator: true,
      onDestinationSelected: (index) {
        setState(() {
          _selectedIndex = index;
        });
        widget.onSelectItem(index);
      },
    );
  }
}
