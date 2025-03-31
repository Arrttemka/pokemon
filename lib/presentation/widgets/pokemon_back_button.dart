import 'package:flutter/material.dart';
import 'package:pokemon/core/di/injection_container.dart';
import 'package:pokemon/core/navigation/app_navigator.dart';

class PokemonBackButton extends StatelessWidget {
  final Color? iconColor;

  const PokemonBackButton({
    Key? key,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back,
        color: iconColor ?? Colors.white,
      ),
      onPressed: () => sl<AppNavigator>().goBack(),
    );
  }
}