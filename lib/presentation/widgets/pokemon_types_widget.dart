import 'package:flutter/material.dart';
import 'package:pokemon/core/theme/app_colors.dart';
import 'package:pokemon/core/theme/app_text_styles.dart';

class PokemonTypesWidget extends StatelessWidget {
  final List<String> types;

  const PokemonTypesWidget({
    Key? key,
    required this.types,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      children: types.map((type) {
        return Chip(
          label: Text(
            type,
            style: AppTextStyles.pokemonType,
          ),
          backgroundColor: AppColors.chipBackground,
        );
      }).toList(),
    );
  }
}