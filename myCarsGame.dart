//i am writing the following code for another projects so don't consider it. i will delete it soon.
/*Cars game: 
Task Desciption:

This game is a simple console based game. The control flow is described as follows: we first create a grid of points using a function 
static void createPoints(int xCount, int yCount) {
    for (int i = 0; i < xCount; i++) {
      for (int j = 0; j < yCount; j++) {
        allPoints.add(Points(xCord: j, yCord: i)); 
      }
    }
  }

Global Lists:
List<Point> allPoints; //this contains all the grid points of the game;
List<Point> carPositions; //this contains all the positions of the cars
List<Car> carList;
AllPoints in the above case is the list of the points that are created for the game. This means that we can reference a point using allPoints[index] in the list. The following is the description of the Point
Point
Members:
Int xCord;
Int yCord;
Methods:
Points({this. xCord, this. yCord}); //use C++ syntax here
Overload the equality operator for Point:
bool operator ==(Point p2){
if(this.xCord == p2.xCord && this.yCord == p2.yCord){return true;} else {return false;}
}
Bool checkPointPresence (Points &p){
If (point exists in list){
     Return true;
} else {return false;}
}



Cars
Members:
Point position;
Bool team; //indication of red or blue color for the car
Int index; //this is the index of the car
Methods:

Void changeDirection(int direction){
Switch(direction){

Case 1: 
//move forward if not upper boundary
if (position.yCord != 0){
postion.yCord--;// the car moves up so the ycord decreases

}
Break;

Case 2: 
//move backward if not lower boundary
if (position.yCord != noOfYPoints-1){
postion.yCord++; //the car moves down so y coordinate increases
}
Break;

Case 3: 
//move left if not left boundary
if (position.xCord != 0){
postion.xCord--; //the car moves left so x coordinate decreases
}
Break;

Case 4: 
//move right if not right boundary
if (position.xCord != noOfYPoints-1){
postion.xCord++; //the car moves right so x coordinate increases
}
Break;

Default:
Cout<<”invalid direction”;


}

}

Start of the game:
The following description contains pseudocode and is not executable. At the start of the game we have two global int variables that define the boundary of the game ie.
int noOfXPoints = 20; //20 points on horizontal axis.
int noOfYPoints = 20; //20 points on vertical axis.
We also have three global lists ie.
List<Point> allPoints; //this contains all the grid points of the game;
List<Point> carPositions; //this contains all the positions of the cars
List<Car> carList; //this is the list of all the cars created.

We start with creating the grid for the game. This is the screen resolution. The following createPoints() will add the points of the grid to the list of allPoints:
void createPoints(int noOfXPoints, int noOfYPoints) {
    for (int i = 0; i < xCount; i++) {
      for (int j = 0; j < yCount; j++) {
        allPoints.push_back(new Points(xCord: j, yCord: i)); 
      }
    }
  }


 */

//After creating the points, now we create cars and add it to the list of the cars. We will create only 10 cars at random positions within the range of boundaries and add these to the list using the constructor of the Car class ie.

int main() {


  for (int i = 0; i < 10; i++) {
    if (i < 5) {
      carList.push_back(new Car(
          position: allPoints[rand() % (noOfXPoints * noOfYPoints - 1)],
          team: true,
          index: i));
    } else {
      carList.push_back(new Car(position: allPoints[rand() % (noOfXPoints * noOfYPoints - 1)], team: false, index: i));
    }
  }
//Now we fill out the carPositions list, using the positions of each car in the carList.

  for (int i = 0; i < carList.length; i++) {
    carPositions.push_back(carList[i].position);
  }

  /*Checking for collision after cars creation:
Now that the cars are created and we also have their postions in the carPositions lists now we have to see if there are any collisions between the cars. To check this, we simply create a function in which we have to go trough each position in the carPositions list and check if there are more than one instance of the same position in the list if there are several instances of the same position found then, we will display a message that will show the number of cars (using the number of instances of position) that have collided and the xCord and yCord of this position. And we will exit the game.
 */

  void checkCollision() {
    for (int i = 0; i < carPositions.length; i++) {
      int count = 0;
      for (int j = 0; j < carPositions.length; j++) {
        if (carPositions[i] == carPositions[j]) {
          count++;
        }
      }
      if (count > 1) {
        cout << "Collision detected at position: " << carPositions[i].xCord << ", " << carPositions[i].yCord << endl;
        cout << "Number of cars collided: " << count << endl;
        //remove the cars that have collided from the carList

        for (int k = 0; k < carList.length; k++) {
          if (carList[k].position == carPositions[i]) {
            carList.removeAt(k);
          }
        }

        //we will display the remaining cars in the carList the details of the displayRemaining() function are described later.
        void displayRemaining();
        exit(0);
      }
    }
  }

  /*Displaying the remaining cars:

  





}
