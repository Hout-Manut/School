// import 'level_3.dart';
// import 'level_4.dart';

enum Color {
  BLUE,
  RED,
  GREEN,
  WHITE,
  YELLOW,
  BLACK,
}

enum Material {
  BRICK,
  STONE,
  WOOD,
  GLASS,
}

enum RoofType {
  GABLE,
  HIP,
  DUTCH,
  MAMSARD,
  FLAT,
  SHAD,
  GAMBRET,
  DORMER,
  M_SHAPED,
}

enum RoomType {
  LIVING_ROOM,
  BEDROOM,
  KITCHEN,
  BATHROOM,
}

class Point {
  double x, y;

  Point(this.x, this.y);

  @override
  String toString() {
    return "Point($x, $y)";
  }
}

class Shape {
  late Point origin;
  late int width, height;
  int? backgroundColor;

  Shape(Point origin,
      {required int width, required int height, int? backgroundColor}) {
    this.origin = origin;
    this.width = width;
    this.height = height;
    this.backgroundColor = backgroundColor;
  }

  Point get topLeft => Point(origin.x, origin.y + height);
  Point get topRight => Point(origin.x + width, origin.y + height);
  Point get bottomLeft => origin;
  Point get bottomRight => Point(origin.x + width, origin.y);

}

class Window {
  final Color color;
  bool isOpen;
  final Shape shape;

  Window({required this.color, required this.shape}) : this.isOpen = true;

  void closeWindow() => this.isOpen = false;
  void openWindow() => this.isOpen = true;
}

class Chimney {
  final Material material;
  final Color color;

  Chimney({required this.material, required this.color});
}

class Wall {
  final Material material;
  final List<Window> windows;
  final List<Door> doors;

  Wall({required this.material, required this.windows, required this.doors});

  void addWindow(Window window) => this.windows.add(window);
  void addDoor(Door door) => this.doors.add(door);
}

class Room {
  final RoomType type;
  final Shape shape;
  final List<Door> doors;
  final Chimney? chimey;

  Room(
      {required this.type,
      required this.shape,
      required this.doors,
      this.chimey});
}

class Floor {
  final Shape shape;
  final double height;
  final List<Room> rooms;

  final List<Door>? doors;

  Floor(
      {required this.shape,
      required this.height,
      required this.rooms,
      this.doors});


  // int get numOfDoor {
  //   if (!doors) return 0;
  //   return doors.length;
  // }

  @override
  String toString() {
    List<RoomType> roomNames = [];
    rooms.forEach((room) => roomNames.add(room.type));
    return "Floor(${shape.width}x${shape.height}x$height, Rooms($roomNames), Doors(${doors}))";
  }
}

class Door {
  final Material material;
  final Color color;
  bool isOpen;
  final Shape shape;

  Door({required this.material, required this.color, required this.shape})
      : this.isOpen = true;
}

class Roof {
  final RoofType roofType;
  final Material material;
  final Color color;

  Roof({required this.roofType, required this.material, required this.color});
}

class Tree {
  final String type;
  double height;

  Tree(this.height, {required this.type});
}

class House {
  final List<Floor> floors;
  final Roof roof;
  final Shape shape;
  final List<Tree> trees;

  House(
      {required this.floors,
      required this.roof,
      required this.shape,
      required this.trees});

  void addTree(Tree tree) => this.trees.add(tree);

  @override
  String toString() {

    String floorNum = floors.length == 1  ? "floor" : "floors";
    return "House(${floors.length} $floorNum, floors($floors), Shape(${shape.width}, ${shape.height}), Trees($trees))";
  }
}

void main() {
  Room kitchen = Room(
    type: RoomType.KITCHEN,
    shape: Shape(Point(0, 0), width: 2, height: 3),
    doors: [
      Door(
        material: Material.WOOD,
        color: Color.YELLOW,
        shape: Shape(Point(1, 0), width: 1, height: 2),
      ),
    ],
  );
  Room livingRoom = Room(
    type: RoomType.LIVING_ROOM,
    shape: Shape(Point(0, 0), width: 3, height: 3),
    doors: [
      Door(
        material: Material.WOOD,
        color: Color.RED,
        shape: Shape(Point(1, 0), width: 1, height: 2),
      ),
    ],
    chimey: Chimney(material: Material.BRICK, color: Color.YELLOW),
  );

  Door entrance = Door(
    material: Material.WOOD,
    color: Color.BLACK,
    shape: Shape(Point(4, 0), width: 2, height: 3),
  );

  Floor firstFloor = Floor(
    shape: Shape(Point(0, 0), width: 10, height: 20),
    height: 4,
    rooms: [kitchen, livingRoom],
    doors: [entrance],
  );

  Roof roof = Roof(
      roofType: RoofType.FLAT, material: Material.BRICK, color: Color.WHITE);

  House myHouse = House(
    floors: [firstFloor],
    roof: roof,
    shape: Shape(Point(0, 0), width: 10, height: 20),
    trees: [],
  );

  print(myHouse);
}
