import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/core/di/injection_container.dart';
import 'package:pokemon/domain/entities/pokemon_entity.dart';
import 'package:pokemon/presentation/features/pokemon_details/cubit/pokemon_details_cubit.dart';
import 'package:pokemon/presentation/widgets/index.dart';

class PokemonDetailsPage extends StatelessWidget {
  final PokemonEntity pokemon;
  static const backgroundColor = Color(0xFF3C2C2C);

  const PokemonDetailsPage({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<PokemonDetailsCubit>()..loadPokemonDetails(pokemon.id),
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: const PokemonDetailsAppBar(),
        body: SafeArea(
          child: BlocBuilder<PokemonDetailsCubit, PokemonDetailsState>(
            builder: (context, state) {
              return PokemonDetailsStateBuilder(
                state: state,
                initialPokemon: pokemon,
              );
            },
          ),
        ),
      ),
    );
  }
}