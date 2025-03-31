import 'package:flutter/material.dart';
import 'package:pokemon/presentation/widgets/pokemon_back_button.dart';

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
      leading: const PokemonBackButton(),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}