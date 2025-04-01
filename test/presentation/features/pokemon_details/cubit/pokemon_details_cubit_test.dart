import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pokemon/domain/entities/pokemon_entity.dart';
import 'package:pokemon/domain/failures/failures.dart';
import 'package:pokemon/domain/usecases/get_pokemon_details_use_case.dart';
import 'package:pokemon/presentation/features/pokemon_details/cubit/pokemon_details_cubit.dart';

@GenerateMocks([GetPokemonDetailsUseCase])
import 'pokemon_details_cubit_test.mocks.dart';

void main() {
  late PokemonDetailsCubit cubit;
  late MockGetPokemonDetailsUseCase mockGetPokemonDetailsUseCase;

  setUp(() {
    mockGetPokemonDetailsUseCase = MockGetPokemonDetailsUseCase();
    cubit = PokemonDetailsCubit(getPokemonDetails: mockGetPokemonDetailsUseCase);
  });

  tearDown(() {
    cubit.close();
  });

  group('PokemonDetailsCubit', () {
    final testPokemon = PokemonEntity(
      id: 25,
      name: 'Pikachu',
      imageUrl: 'https://example.com/pikachu.png',
      types: ['electric'],
      weightInHg: 60,
      heightInDm: 4,
    );

    test('initial state should be PokemonDetailsInitial', () {
      expect(cubit.state, equals(PokemonDetailsInitial()));
    });

    test('should emit [Loading, Loaded] when data is gotten successfully', () async {
      when(mockGetPokemonDetailsUseCase(any))
          .thenAnswer((_) async => Right(testPokemon));

      final expectedStates = [
        PokemonDetailsLoading(),
        PokemonDetailsLoaded(pokemon: testPokemon),
      ];

      expectLater(cubit.stream, emitsInOrder(expectedStates));

      await cubit.loadPokemonDetails(25);
    });

    test('should emit [Loading, Error] when getting data fails with ServerFailure', () async {
      final failure = ServerFailure('Server error');
      when(mockGetPokemonDetailsUseCase(any))
          .thenAnswer((_) async => Left(failure));

      final expectedStates = [
        PokemonDetailsLoading(),
        PokemonDetailsError(failure: failure),
      ];

      expectLater(cubit.stream, emitsInOrder(expectedStates));

      await cubit.loadPokemonDetails(25);
    });

    test('should emit [Loading, Error] when getting data fails with NetworkFailure', () async {
      final failure = NetworkFailure('Network error');
      when(mockGetPokemonDetailsUseCase(any))
          .thenAnswer((_) async => Left(failure));

      final expectedStates = [
        PokemonDetailsLoading(),
        PokemonDetailsError(failure: failure),
      ];

      expectLater(cubit.stream, emitsInOrder(expectedStates));

      await cubit.loadPokemonDetails(25);
    });

    test('should call GetPokemonDetailsUseCase with correct id', () async {
      const testId = 25;
      when(mockGetPokemonDetailsUseCase(any))
          .thenAnswer((_) async => Right(testPokemon));

      await cubit.loadPokemonDetails(testId);

      verify(mockGetPokemonDetailsUseCase(testId));
    });

    test('should throw StateError when trying to emit after being closed', () async {
      await cubit.close();

      expect(() => cubit.loadPokemonDetails(25), throwsStateError);
    });
  });
}