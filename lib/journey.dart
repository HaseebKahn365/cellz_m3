// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class TypographyScreen extends StatelessWidget {
  const TypographyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.apply(displayColor: Theme.of(context).colorScheme.onSurface);
    return Expanded(
      child: ListView(
        children: <Widget>[
          const SizedBox(height: 7),
          /*
•	The second screen on the navigationBar is the ‘Journey’ screen. This screen has a carousel slider which will have multiple containers with the same color as the themecolor indicating the levels that are completed by the user. And for the locked levels the container will appear grey. Lets have a look at what the container will contain. The container will have the Level label as a text, a play button to play the repective level, a high score text indicating the highest score that the user has scored, a  total score text indicating the total Score for the level and experience text indicating the performance of the player. This data will come from list of the UnlockedExperience objects list named as ‘unlockedExperienceList’. Following is the structure of the class: 	
Class unlockedExperience{ 
int level;
int totalScore;
int highScore;
int gamesPlayed;
Text CalculateExperience(){
If(this.level == 1){ return Text(‘High’, style: TextStyle(color: Colors.green));}
If(this.level == 2){
//number of xPoints and yPoints are specified for the level 2 use those hard values here.
	Final noOfMoves = (numOfXPoints - 1) * numOfYPoints + (numOfYPoints - 1) * numOfXPoints;
	Final ratio = totalScore / ( noOfMoves* gamesPlayed ) 
	Return ratio > 0.65 ? Text(‘High’, style: TextStyle(color: Colors.green)) : ratio> 0.4? Text(‘Med, style: TextStyle(color: Colors.yellow)) : Text(‘Low, style: TextStyle(color: Colors.red[200]));
	}
//….similarly we will find the experience for the specified level.
}

 }
We will extract the required data from the global list of the unlockedExperience objects and for the remaining levels which are locked the default texts of level, totalScore = 0, highScore = 0 and gamesPlayed = 0 will be displayed on the container of the carousel slider. Below the carousel slider we will have the Overall Stats of the user. This will display the following data which is extracted from the unlockedExperience objects list. 
currentTopLevel; //this shows the top level that is currently unlocked by the user.
totalGamesPlayed;
Experience; //extract the most occurring experience label in the list of unlockedExperienceList
 */

          CarouselSlider.builder(
            itemCount: 10,
            itemBuilder: (context, index, realIndex) => Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.inversePrimary.withOpacity(0.2),
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 10),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text('Level ${index + 1}', style: textTheme.displayMedium),
                      )),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.play_arrow),
                    label: Text('Play'),
                  ),
                  const SizedBox(height: 10),
                  Text('High Score: 0', style: textTheme.bodyLarge),
                  const SizedBox(height: 10),
                  Text('Total Score: 0', style: textTheme.bodyLarge),
                  const SizedBox(height: 10),
                  Text('Experience: Low', style: textTheme.bodyLarge),
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

          /*    return DataTable(       columns: [         DataColumn(label: Text('TITLE', style: Theme.of(context).textTheme.bodyLarge)),         DataColumn(label: Text('ARTIST'
           rows: tracks.map((e) {         final selected = context.watch<CurrentTrackModel>().selected?.id == e.id;         final textStyle = TextStyle(           color: selected ? Theme.of(context).colorScheme.secondary : colorOnSelected         );         return DataRow(           cells: [             DataCell(               Text(e.title, style: textStyle),             ),             DataCell(               Text(e.artist, style: textStyle),             ),             DataCell(               Text(e.album, style: textStyle),             ),             DataCell(Text(               e.duration,               style: textStyle,             )),           ],           selected: selected,           onSelectChanged: (_) => context.read<CurrentTrackModel>().selectTrack(e),         );       }).toList(), */
          //create a table in usng the above style:

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: SingleChildScrollView(
              child: DataTable(columns: [
                DataColumn(label: Text('Level', style: textTheme.bodyMedium)),
                DataColumn(label: Text('High Score', style: textTheme.bodyMedium)),
                DataColumn(label: Text('Total Score', style: textTheme.bodyMedium)),
              ], rows: [
                DataRow(cells: [
                  DataCell(Align(alignment: Alignment.center, child: Text('1', style: textTheme.bodyMedium))),
                  DataCell(Align(alignment: Alignment.center, child: Text('1', style: textTheme.bodyMedium))),
                  DataCell(Align(alignment: Alignment.center, child: Text('1', style: textTheme.bodyMedium))),
                ]),
                DataRow(cells: [
                  DataCell(Align(alignment: Alignment.center, child: Text('1', style: textTheme.bodyMedium))),
                  DataCell(Align(alignment: Alignment.center, child: Text('1', style: textTheme.bodyMedium))),
                  DataCell(Align(alignment: Alignment.center, child: Text('1', style: textTheme.bodyMedium))),
                ]),
                DataRow(cells: [
                  DataCell(Align(alignment: Alignment.center, child: Text('5647', style: textTheme.bodyMedium))),
                  DataCell(Align(alignment: Alignment.center, child: Text('5647', style: textTheme.bodyMedium))),
                  DataCell(Align(alignment: Alignment.center, child: Text('5647', style: textTheme.bodyMedium))),
                ]),
                DataRow(cells: [
                  DataCell(Align(alignment: Alignment.center, child: Text('5647', style: textTheme.bodyMedium))),
                  DataCell(Align(alignment: Alignment.center, child: Text('5647', style: textTheme.bodyMedium))),
                  DataCell(Align(alignment: Alignment.center, child: Text('1', style: textTheme.bodyMedium))),
                ]),
                DataRow(cells: [
                  DataCell(Align(alignment: Alignment.center, child: Text('1', style: textTheme.bodyMedium))),
                  DataCell(Align(alignment: Alignment.center, child: Text('1', style: textTheme.bodyMedium))),
                  DataCell(Align(alignment: Alignment.center, child: Text('1', style: textTheme.bodyMedium))),
                ]),
                DataRow(cells: [
                  DataCell(Align(alignment: Alignment.center, child: Text('1', style: textTheme.bodyMedium))),
                  DataCell(Align(alignment: Alignment.center, child: Text('1', style: textTheme.bodyMedium))),
                  DataCell(Align(alignment: Alignment.center, child: Text('1', style: textTheme.bodyMedium))),
                ]),
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
