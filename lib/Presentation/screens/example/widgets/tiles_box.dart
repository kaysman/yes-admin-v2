import 'package:faker/faker.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as mt;

import '../dashboard.dart';

class TilesBox extends StatelessWidget {
  const TilesBox({
    Key? key,
    required this.title,
    required this.faker,
    required this.color,
    required this.controller,
  }) : super(key: key);

  final Faker faker;
  final String title;
  final Color color;
  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          FluentPageRoute(builder: (context) => NextPage()),
        );
      },
      child: Container(
        color: color,
        child: Stack(
          alignment: Alignment.bottomCenter,
          clipBehavior: Clip.none,
          children: [
            buildTiles(context),
            Positioned(
              bottom: 10,
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(255, 225, 225, 225),
                        blurRadius: 12,
                      ),
                    ],
                  ),
                  child: Icon(mt.Icons.keyboard_arrow_down_rounded),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildTiles(BuildContext context) {
    return Column(
      children: [
        Text(title, style: FluentTheme.of(context).typography.title),
        Expanded(
          child: Column(
            children: List.generate(
              4,
              (index) => GestureDetector(
                onTap: () {},
                child: ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    color: Colors.teal,
                  ),
                  title: Text(
                    faker.company.name(),
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    faker.conference.name(),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}