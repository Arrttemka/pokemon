import 'package:flutter/material.dart';
import 'package:pokemon/core/theme/app_text_styles.dart';

class PokemonCardInfo extends StatelessWidget {
  final String name;
  final int id;

  const PokemonCardInfo({
    Key? key,
    required this.name,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: AppTextStyles.cardTitle,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Text(
          '#$id',
          style: AppTextStyles.cardSubtitle,
        ),
      ],
    );
  }
}