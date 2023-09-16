import '../../game_classes.dart';
import 'firstMaxSquareChain.dart';

secondMaxSquareChain(List<Lines> totalLines, List<Lines> allLines, List<Lines> tempFirstChainMoves) {
  List<List<Lines>> tempSecondMaxChainsList = [];
  List<Lines> tempCheckableLines = [];
  List<Lines> tempAllLines = [];
  tempAllLines = [...allLines, ...tempFirstChainMoves];
  tempCheckableLines = totalLines.where((element) => !tempAllLines.contains(element)).toList();

  tempCheckableLines.forEach((line) {
    tempAllLines.add(line);
    List<Lines> tempFirstChain = [];
    tempFirstChain = firstMaxSquareChain(totalLines, tempAllLines);
    // print('tempFirstChain length is ${tempFirstChain.length}');
    // print('tempFirstChain is $tempFirstChain');
    //only add lists to the tempSecondMaxChainsList if its length is greater than 1
    tempSecondMaxChainsList.add(tempFirstChain);
    // if (!tempSecondMaxChainsList.contains(tempFirstChain)) {
    // } // no need to check for this condition as the tempFirstChain will always be unique.
    tempAllLines.remove(line);
  });
  // print('tempSecondMaxChainsList length is ${tempSecondMaxChainsList.length}');
  // print('tempSecondMaxChainsList is $tempSecondMaxChainsList');
  return tempSecondMaxChainsList;
}
