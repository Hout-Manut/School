import 'level_3.dart';
import 'level_4.dart';

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


class Window {
  final Color color;
  bool isOpen;
  final Shape shape;

  Window({required this.color, required this.shape}) : this.isOpen = true;

  void close() => this.isOpen = false;
  void open() => this.isOpen = true;

  @override
  String toString() {
    String opened = isOpen ? "Opened" : "Closed";
    return "Window($opened, $color)";
  }
}

class Chimney {
  final Material material;
  final Color color;

  Chimney({required this.material, required this.color});
}

class Wall {
  final Material material;
  final List<Window> windows = [];
  final List<Door> doors = [];

  Wall({required this.material});

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
  final Wall wall;

  final List<Door>? externalDoors;

  Floor(
      {required this.shape,
      required this.height,
      required this.rooms,
      required this.wall,
      this.externalDoors});

  // int get numOfDoor {
  //   if (!doors) return 0;
  //   return doors.length;
  // }

  @override
  String toString() {
    List<RoomType> roomNames = [];
    rooms.forEach((room) => roomNames.add(room.type));
    return "Floor(${shape.width}x${shape.height}x$height, Rooms($roomNames), Doors(${externalDoors}))";
  }
}

class Door {
  final Material material;
  final Color color;
  bool isOpen;
  final Shape shape;

  Door({required this.material, required this.color, required this.shape})
      : this.isOpen = true;

  void close() => this.isOpen = false;
  void open() => this.isOpen = true;

  @override
  String toString() {
    String opened = isOpen ? "Opened" : "Closed";
    return "Door($opened, $color, $material)";
  }
}

class Roof {
  final RoofType roofType;
  final Material material;
  final Color color;

  Roof({required this.roofType, required this.material, required this.color});
}

class Tree {
  final String type;
  Distance height;

  Tree({required this.height, required this.type});

  @override
  String toString() {
    return "Tree($type, $height)";
  }
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
    String floorNum = floors.length == 1 ? "floor" : "floors";
    return "House(${floors.length} $floorNum, floors($floors), Shape(${shape.width}, ${shape.height}), Trees($trees))";
  }
}

void main() {
  Room kitchen = Room(
    type: RoomType.KITCHEN,
    shape: Shape(Point(0, 0), width: Distance.m(2), height: Distance.m(3)),
    doors: [
      Door(
        material: Material.WOOD,
        color: Color.YELLOW,
        shape: Shape(Point(1, 0), width: Distance.m(1), height: Distance.m(2)),
      ),
    ],
  );
  Room livingRoom = Room(
    type: RoomType.LIVING_ROOM,
    shape: Shape(Point(0, 0), width: Distance.m(3), height: Distance.m(3)),
    doors: [
      Door(
        material: Material.WOOD,
        color: Color.RED,
        shape: Shape(Point(1, 0), width: Distance.m(1), height: Distance.m(2)),
      ),
    ],
    chimey: Chimney(material: Material.BRICK, color: Color.YELLOW),
  );
  Room livingRoom2 = Room(
    type: RoomType.LIVING_ROOM,
    shape: Shape(Point(0, 0), width: Distance.m(2), height: Distance.m(3)),
    doors: [
      Door(
        material: Material.WOOD,
        color: Color.RED,
        shape: Shape(Point(0.5, 0), width: Distance.m(1), height: Distance.m(2)),
      ),
    ],
  );
  Room bedroom = Room(
    type: RoomType.BEDROOM,
    shape: Shape(Point(0, 0), width: Distance.m(3), height: Distance.m(3)),
    doors: [
      Door(
        material: Material.WOOD,
        color: Color.WHITE,
        shape: Shape(Point(1, 0), width: Distance.m(1), height: Distance.m(2)),
      ),
    ],
  );
  Room toilet = Room(
    type: RoomType.BATHROOM,
    shape: Shape(Point(0, 0), width: Distance.m(2), height: Distance.m(2)),
    doors: [
      Door(
        material: Material.GLASS,
        color: Color.WHITE,
        shape: Shape(Point(0.5, 0), width: Distance.m(1), height: Distance.m(2)),
      ),
    ],
  );

  Door entrance = Door(
    material: Material.WOOD,
    color: Color.BLACK,
    shape: Shape(Point(4, 0), width: Distance.m(2), height: Distance.m(3)),
  );

  Floor firstFloor = Floor(
    shape: Shape(Point(0, 0), width: Distance.m(10), height: Distance.m(20)),
    height: 4,
    rooms: [kitchen, livingRoom],
    wall: Wall(material: Material.BRICK),
    externalDoors: [entrance],
  );

  Floor secondFloor = Floor(
    shape: Shape(Point(0, 0), width: Distance.m(10), height: Distance.m(20)),
    height: 4,
    rooms: [bedroom, toilet, livingRoom2],
    wall: Wall(material: Material.BRICK)
  );

  Roof roof = Roof(
      roofType: RoofType.FLAT, material: Material.BRICK, color: Color.WHITE);

  House myHouse = House(
    floors: [firstFloor, secondFloor],
    roof: roof,
    shape: Shape(Point(0, 0), width: Distance.m(10), height: Distance.m(20)),
    trees: [],
  );

  Tree palmTree = Tree(height: Distance(m:6, cm: 27), type: "TreeType.PALM");  // Pretend this is enum

  myHouse.addTree(palmTree);

  print(myHouse);
}
