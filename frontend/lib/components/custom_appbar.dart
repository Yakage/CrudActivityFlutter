import 'package:flutter/material.dart';

class AppBarAll extends StatelessWidget implements PreferredSizeWidget{
  final String title;
  const AppBarAll({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blue[200],
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      elevation: 2,
      centerTitle: true,
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
