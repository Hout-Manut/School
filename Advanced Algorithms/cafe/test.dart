List<int> list = [1, 2, 3, 4, 5, 6];


void main() {
  int opt = 7;
  for (int num in list){
    if (opt == num) {
      print(num);
    }
  }
}
