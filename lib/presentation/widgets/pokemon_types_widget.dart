import 'package:flutter/material.dart';

class PokemonTypesWidget extends StatelessWidget {
  final List<String> types;

  const PokemonTypesWidget({
    Key? key,
    required this.types,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const textColor = Colors.white;

    return Wrap(
      spacing: 8.0,
      children: types.map((type) {
        return Chip(
          label: Text(
            type,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: textColor,
            ),
          ),
          backgroundColor: Colors.grey[800],
        );
      }).toList(),
    );
  }
}