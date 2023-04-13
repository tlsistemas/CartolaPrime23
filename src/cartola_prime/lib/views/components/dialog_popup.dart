import 'package:flutter/material.dart';

class DialogPopUp extends StatelessWidget {
  const DialogPopUp(
      {Key? key,
      required this.header,
      required this.body,
      required this.isCancel,
      required this.isOk})
      : super(key: key);

  final String? header;
  final String? body;
  final bool isCancel;
  final bool isOk;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(header!),
      content: Text(body!),
      actions: <Widget>[
        Visibility(
          visible: isCancel,
          child: TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
        ),
        Visibility(
          visible: isOk,
          child: TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ),
      ],
    );
  }
}
