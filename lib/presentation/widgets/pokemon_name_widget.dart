import 'package:flutter/material.dart';

class PokemonNameWidget extends StatelessWidget {
  final String name;

  const PokemonNameWidget({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const textColor = Colors.white;

    return Text(
      name,
      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
        color: textColor,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }
}