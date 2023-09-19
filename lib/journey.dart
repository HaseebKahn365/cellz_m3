// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cellz_m3/game_logic/lists_of_objects.dart';
import 'package:flutter/material.dart';

class TypographyScreen extends StatelessWidget {
  const TypographyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.apply(displayColor: Theme.of(context).colorScheme.onSurface);
    return Expanded(
      child: ListView(
        children: <Widget>[
          const SizedBox(height: 14),

          //making the data dynamic based on the unlockedExperienceList

          CarouselSlider.builder(
            itemCount: 10,
            itemBuilder: (context, index, realIndex) => Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                //if the current index item has isUnlocked = true, then the color is the primary color, else it is the inversePrimary color
                color: unlockedExperienceList[index].isUnlocked
                    ? Theme.of(context).colorScheme.primaryContainer.withOpacity(0.7)
                    : Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.2),
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 10),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text('Level: ${unlockedExperienceList[index].level}', style: textTheme.displayMedium),
                      )),
                  const SizedBox(height: 10),
                  //return a disabled button with label 'locked' if the current index item has isUnlocked = false
                  unlockedExperienceList[index].isUnlocked
                      ? ElevatedButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.play_arrow),
                          label: Text('Play'),
                        )
                      : ElevatedButton.icon(
                          onPressed: () {},
                          icon: Icon(
                            Icons.lock,
                            color: Colors.white30,
                          ),
                          label: Text(
                            'Locked',
                            style: TextStyle(color: Colors.white30),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).colorScheme.onSurface.withOpacity(0),
                          ),
                        ),
                  const SizedBox(height: 10),
                  Text('High Score: ${unlockedExperienceList[index].highScore}', style: textTheme.bodyLarge),
                  const SizedBox(height: 10),
                  Text('Total Score: ${unlockedExperienceList[index].totalScore}', style: textTheme.bodyLarge),
                  const SizedBox(height: 10),
                  Text('Experience: ${unlockedExperienceList[index].experience}', style: textTheme.bodyLarge),
                  const SizedBox(height: 10),
                  Text('Games Played: ${unlockedExperienceList[index].gamesPlayed}', style: textTheme.bodyLarge),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            options: CarouselOptions(
                pageSnapping: false,
                height: 400,
                enableInfiniteScroll: false,
                viewportFraction: 0.8,
                initialPage: 0,
                enlargeCenterPage: true),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
            ),
            child: SingleChildScrollView(
              child: DataTable(dataRowHeight: 70, columns: [
                DataColumn(label: Text('Level', style: textTheme.bodyMedium)),
                DataColumn(label: Text('High Score', style: textTheme.bodyMedium)),
                DataColumn(label: Text('Total Score', style: textTheme.bodyMedium)),
              ], rows: [
                //creating all the rows of the table from the unlockedExperienceList

                for (var i = 0; i < unlockedExperienceList.length; i++)
                  DataRow(cells: [
                    DataCell(Text('     ${unlockedExperienceList[i].level}', style: textTheme.bodyMedium)),
                    DataCell(Text('     ${unlockedExperienceList[i].highScore}', style: textTheme.bodyMedium)),
                    DataCell(Text('     ${unlockedExperienceList[i].totalScore}', style: textTheme.bodyMedium)),
                  ])
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class TextStyleExample extends StatelessWidget {
  const TextStyleExample({
    super.key,
    required this.name,
    required this.style,
  });

  final String name;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(name, style: style),
    );
  }
}
