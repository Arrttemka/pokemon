import 'package:flutter/material.dart';

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
    const textColor = Colors.white;

    return Column(
      children: [
        Text(
          'Weight: $weight kg',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: textColor,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Height: $height cm',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: textColor,
          ),
        ),
      ],
    );
  }
}