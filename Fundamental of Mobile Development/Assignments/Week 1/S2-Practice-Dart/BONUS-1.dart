enum Direction { north, east, south, west }

// Initial position {7, 3} and facing north
int x = 7;
int y = 3;
Direction direction = Direction.north;

// Example instruction sequence
const instructions = "RAALAL";

// Before we start:

//     N
//     |
//  W--+--E
//     |
//     S
// And
//    +y
//     |
// -x--+--+x
//     |
//    -y

void main() {

  // Process the instructions and get the final position and direction
  for (String inst in instructions.split("")) {
    switch (inst) {
      case "R":
        turnRight();
        break;
      case "L":
        turnLeft();
        break;
      case "A":
        advance();
        break;
      default:
        print("Unknown instruction: $inst.");
    }
  }

  // Print the final position and direction
  print("Final position:  $x, $y");
  print("Facing:  $direction");
}

void advance() {
  switch (direction) {
    case Direction.north:
      y++;
      break;
    case Direction.east:
      x++;
      break;
    case Direction.south:
      y--;
      break;
    case Direction.west:
      x--;
      break;
  }
}

void turnLeft() {
  switch (direction) {
    case Direction.north:
      direction = Direction.west;
      break;
    case Direction.west:
      direction = Direction.south;
      break;
    case Direction.south:
      direction = Direction.east;
      break;
    case Direction.east:
      direction = Direction.north;
      break;
  }
}

void turnRight() {
  switch (direction) {
    case Direction.north:
      direction = Direction.east;
      break;
    case Direction.east:
      direction = Direction.south;
      break;
    case Direction.south:
      direction = Direction.west;
      break;
    case Direction.west:
      direction = Direction.north;
      break;
  }
}
