import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/presentation/cubits/pokemon_details_cubit.dart';

class PokemonDetailsError extends StatelessWidget {
  final String message;
  final int pokemonId;

  const PokemonDetailsError({
    Key? key,
    required this.message,
    required this.pokemonId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Error: $message',
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              context.read<PokemonDetailsCubit>().loadPokemonDetails(pokemonId);
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}