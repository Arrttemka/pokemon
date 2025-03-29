class PokemonEntity {
  final int id;
  final String name;
  final String imageUrl;
  final List<String> types;
  final int weightInHg;
  final int heightInDm;

  const PokemonEntity({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.types = const [],
    this.weightInHg = 0,
    this.heightInDm = 0,
  });

  double get weightInKg => weightInHg / 10;
  double get heightInCm => heightInDm * 10;
}