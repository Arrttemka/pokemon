import 'package:flutter/material.dart';
import 'package:pokemon/core/navigation/app_routes.dart';
import 'package:pokemon/core/navigation/route_arguments.dart';
import 'package:pokemon/domain/entities/pokemon_entity.dart';

class AppNavigator {
  final GlobalKey<NavigatorState> navigatorKey;

  AppNavigator({required this.navigatorKey});

  Future<dynamic> navigateToPokemonDetails(PokemonEntity pokemon) {
    return navigatorKey.currentState!.pushNamed(
      AppRoutes.pokemonDetails,
      arguments: PokemonDetailsArguments(pokemon: pokemon),
    );
  }

  void goBack() {
    navigatorKey.currentState!.pop();
  }
}