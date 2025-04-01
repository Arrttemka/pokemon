import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon/domain/entities/pokemon_entity.dart';
import 'package:pokemon/domain/failures/failures.dart';
import 'package:pokemon/presentation/features/pokemon_details/cubit/pokemon_details_cubit.dart';

void main() {
  group('PokemonDetailsState', () {
    final testPokemon = PokemonEntity(
      id: 25,
      name: 'Pikachu',
      imageUrl: 'https://example.com/pikachu.png',
      types: ['electric'],
      weightInHg: 60,
      heightInDm: 4,
    );

    test('PokemonDetailsInitial props should be empty', () {
      expect(PokemonDetailsInitial().props, []);
    });

    test('PokemonDetailsLoading props should be empty', () {
      expect(PokemonDetailsLoading().props, []);
    });

    test('PokemonDetailsLoaded props should contain pokemon', () {
      final state = PokemonDetailsLoaded(pokemon: testPokemon);
      expect(state.props, [testPokemon]);
    });

    test('PokemonDetailsError props should contain failure', () {
      final failure = ServerFailure('Error message');
      final state = PokemonDetailsError(failure: failure);
      expect(state.props, [failure]);
    });

    test('PokemonDetailsStates with same data should be equal', () {
      expect(PokemonDetailsInitial(), PokemonDetailsInitial());
      expect(PokemonDetailsLoading(), PokemonDetailsLoading());
      expect(
        PokemonDetailsLoaded(pokemon: testPokemon),
        PokemonDetailsLoaded(pokemon: testPokemon),
      );

      final failure = ServerFailure('Error message');
      expect(
        PokemonDetailsError(failure: failure),
        PokemonDetailsError(failure: failure),
      );
    });

    test('PokemonDetailsStates with different data should not be equal', () {
      final pokemon1 = PokemonEntity(
        id: 25,
        name: 'Pikachu',
        imageUrl: 'https://example.com/pikachu.png',
        types: ['electric'],
        weightInHg: 60,
        heightInDm: 4,
      );

      final pokemon2 = PokemonEntity(
        id: 1,
        name: 'Bulbasaur',
        imageUrl: 'https://example.com/bulbasaur.png',
        types: ['grass', 'poison'],
        weightInHg: 69,
        heightInDm: 7,
      );

      expect(
        PokemonDetailsLoaded(pokemon: pokemon1),
        isNot(equals(PokemonDetailsLoaded(pokemon: pokemon2))),
      );

      final failure1 = ServerFailure('Error 1');
      final failure2 = ServerFailure('Error 2');
      expect(
        PokemonDetailsError(failure: failure1),
        isNot(equals(PokemonDetailsError(failure: failure2))),
      );
    });

    test('toString methods should contain class name and properties', () {
      expect(
        PokemonDetailsInitial().toString(),
        'PokemonDetailsInitial()',
      );

      expect(
        PokemonDetailsLoading().toString(),
        'PokemonDetailsLoading()',
      );

      expect(
        PokemonDetailsLoaded(pokemon: testPokemon).toString(),
        contains('PokemonDetailsLoaded'),
      );

      final failure = ServerFailure('Error message');
      expect(
        PokemonDetailsError(failure: failure).toString(),
        contains('PokemonDetailsError'),
      );
    });
  });
}