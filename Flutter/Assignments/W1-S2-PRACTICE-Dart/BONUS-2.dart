Map<String, String> map = {"(": ")", "[": "]", "{": "}"};
Map<String, String> mapInversed = {")": "(", "]": "[", "}": "{"};

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
  for (String c in input.split("")) {
    if (map.containsKey(c)) {
      buffer.add(c);
    } else if (mapInversed.containsKey(c)) {
      if (buffer.removeLast() != mapInversed[c]) return false;
    }
  }
  return buffer.length == 0;
}
