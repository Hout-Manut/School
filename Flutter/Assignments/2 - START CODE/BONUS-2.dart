void main() {
  List<String> inputs = [
    "{what is (42)}?",
    "[text}",
    "{[[(a)b]c]d}",
  ];

  inputs.forEach((input) {
    bool passed = validate(input);
    String message = passed ? "" : " not";
    print("`$input` is$message balanced.");
  });
}

bool validate(String input) {
  List<String> buffer = [];
  String last = "";
  for (String c in input.split("")) {
    switch (c) {
      case "(":
      case "[":
      case "{":
        buffer.add(c);
        break;
      case ")":
        last = buffer.removeLast();
        if (last != "(") return false;
        break;
      case "]":
        last = buffer.removeLast();
        if (last != "[") return false;
        break;
      case "}":
        last = buffer.removeLast();
        if (last != "{") return false;
        break;
      default:
        break;
    }
  }
  return buffer.length == 0;
}