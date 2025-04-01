import 'package:pokemon/data/models/pokemon_list_response_model.dart';

class PokemonListMapper {
  static PokemonListResponseModel fromJson(Map<String, dynamic> json) {
    return PokemonListResponseModel(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      results: (json['results'] as List)
          .map((result) => itemFromJson(result))
          .toList(),
    );
  }

  static PokemonListItemModel itemFromJson(Map<String, dynamic> json) {
    return PokemonListItemModel(
      name: json['name'],
      url: json['url'],
    );
  }
}