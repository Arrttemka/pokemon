import 'package:flutter/material.dart';
import 'package:pokemon/domain/entities/pokemon_entity.dart';
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

    return Scaffold(
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
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: PokemonDetailInfo(pokemon: pokemon),
            ),
          ),
        ),
      ),
    );
  }
}