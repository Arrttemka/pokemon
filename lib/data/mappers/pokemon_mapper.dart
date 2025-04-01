import 'dart:convert';
import 'package:pokemon/data/models/pokemon_model.dart';
import 'package:pokemon/domain/entities/pokemon_entity.dart';

class PokemonMapper {
  static PokemonModel fromJson(Map<String, dynamic> json) {
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

  static Map<String, dynamic> toJson(PokemonModel model) {
    return {
      'id': model.id,
      'name': model.name,
      'imageUrl': model.imageUrl,
      'types': model.types,
      'weightInHg': model.weightInHg,
      'heightInDm': model.heightInDm,
    };
  }

  static PokemonModel fromEntity(PokemonEntity entity) {
    return PokemonModel(
      id: entity.id,
      name: entity.name,
      imageUrl: entity.imageUrl,
      types: entity.types,
      weightInHg: entity.weightInHg,
      heightInDm: entity.heightInDm,
    );
  }

  static PokemonEntity toEntity(PokemonModel model) {
    return PokemonEntity(
      id: model.id,
      name: model.name,
      imageUrl: model.imageUrl,
      types: model.types,
      weightInHg: model.weightInHg,
      heightInDm: model.heightInDm,
    );
  }

  static Map<String, dynamic> toMap(PokemonModel model) {
    return {
      'id': model.id,
      'name': model.name,
      'imageUrl': model.imageUrl,
      'types': json.encode(model.types),
      'weightInHg': model.weightInHg,
      'heightInDm': model.heightInDm,
      'localImagePath': model.localImagePath,
    };
  }

  static PokemonModel fromMap(Map<String, dynamic> map) {
    return PokemonModel(
      id: map['id'],
      name: map['name'],
      imageUrl: map['imageUrl'],
      types: List<String>.from(json.decode(map['types'])),
      weightInHg: map['weightInHg'],
      heightInDm: map['heightInDm'],
      localImagePath: map['localImagePath'],
    );
  }
}