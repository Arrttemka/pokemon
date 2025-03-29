class PokemonEntity {
  final String name;
  final String imageUrl;
  final List<String> types;
  final double weight;
  final double height;

  const PokemonEntity({
    required this.name,
    required this.imageUrl,
    required this.types,
    required this.weight,
    required this.height,
  });
}