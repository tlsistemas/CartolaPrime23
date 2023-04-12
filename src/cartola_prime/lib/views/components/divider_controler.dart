import 'package:flutter/material.dart';
import 'package:path/path.dart';

class DividerControler extends StatelessWidget {
  const DividerControler({Key? key, required String? texto})
      : _texto = texto,
        super(key: key);

  final String? _texto;

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Expanded(
        child: Container(
            margin: const EdgeInsets.only(left: 10.0, right: 15.0),
            child: const Divider(
              color: Colors.white,
              height: 20,
            )),
      ),
      Text(
        _texto!,
        style: const TextStyle(color: Colors.white),
      ),
      Expanded(
        child: Container(
            margin: const EdgeInsets.only(left: 15.0, right: 10.0),
            child: const Divider(
              color: Colors.white,
              height: 20,
            )),
      ),
    ]);
  }
}
