import 'package:flutter/material.dart';
import '../../../../../domain/entities/pokemon_entity.dart';
import 'package:pokemon/presentation/widgets/index.dart';
import '../../../../../data/models/pokemon_model.dart';

class PokemonDetailInfo extends StatelessWidget {
  final PokemonEntity pokemon;

  const PokemonDetailInfo({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pokemonModel = pokemon is PokemonModel ? pokemon as PokemonModel : null;
    final localImagePath = pokemonModel?.localImagePath;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        PokemonNameWidget(name: pokemon.name),
        const SizedBox(height: 16),
        PokemonImageWidget(
          imageUrl: pokemon.imageUrl,
          localImagePath: localImagePath,
        ),
        const SizedBox(height: 16),
        PokemonTypesWidget(types: pokemon.types),
        const SizedBox(height: 16),
        PokemonPhysicalInfoWidget(
          weight: pokemon.weight,
          height: pokemon.height,
        ),
      ],
    );
  }
}