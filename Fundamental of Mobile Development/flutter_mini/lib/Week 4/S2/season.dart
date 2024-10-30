import 'package:flutter/material.dart';




enum Seasons {
  spring,
  summer,
  fall,
  winter;

  static Seasons after(Seasons season) {
    switch (season) {
      case Seasons.spring:
        return Seasons.summer;
      case Seasons.summer:
        return Seasons.fall;
      case Seasons.fall:
        return Seasons.winter;
      case Seasons.winter:
        return Seasons.spring;
    }
  }
}


void main() {
  runApp(Material());
}