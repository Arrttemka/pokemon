// lib/presentation/pages/pokemon_list_page.dart

import 'package:flutter/material.dart';
import '../../domain/entities/pokemon_entity.dart';
import '../mocks/pokemon_mock_data.dart';
import '../widgets/pokemon_card.dart';

class PokemonListPage extends StatelessWidget {
   PokemonListPage({Key? key}) : super(key: key);

  // Пока используем готовые моковые данные
  final List<PokemonEntity> pokemons = mockPokemons;

  @override
  Widget build(BuildContext context) {
    // Цвета можно вынести в отдельный файл (палитру / тему), но пока оставим здесь для примера
    const backgroundColor = Color(0xFF3C2C2C);
    const cardColor = Color(0xFF4A3A3A);
    const textColor = Colors.white;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          // Прокрутка всей области
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'PokeApp',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Pokemon list',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: textColor,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Find the pokemon you want',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: textColor.withOpacity(0.8),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),

                ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: 0,
                    maxHeight: MediaQuery.of(context).size.height * 0.8,
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: pokemons.length,
                    itemBuilder: (context, index) {
                      final pokemon = pokemons[index];
                      return PokemonCard(
                        pokemon: pokemon,
                        cardColor: cardColor,
                        textColor: textColor,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}