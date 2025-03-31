import 'package:flutter/material.dart';

class PokemonCardInfo extends StatelessWidget {
  final String name;
  final int id;
  final Color textColor;

  const PokemonCardInfo({
    Key? key,
    required this.name,
    required this.id,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: textColor,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Text(
          '#$id',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: textColor.withOpacity(0.7),
          ),
        ),
      ],
    );
  }
}