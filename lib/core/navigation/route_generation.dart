import 'package:flutter/material.dart';
import 'package:pokemon/core/navigation/app_routes.dart';
import 'package:pokemon/core/navigation/route_arguments.dart';
import 'package:pokemon/presentation/pages/pokemon_details_page.dart';
import 'package:pokemon/presentation/pages/pokemon_list_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.pokemonList:
        return MaterialPageRoute(
          builder: (_) => const PokemonListPage(),
        );
      case AppRoutes.pokemonDetails:
        final args = settings.arguments as PokemonDetailsArguments;
        return MaterialPageRoute(
          builder: (_) => PokemonDetailsPage(pokemon: args.pokemon),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}