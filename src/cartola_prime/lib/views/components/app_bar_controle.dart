import 'package:flutter/material.dart';

import 'resource_colors.dart';

class AppBarControler extends StatefulWidget with PreferredSizeWidget {
  // Preffered size required for PreferredSizeWidget extension
  final Size prefSize;
  // App bar title depending on the screen
  final String title;
  // A bool to check whether its a subpage or not.
  final bool isSubPage;
  // An example of search icon press.
  final bool hasSearchFunction;

  AppBarControler(
      {required this.title,
      this.isSubPage = false,
      this.hasSearchFunction = false,
      this.prefSize = const Size.fromHeight(56.0),
      Key? key})
      : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(56.0);

  @override
  State<AppBarControler> createState() => _AppBarControlerState();
}

class _AppBarControlerState extends State<AppBarControler> {
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
          onPressed: () {},
          icon: const Icon(Icons.settings),
        ),
      ],
    );
  }
}
