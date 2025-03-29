import 'package:dartz/dartz.dart';
import '../entities/pokemon_entity.dart';
import '../failures/failures.dart';

abstract class PokemonRepository {
  Future<Either<Failure, List<PokemonEntity>>> getPokemonList(int offset, int limit);
  Future<Either<Failure, PokemonEntity>> getPokemonDetails(int id);
}