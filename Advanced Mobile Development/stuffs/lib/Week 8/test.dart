class Fruit {
  final String id;

  Fruit(this.id);

  @override
  bool operator ==(Object other) {
    return other is Fruit && other.id == this.id;
  }
  
  @override
  int get hashCode => id.hashCode;
}


void main() {
  Fruit fruit1 = Fruit('apple');
  Fruit fruit2 = Fruit('apple');


  print(fruit1 == fruit2);
}