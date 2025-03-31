import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/core/di/injection_container.dart';
import 'package:pokemon/domain/entities/pokemon_entity.dart';
import 'package:pokemon/presentation/cubits/pokemon_details_cubit.dart';
import 'package:pokemon/presentation/widgets/pokemon_back_button.dart';
import 'package:pokemon/presentation/widgets/pokemon_detail_info.dart';

class PokemonDetailsPage extends StatelessWidget {
  final PokemonEntity pokemon;

  const PokemonDetailsPage({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xFF3C2C2C);

    return BlocProvider(
      create: (_) => sl<PokemonDetailsCubit>()..loadPokemonDetails(pokemon.id),
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          title: const Text(
            'Pokemon Detail',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: backgroundColor,
          elevation: 0,
          leading: const PokemonBackButton(),
        ),
        body: SafeArea(
          child: BlocBuilder<PokemonDetailsCubit, PokemonDetailsState>(
            builder: (context, state) {
              if (state is PokemonDetailsInitial || state is PokemonDetailsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is PokemonDetailsError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Error: ${state.message}',
                        style: const TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          context.read<PokemonDetailsCubit>().loadPokemonDetails(pokemon.id);
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              } else if (state is PokemonDetailsLoaded) {
                return SingleChildScrollView(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: PokemonDetailInfo(pokemon: state.pokemon),
                    ),
                  ),
                );
              }

              // Fallback
              return const Center(child: Text('Something went wrong', style: TextStyle(color: Colors.white)));
            },
          ),
        ),
      ),
    );
  }
}