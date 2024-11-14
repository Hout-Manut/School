import 'package:flutter/material.dart';

import 'package:flutter_mini/Week 6/S1/ex_2/model/profile_tile_model.dart';
import 'package:flutter_mini/Week 6/S1/ex_2//data/profile_data.dart';

void main() {
  runApp(ProfileApp(manutProfile));
}

const Color mainColor = Color(0xff5E9FCD);

class ProfileApp extends StatelessWidget {
  final ProfileData profile;
  const ProfileApp(this.profile, {super.key});

  Iterable<Widget> buildTiles() {
    return profile.tiles.map(
      (tile) => ProfileTile(
        icon: tile.icon,
        title: tile.title,
        data: tile.value,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double avartarRadius = 60;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: mainColor,
          centerTitle: true,
          title: const Text(
            "CADT student Profile",
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Color(0xffc2d8ed),
        body: Center(
          child: Column(
            children: [
              SizedBox(height: 40),
              CircleAvatar(
                radius: avartarRadius,
                backgroundImage: AssetImage(profile.avatarUrl),
                child: Container(
                  height: avartarRadius * 2,
                  width: avartarRadius * 2,
                  decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(avartarRadius)),
                ),
              ),
              SizedBox(height: 20),
              Text(
                profile.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: mainColor,
                ),
              ),
              Text(
                profile.position,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 400,
                child: ListView(
                  children: [
                    SizedBox(height: 10),
                    ...buildTiles(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileTile extends StatelessWidget {
  const ProfileTile({
    super.key,
    required this.icon,
    required this.title,
    required this.data,
  });

  final IconData icon;
  final String title;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: ListTile(
          leading: Icon(icon, color: mainColor),
          title: Text(title),
          subtitle: Text(data),
        ),
      ),
    );
  }
}
