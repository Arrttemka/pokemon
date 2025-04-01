import 'package:flutter/material.dart';
import 'package:pokemon/core/theme/app_text_styles.dart';

class PokemonPhysicalInfoWidget extends StatelessWidget {
  final double weight;
  final double height;

  const PokemonPhysicalInfoWidget({
    Key? key,
    required this.weight,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Weight: $weight kg',
          style: AppTextStyles.physicalInfo,
        ),
        const SizedBox(height: 8),
        Text(
          'Height: $height cm',
          style: AppTextStyles.physicalInfo,
        ),
      ],
    );
  }
}