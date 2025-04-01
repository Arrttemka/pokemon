import 'package:flutter/material.dart';
import 'package:pokemon/core/di/injection_container.dart';
import 'package:pokemon/core/navigation/app_navigator.dart';

class PokemonDetailsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color backgroundColor;

  const PokemonDetailsAppBar({
    Key? key,
    this.title = 'Pokemon Detail',
    this.backgroundColor = const Color(0xFF3C2C2C),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: backgroundColor,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {
          sl<AppNavigator>().goBack();
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}