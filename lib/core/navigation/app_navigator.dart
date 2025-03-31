import 'package:flutter/material.dart';
import 'package:pokemon/core/navigation/app_routes.dart';
import 'package:pokemon/core/navigation/route_arguments.dart';
import 'package:pokemon/domain/entities/pokemon_entity.dart';

class AppNavigator {
  final GlobalKey<NavigatorState> navigatorKey;

  AppNavigator({required this.navigatorKey});

  BuildContext? get _context => navigatorKey.currentContext;

  Future<void> navigateToPokemonDetails(PokemonEntity pokemon) async {
    if (_context != null) {
      await Navigator.of(_context!).pushNamed(
        AppRoutes.pokemonDetails,
        arguments: PokemonDetailsArguments(pokemon: pokemon),
      );
    }
  }

  void goBack() {
    if (_context != null && Navigator.of(_context!).canPop()) {
      Navigator.of(_context!).pop();
    }
  }
}