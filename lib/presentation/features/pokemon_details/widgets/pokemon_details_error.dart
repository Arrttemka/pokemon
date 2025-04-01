import 'package:flutter/material.dart';
import 'package:pokemon/core/di/injection_container.dart';
import 'package:pokemon/presentation/features/pokemon_details/cubit/pokemon_details_cubit.dart';
import 'package:pokemon/core/theme/app_colors.dart';

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
            style: const TextStyle(color: AppColors.textPrimary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              sl<PokemonDetailsCubit>().loadPokemonDetails(pokemonId);
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}