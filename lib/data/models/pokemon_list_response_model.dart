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
}

class PokemonListItemModel {
  final String name;
  final String url;

  PokemonListItemModel({
    required this.name,
    required this.url,
  });

  int get id {
    final uri = Uri.parse(url);
    final pathSegments = uri.pathSegments;
    final idString = pathSegments[pathSegments.length - 2];
    return int.parse(idString);
  }
}