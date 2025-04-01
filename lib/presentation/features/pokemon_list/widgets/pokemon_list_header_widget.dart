import 'package:flutter/material.dart';
import 'package:pokemon/core/theme/app_text_styles.dart';

class PokemonListHeader extends StatelessWidget {
  const PokemonListHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'PokeApp',
            style: AppTextStyles.headline,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          Text(
            'Pokemon list',
            style: AppTextStyles.title,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          Text(
            'Find the pokemon you want',
            style: AppTextStyles.subtitle,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}