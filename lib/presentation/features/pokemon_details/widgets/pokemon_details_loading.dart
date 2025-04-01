import 'package:flutter/material.dart';

class PokemonDetailsLoading extends StatelessWidget {
  const PokemonDetailsLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}