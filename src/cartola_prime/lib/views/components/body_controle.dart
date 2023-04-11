import 'package:flutter/material.dart';

import '../../models/dto/lesson_dto.dart';
import 'make_list_tile.dart';

class BodyControle extends StatelessWidget {
  const BodyControle({Key? key, required this.item}) : super(key: key);

  final Lesson item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Card(
        elevation: 8.0,
        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Container(
          decoration:
              const BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
          child: MarkeListTile(key: key, lesson: item),
        ),
      ),
    );
  }
}
