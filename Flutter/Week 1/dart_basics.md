# Self-learning 1 - Dart Syntax & Concept

### 1. Type Inference
`EXPLAIN:` Explain how Dart infers the type of a variable.

`ANSWER:` If you do not specify a type for a variable, Dart will infer the type of that variable depends on the value you assign to it. Else if you explicitly set a variable to a type, it will only accept that type of data.
```dart
var year = 2024;           // Infered as int

String name = "Manut";     // Explicitly typed as String
```

### 2. Nullable and Non-Nullable Variables

`EXPLAIN:` Explain nullable vs non-nullable variables.

`ANSWER:` In Dart, you can make a variable nullable by using `?` next to the type of the variable.

`EXPLAIN:` When is it useful to have nullable variables?

`ANSWER:` Nullable variables can be assigned a value later and can be used as an optional value.

```dart
int? examScore;       // Nullable variable with a null value

int age = 20;         // Non-nullable variable

examScore = 80;
```

### 3. Final and Const

`EXPLAIN:` Describe the difference between final and const.

`ANSWER:` Both `final` and `const` are used to declare a fixed value and cannot be reassigned. The difference is `final` values can be assigned at runtime, while `const` values are assigned at compile-time.

```dart
final int currentDate = DateTime.now();  // The current date

//  `currentDate` cannot be a constant because constants are
//  assigned at compile-time while DateTime.now() can return
//  different values during runtime.

const int maxScore = 100;

//  Both `currentDate` and `maxScore` cannot be reassigned.
//  Reassigning any of them will result in an `Error`.
//  Why? Because Dart doesn't allow it??? I don't know how
//  to answer this other than the answer from the top.
```

### 4. Strings, Lists and Maps

#### String

```dart
String firstName = "Manut";
String lastName = "Hout";
int age = 20;

String nameAge = firstName + lastName + age.toString();

print(nameAge); //  ManutHout20

```
#### Lists
```dart
List<int> list = [0, 1, 2, 3];
list.add(4);         //  [0, 1, 2, 3, 4]
list.remove(0);      //  [1, 2, 3, 4]
list.insert(1, 2);   //  [1, 2, 2, 3, 4]
list.foreach(print);
//  1
//  2
//  2
//  3
//  4
```
#### Maps
```dart
Map<String, int> map = {
    "one": 1,
    "two": 2,
    "three": 3,
};
map["four"] = 4;    //  {one: 1, two: 2, three: 3, four: 4}
map.remove("two");  //  {one: 1, three: 3, four: 4}
map.forEach((k, v) => print(k + " = " + v.toString()));
//  one = 1
//  three = 3
//  four = 4
```

### 5. Loops and Conditions

```dart
for (int i = 1; i < 6; i++) print(i);
//  1
//  2
//  3
//  4
//  5

while (true) print(1);  //  Prints `1` infinitely

int number = 20;
if (number % 2 == 0) print("Even");
else print("Odd");
//  Even
```

### 6. Functions

`EXPLAIN:` Compare positional and named function arguments.

`ANSWER:` Positional arguments are passed by entering a value or a variable to the function and have to follow the order of the arguments the function takes. Named arguments are arguments with the name of the parameter in-front of the passed values, this will assign the value to the parameter of the function directly and ignore the order of the parameters.

`EXPLAIN:` Explain when and how to use arrow syntax for functions.

`ANSWER:` Arrow syntax functions can be used when there is just one expression as a shorthand.

```dart
int sum(int a, int b) => a + b;

print(sum(1, 2));  // 3

//  Positional vs Named Arguments
double getCircleArea(double r) => 3.14 * r * r;
double getRectArea({
  required double width,
  required double height,
}) => return width * height;

print(getCircleArea(4))                     //  50.24
print(getRectArea(width: 20, height: 10));  //  200.0

//  Arrow Syntax (also used above)
int square(int x) => x * x;

print(square(8));  // 64
```

`EXPLAIN:` Can positional argument be ommited? Show an example.

`EXPLAIN:` Can named argument be ommited? Show an example.

`ANSWER:` Both type of arguments can be omitted by using default values when writing the function parameters or if the parameter is nullable, its default value will be null.

```dart
double getRectArea(double width, [double? height]) {
  // The default value of height is null
  double w = height ?? width;

  return width * w;
}

double getCircleArea(double x, {bool isDiameter = false}) {
  double r = isDiameter ? x / 2 : x;

  return 3.14 * r * r;
}

print(getRectArea(20));   //  400.0
print(getCircleArea(3));  //  78.5
```
