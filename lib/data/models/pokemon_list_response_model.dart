class PokemonListResponseModel {
  final int count;
  final String? next;
  final String? previous;
  final List<PokemonListItemModel> results;

  PokemonListResponseModel({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  factory PokemonListResponseModel.fromJson(Map<String, dynamic> json) {
    return PokemonListResponseModel(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      results: (json['results'] as List)
          .map((result) => PokemonListItemModel.fromJson(result))
          .toList(),
    );
  }
}

class PokemonListItemModel {
  final String name;
  final String url;

  PokemonListItemModel({
    required this.name,
    required this.url,
  });

  factory PokemonListItemModel.fromJson(Map<String, dynamic> json) {
    return PokemonListItemModel(
      name: json['name'],
      url: json['url'],
    );
  }

  int get id {
    // Extract ID from URL
    final uri = Uri.parse(url);
    final pathSegments = uri.pathSegments;
    final idString = pathSegments[pathSegments.length - 2];
    return int.parse(idString);
  }
}