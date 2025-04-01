import 'package:pokemon/domain/entities/pokemon_entity.dart';

class PokemonModel extends PokemonEntity {
  final String? localImagePath;

  const PokemonModel({
    required int id,
    required String name,
    required String imageUrl,
    required List<String> types,
    required int weightInHg,
    required int heightInDm,
    this.localImagePath,
  }) : super(
    id: id,
    name: name,
    imageUrl: imageUrl,
    types: types,
    weightInHg: weightInHg,
    heightInDm: heightInDm,
  );

  PokemonModel copyWithLocalImagePath(String? path) {
    return PokemonModel(
      id: id,
      name: name,
      imageUrl: imageUrl,
      types: types,
      weightInHg: weightInHg,
      heightInDm: heightInDm,
      localImagePath: path,
    );
  }
}