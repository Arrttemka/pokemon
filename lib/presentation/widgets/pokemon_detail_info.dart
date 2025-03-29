import 'package:flutter/material.dart';
import '../../domain/entities/pokemon_entity.dart';

class PokemonDetailInfo extends StatelessWidget {
  final PokemonEntity pokemon;

  const PokemonDetailInfo({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const textColor = Colors.white;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          pokemon.name,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Image.network(
          pokemon.imageUrl,
          width: 200,
          height: 200,
          errorBuilder: (_, __, ___) {
            return const Icon(Icons.error, color: Colors.red);
          },
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8.0,
          children: pokemon.types.map((type) {
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
        ),
        const SizedBox(height: 16),
        Text(
          'Weight: ${pokemon.weight} kg',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: textColor,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Height: ${pokemon.height} cm',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: textColor,
          ),
        ),
      ],
    );
  }
}