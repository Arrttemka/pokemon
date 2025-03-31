import 'dart:convert';
import 'package:pokemon/domain/entities/pokemon_entity.dart';

class PokemonModel extends PokemonEntity {
  const PokemonModel({
    required int id,
    required String name,
    required String imageUrl,
    required List<String> types,
    required int weightInHg,
    required int heightInDm,
  }) : super(
    id: id,
    name: name,
    imageUrl: imageUrl,
    types: types,
    weightInHg: weightInHg,
    heightInDm: heightInDm,
  );

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    return PokemonModel(
      id: json['id'],
      name: json['name'][0].toUpperCase() + json['name'].substring(1),
      imageUrl: json['sprites']['front_default'],
      types: (json['types'] as List)
          .map((type) => type['type']['name'] as String)
          .toList(),
      weightInHg: json['weight'],
      heightInDm: json['height'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'types': types,
      'weightInHg': weightInHg,
      'heightInDm': heightInDm,
    };
  }

  factory PokemonModel.fromEntity(PokemonEntity entity) {
    return PokemonModel(
      id: entity.id,
      name: entity.name,
      imageUrl: entity.imageUrl,
      types: entity.types,
      weightInHg: entity.weightInHg,
      heightInDm: entity.heightInDm,
    );
  }
}