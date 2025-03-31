import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pokemon/core/di/injection_container.dart';
import 'package:pokemon/core/navigation/app_navigator.dart';
import 'package:pokemon/core/theme/app_colors.dart';
import 'package:pokemon/domain/entities/pokemon_entity.dart';
import '../../../data/models/pokemon_model.dart';
import 'pokemon_card_info.dart';
import 'pokemon_card_image.dart';

class PokemonCard extends StatelessWidget {
  final PokemonEntity pokemon;

  const PokemonCard({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pokemonModel = pokemon is PokemonModel ? pokemon as PokemonModel : null;
    final localImagePath = pokemonModel?.localImagePath;

    return GestureDetector(
      onTap: () {
        sl<AppNavigator>().navigateToPokemonDetails(pokemon);
      },
      child: Card(
        color: AppColors.cardBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: PokemonCardInfo(
                  name: pokemon.name,
                  id: pokemon.id,
                ),
              ),
              const SizedBox(width: 16),
              PokemonCardImage(
                imageUrl: pokemon.imageUrl,
                localImagePath: localImagePath,
              ),
            ],
          ),
        ),
      ),
    );
  }
}