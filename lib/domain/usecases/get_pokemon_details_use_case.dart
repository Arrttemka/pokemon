import 'package:dartz/dartz.dart';
import '../entities/pokemon_entity.dart';
import '../failures/failures.dart';
import '../repositories/pokemon_repository.dart';

class GetPokemonDetailsUseCase {
  final PokemonRepository repository;

  GetPokemonDetailsUseCase(this.repository);

  Future<Either<Failure, PokemonEntity>> call(int id) {
    return repository.getPokemonDetails(id);
  }
}