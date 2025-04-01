import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon/data/models/pokemon_model.dart';

void main() {
  group('PokemonModel', () {
    final testModel = PokemonModel(
      id: 1,
      name: 'Bulbasaur',
      imageUrl: 'https://example.com/1.png',
      types: ['grass', 'poison'],
      weightInHg: 69,
      heightInDm: 7,
      localImagePath: null,
    );

    test('should create model with correct values', () {
      expect(testModel.id, 1);
      expect(testModel.name, 'Bulbasaur');
      expect(testModel.imageUrl, 'https://example.com/1.png');
      expect(testModel.types, ['grass', 'poison']);
      expect(testModel.weightInHg, 69);
      expect(testModel.heightInDm, 7);
      expect(testModel.localImagePath, null);
    });

    test('copyWithLocalImagePath should return new instance with updated path', () {
      const testPath = '/path/to/image.png';
      final updatedModel = testModel.copyWithLocalImagePath(testPath);

      expect(updatedModel.id, testModel.id);
      expect(updatedModel.name, testModel.name);
      expect(updatedModel.imageUrl, testModel.imageUrl);
      expect(updatedModel.types, testModel.types);
      expect(updatedModel.localImagePath, testPath);
    });
  });
}