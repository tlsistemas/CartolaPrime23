import 'package:flutter/material.dart';

import 'resource_colors.dart';

class AppBarUpdateControler extends StatefulWidget
    implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onPressedUpdate;

  AppBarUpdateControler(
      {required this.title, required this.onPressedUpdate, Key? key})
      : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(56.0);

  @override
  State<AppBarUpdateControler> createState() => _AppBarUpdateControlerState();
}

class _AppBarUpdateControlerState extends State<AppBarUpdateControler> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const BackButton(
        color: Colors.white, // <-- SEE HERE
      ),
      centerTitle: true,
      title: Text(
        widget.title,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: backgroundColor,
      actions: [
        IconButton(
          color: Colors.white,
          onPressed: widget.onPressedUpdate,
          icon: const Icon(Icons.refresh),
        ),
      ],
    );
  }
}
