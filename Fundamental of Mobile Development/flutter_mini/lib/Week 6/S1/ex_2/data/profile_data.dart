import 'package:flutter/material.dart';
import 'package:flutter_mini/Week 6/S1/ex_2/model/profile_tile_model.dart';

ProfileData manutProfile = ProfileData(
  name: "Manut",
  position: "Flutter Developer",
  avatarUrl: 'assets/week-6/avatar.gif',
  tiles: [
    TileData(icon: Icons.phone, title: "Phone Number", value: "+123 456 7890"),
    TileData(icon: Icons.location_on, title: "Address", value: "123 Cambodia"),
    TileData(icon: Icons.email, title: "Mail", value: "manut.hout@student.cadt.edu.kh"),
  ],
);

