import 'package:pokemon/core/error/exceptions.dart';
import 'package:pokemon/data/models/pokemon_model.dart';
import 'package:pokemon/data/mappers/pokemon_mapper.dart';
import 'package:sqflite/sqflite.dart';

import '../../core/services/image_cache_service.dart';

abstract class PokemonLocalDataSource {
  Future<List<PokemonModel>> getCachedPokemonList();
  Future<void> cachePokemonList(List<PokemonModel> pokemonModels);
  Future<PokemonModel?> getCachedPokemonDetails(int id);
  Future<void> cachePokemonDetails(PokemonModel pokemon);
}

class PokemonLocalDataSourceImpl implements PokemonLocalDataSource {
  final Database database;
  final ImageCacheService imageCacheService;

  PokemonLocalDataSourceImpl({
    required this.database,
    required this.imageCacheService,
  });

  @override
  Future<void> cachePokemonList(List<PokemonModel> pokemonModels) async {
    try {
      await database.transaction((txn) async {
        for (var pokemon in pokemonModels) {
          try {
            final fileName = 'pokemon_${pokemon.id}.png';
            String? localPath;

            try {
              localPath = await imageCacheService.cacheImageFromUrl(
                pokemon.imageUrl,
                fileName,
              );
            } catch (e) {
              print('Failed to cache image for Pokemon ${pokemon.id}: $e');
            }

            final pokemonWithLocalImage = pokemon.copyWithLocalImagePath(localPath);

            await txn.insert(
              'pokemons',
              PokemonMapper.toMap(pokemonWithLocalImage),
              conflictAlgorithm: ConflictAlgorithm.replace,
            );
          } catch (e) {
            print('Error processing Pokemon ${pokemon.id}: $e');
          }
        }
      });
    } catch (e) {
      throw CacheException('Failed to cache pokemons: $e');
    }
  }

  @override
  Future<List<PokemonModel>> getCachedPokemonList() async {
    try {
      final List<Map<String, dynamic>> maps = await database.query('pokemons');

      if (maps.isEmpty) {
        throw CacheException('No cached pokemons found');
      }

      return maps.map((map) => PokemonMapper.fromMap(map)).toList();
    } catch (e) {
      throw CacheException('Failed to get cached pokemons: $e');
    }
  }

  @override
  Future<PokemonModel?> getCachedPokemonDetails(int id) async {
    try {
      final List<Map<String, dynamic>> maps = await database.query(
        'pokemons',
        where: 'id = ?',
        whereArgs: [id],
      );

      if (maps.isEmpty) {
        return null;
      }

      return PokemonMapper.fromMap(maps.first);
    } catch (e) {
      throw CacheException('Failed to get cached pokemon details: $e');
    }
  }

  @override
  Future<void> cachePokemonDetails(PokemonModel pokemon) async {
    try {
      final fileName = 'pokemon_${pokemon.id}.png';
      String? localPath;

      try {
        localPath = await imageCacheService.cacheImageFromUrl(
          pokemon.imageUrl,
          fileName,
        );
      } catch (e) {
        print('Failed to cache image for Pokemon ${pokemon.id}: $e');
      }

      final pokemonWithLocalImage = pokemon.copyWithLocalImagePath(localPath);

      await database.insert(
        'pokemons',
        PokemonMapper.toMap(pokemonWithLocalImage),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      throw CacheException('Failed to cache pokemon details: $e');
    }
  }
}