import 'package:flutter/material.dart';

import '../screens/auth_page.dart';
import '../../models/lesson.dart';

class MarkeListTile extends StatelessWidget {
  const MarkeListTile({Key? key, required Lesson? lesson})
      : lessonItens = lesson,
        super(key: key);

  final Lesson? lessonItens;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Container(
          padding: const EdgeInsets.only(right: 12.0),
          decoration: const BoxDecoration(
              border:
                  Border(right: BorderSide(width: 1.0, color: Colors.white24))),
          child: const Icon(Icons.autorenew, color: Colors.white),
        ),
        title: Text(
          lessonItens!.title,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

        subtitle: Row(
          children: <Widget>[
            Expanded(
                flex: 1,
                child: SizedBox(
                  // tag: 'hero',
                  child: LinearProgressIndicator(
                      backgroundColor: const Color.fromRGBO(209, 224, 224, 0.2),
                      value: lessonItens!.indicatorValue,
                      valueColor: const AlwaysStoppedAnimation(Colors.green)),
                )),
            Expanded(
              flex: 4,
              child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(lessonItens!.level,
                      style: const TextStyle(color: Colors.white))),
            )
          ],
        ),
        trailing: const Icon(Icons.keyboard_arrow_right,
            color: Colors.white, size: 30.0),
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AuthPage()));
        },
      ),
    );
  }
}
