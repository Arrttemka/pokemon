import 'package:flutter/material.dart';
import 'presentation/pages/pokemon_details_page.dart';
import 'presentation/mocks/pokemon_mock_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final mockPokemon = mockPokemonDetail;

    return MaterialApp(

      title: 'PokeApp',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: PokemonDetailsPage(pokemon: mockPokemon),
      debugShowCheckedModeBanner: false,
    );
  }
}