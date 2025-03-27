// lib/presentation/widgets/pokemon_card.dart

import 'package:flutter/material.dart';
import '../../domain/entities/pokemon_entity.dart';

class PokemonCard extends StatelessWidget {
  final PokemonEntity pokemon;
  final Color cardColor;
  final Color textColor;

  const PokemonCard({
    Key? key,
    required this.pokemon,
    required this.cardColor,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Имя покемона
            Expanded(
              child: Text(
                pokemon.name,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: textColor,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 16),
            // Картинка покемона
            Image.network(
              pokemon.imageUrl,
              width: 50,
              height: 50,
              errorBuilder: (_, __, ___) {
                return const Icon(Icons.error, color: Colors.red);
              },
            ),
          ],
        ),
      ),
    );
  }
}