import 'package:flutter/material.dart';

enum Side {
  light(0, 'Light', Color(0xff2da2c0)),
  conflict(1, 'Conflict', Color(0xff391749)),
  colorless(2, 'Colorless', Color(0xffeae9e0)),
  lephon(3, 'Lephon', Color(0xffeae9e0));

  final int value;
  final String label;
  final Color color;

  const Side(this.value, this.label, this.color);
}

enum RatingClass {
  past(0, 'Past', Color(0xff43a1a1)),
  present(1, 'Present', Color(0xff43a143)),
  future(2, 'Future',  Color(0xffac59ac)),
  beyond(3, 'Beyond', Color(0xffa04040)),
  eternal(4, 'Eternal', Color(0x7340a0));

  final int value;
  final String label;
  final Color color;

  const RatingClass(this.value, this.label, this.color);
}
