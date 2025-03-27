import 'package:flutter/material.dart';
import '../../domain/entities/pokemon_entity.dart';
import '../widgets/pokemon_detail_info.dart';

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
        title: const Text('Pokemon Detail'),
        backgroundColor: backgroundColor,
        elevation: 0,
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