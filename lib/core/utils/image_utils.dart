import 'dart:io';
import 'package:pokemon/data/models/pokemon_model.dart';
import 'package:pokemon/domain/entities/pokemon_entity.dart';

class ImageUtils {
  static bool hasLocalImage(PokemonEntity pokemon) {
    final pokemonModel = pokemon is PokemonModel ? pokemon as PokemonModel : null;
    return pokemonModel?.localImagePath != null &&
        File(pokemonModel!.localImagePath!).existsSync();
  }
}