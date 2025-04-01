import 'package:dartz/dartz.dart';
import '../entities/pokemon_entity.dart';
import '../failures/failures.dart';
import '../repositories/pokemon_repository.dart';

class GetPokemonListUseCase {
  final PokemonRepository repository;

  GetPokemonListUseCase(this.repository);

  Future<Either<Failure, List<PokemonEntity>>> call(int offset, int limit) {
    return repository.getPokemonList(offset, limit);
  }
}