import 'package:dartz/dartz.dart';
import 'package:pokemon/core/error/exceptions.dart';
import 'package:pokemon/core/network/network_info.dart';
import 'package:pokemon/data/datasources/pokemon_local_data_source.dart';
import 'package:pokemon/data/datasources/pokemon_remote_data_source.dart';
import 'package:pokemon/data/models/pokemon_model.dart';
import 'package:pokemon/domain/entities/pokemon_entity.dart';
import 'package:pokemon/domain/failures/failures.dart';
import 'package:pokemon/domain/repositories/pokemon_repository.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonRemoteDataSource remoteDataSource;
  final PokemonLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PokemonRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<PokemonEntity>>> getPokemonList(int offset, int limit) async {
    if (await networkInfo.isConnected) {
      try {
        final remotePokemons = await remoteDataSource.getPokemonList(offset, limit);

        final List<PokemonModel> detailedPokemons = [];
        for (final pokemon in remotePokemons.results) {
          try {
            final pokemonDetail = await remoteDataSource.getPokemonDetails(pokemon.id);
            detailedPokemons.add(pokemonDetail);
          } catch (e) {
            // Skip this pokemon and continue with others
            continue;
          }
        }

        await localDataSource.cachePokemonList(detailedPokemons);
        return Right(detailedPokemons);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      try {
        final localPokemons = await localDataSource.getCachedPokemonList();
        return Right(localPokemons);
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      }
    }
  }

  @override
  Future<Either<Failure, PokemonEntity>> getPokemonDetails(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final remotePokemon = await remoteDataSource.getPokemonDetails(id);
        await localDataSource.cachePokemonDetails(remotePokemon);
        return Right(remotePokemon);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      try {
        final localPokemon = await localDataSource.getCachedPokemonDetails(id);
        return Right(localPokemon);
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      }
    }
  }
}