import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon/data/mappers/pokemon_mapper.dart';
import 'package:pokemon/data/models/pokemon_model.dart';
import 'package:pokemon/domain/entities/pokemon_entity.dart';

void main() {
  group('PokemonMapper', () {
    final Map<String, dynamic> testJson = {
      'id': 25,
      'name': 'pikachu',
      'sprites': {
        'front_default': 'https://example.com/pikachu.png'
      },
      'types': [
        {'type': {'name': 'electric'}},
        {'type': {'name': 'normal'}}
      ],
      'weight': 60,
      'height': 4
    };

    final PokemonModel testModel = PokemonModel(
      id: 25,
      name: 'Pikachu',
      imageUrl: 'https://example.com/pikachu.png',
      types: ['electric', 'normal'],
      weightInHg: 60,
      heightInDm: 4,
      localImagePath: '/path/to/local/image.png',
    );

    final PokemonEntity testEntity = PokemonEntity(
      id: 25,
      name: 'Pikachu',
      imageUrl: 'https://example.com/pikachu.png',
      types: ['electric', 'normal'],
      weightInHg: 60,
      heightInDm: 4,
    );

    test('fromJson should properly convert JSON to PokemonModel', () {

      final result = PokemonMapper.fromJson(testJson);


      expect(result.id, 25);
      expect(result.name, 'Pikachu');
      expect(result.imageUrl, 'https://example.com/pikachu.png');
      expect(result.types, ['electric', 'normal']);
      expect(result.weightInHg, 60);
      expect(result.heightInDm, 4);
    });

    test('toJson should properly convert PokemonModel to JSON', () {

      final result = PokemonMapper.toJson(testModel);


      expect(result['id'], 25);
      expect(result['name'], 'Pikachu');
      expect(result['imageUrl'], 'https://example.com/pikachu.png');
      expect(result['types'], ['electric', 'normal']);
      expect(result['weightInHg'], 60);
      expect(result['heightInDm'], 4);
    });

    test('fromEntity should properly convert PokemonEntity to PokemonModel', () {

      final result = PokemonMapper.fromEntity(testEntity);


      expect(result.id, testEntity.id);
      expect(result.name, testEntity.name);
      expect(result.imageUrl, testEntity.imageUrl);
      expect(result.types, testEntity.types);
      expect(result.weightInHg, testEntity.weightInHg);
      expect(result.heightInDm, testEntity.heightInDm);
      expect(result.localImagePath, null);
    });

    test('toEntity should properly convert PokemonModel to PokemonEntity', () {

      final result = PokemonMapper.toEntity(testModel);

      expect(result.id, testModel.id);
      expect(result.name, testModel.name);
      expect(result.imageUrl, testModel.imageUrl);
      expect(result.types, testModel.types);
      expect(result.weightInHg, testModel.weightInHg);
      expect(result.heightInDm, testModel.heightInDm);
    });

    test('toMap should correctly convert PokemonModel to Map for database', () {

      final result = PokemonMapper.toMap(testModel);


      expect(result['id'], 25);
      expect(result['name'], 'Pikachu');
      expect(result['imageUrl'], 'https://example.com/pikachu.png');
      expect(result['types'], json.encode(['electric', 'normal']));
      expect(result['weightInHg'], 60);
      expect(result['heightInDm'], 4);
      expect(result['localImagePath'], '/path/to/local/image.png');
    });

    test('fromMap should correctly convert Map to PokemonModel from database', () {
      final Map<String, dynamic> testMap = {
        'id': 25,
        'name': 'Pikachu',
        'imageUrl': 'https://example.com/pikachu.png',
        'types': json.encode(['electric', 'normal']),
        'weightInHg': 60,
        'heightInDm': 4,
        'localImagePath': '/path/to/local/image.png',
      };

      final result = PokemonMapper.fromMap(testMap);

      expect(result.id, 25);
      expect(result.name, 'Pikachu');
      expect(result.imageUrl, 'https://example.com/pikachu.png');
      expect(result.types, ['electric', 'normal']);
      expect(result.weightInHg, 60);
      expect(result.heightInDm, 4);
      expect(result.localImagePath, '/path/to/local/image.png');
    });
  });
}