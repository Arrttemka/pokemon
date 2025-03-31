import 'package:flutter/material.dart';
import 'package:pokemon/domain/entities/pokemon_entity.dart';
import 'package:pokemon/presentation/widgets/pokemon_details/pokemon_detail_info.dart';

class PokemonDetailsContent extends StatelessWidget {
  final PokemonEntity pokemon;

  const PokemonDetailsContent({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: PokemonDetailInfo(pokemon: pokemon),
        ),
      ),
    );
  }
}