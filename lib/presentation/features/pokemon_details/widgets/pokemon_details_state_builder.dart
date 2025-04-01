import 'package:flutter/material.dart';
import 'package:pokemon/core/di/injection_container.dart';
import 'package:pokemon/domain/entities/pokemon_entity.dart';
import 'package:pokemon/presentation/features/pokemon_details/cubit/pokemon_details_cubit.dart';
import 'pokemon_details_content.dart';
import 'pokemon_details_error.dart' as widgets;
import 'pokemon_details_loading.dart' as widgets;

class PokemonDetailsStateBuilder extends StatelessWidget {
  final PokemonDetailsState state;
  final PokemonEntity initialPokemon;

  const PokemonDetailsStateBuilder({
    Key? key,
    required this.state,
    required this.initialPokemon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (state is PokemonDetailsInitial || state is PokemonDetailsLoading) {
      return const widgets.PokemonDetailsLoading();
    } else if (state is PokemonDetailsError) {
      final errorState = state as PokemonDetailsError;
      return widgets.PokemonDetailsError(
        message: errorState.message,
        pokemonId: initialPokemon.id,
      );
    } else if (state is PokemonDetailsLoaded) {
      final loadedState = state as PokemonDetailsLoaded;
      return PokemonDetailsContent(pokemon: loadedState.pokemon);
    }

    return const Center(
      child: Text(
        'Something went wrong',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}