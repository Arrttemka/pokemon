import 'package:flutter/material.dart';
import 'package:pokemon/core/theme/app_text_styles.dart';

class PokemonNameWidget extends StatelessWidget {
  final String name;

  const PokemonNameWidget({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: AppTextStyles.pokemonName,
      textAlign: TextAlign.center,
    );
  }
}