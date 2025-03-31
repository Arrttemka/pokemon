import 'dart:convert';
import 'package:pokemon/core/error/exceptions.dart';
import 'package:pokemon/data/models/pokemon_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

abstract class PokemonLocalDataSource {
  /// Gets the cached list of pokemons
  /// Throws [CacheException] if no cached data is present
  Future<List<PokemonModel>> getCachedPokemonList();

  /// Gets the cached details of a specific pokemon
  /// Throws [CacheException] if no cached data is present
  Future<PokemonModel> getCachedPokemonDetails(int id);

  /// Caches the list of pokemons
  Future<void> cachePokemonList(List<PokemonModel> pokemonModels);

  /// Caches the details of a specific pokemon
  Future<void> cachePokemonDetails(PokemonModel pokemonModel);
}

class PokemonLocalDataSourceImpl implements PokemonLocalDataSource {
  final Database database;

  PokemonLocalDataSourceImpl({required this.database});

  static Future<Database> initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'pokemon_database.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          '''
          CREATE TABLE pokemons(
            id INTEGER PRIMARY KEY,
            name TEXT,
            imageUrl TEXT,
            types TEXT,
            weightInHg INTEGER,
            heightInDm INTEGER
          )
          ''',
        );
      },
    );
  }

  @override
  Future<List<PokemonModel>> getCachedPokemonList() async {
    try {
      final List<Map<String, dynamic>> maps = await database.query('pokemons');

      if (maps.isEmpty) {
        throw CacheException('No cached pokemons found');
      }

      return maps.map((map) {
        return PokemonModel(
          id: map['id'],
          name: map['name'],
          imageUrl: map['imageUrl'],
          types: List<String>.from(json.decode(map['types'])),
          weightInHg: map['weightInHg'],
          heightInDm: map['heightInDm'],
        );
      }).toList();
    } catch (e) {
      throw CacheException('Failed to get cached pokemons: $e');
    }
  }

  @override
  Future<PokemonModel> getCachedPokemonDetails(int id) async {
    try {
      final List<Map<String, dynamic>> maps = await database.query(
        'pokemons',
        where: 'id = ?',
        whereArgs: [id],
      );

      if (maps.isEmpty) {
        throw CacheException('No cached pokemon found for id: $id');
      }

      final map = maps.first;
      return PokemonModel(
        id: map['id'],
        name: map['name'],
        imageUrl: map['imageUrl'],
        types: List<String>.from(json.decode(map['types'])),
        weightInHg: map['weightInHg'],
        heightInDm: map['heightInDm'],
      );
    } catch (e) {
      throw CacheException('Failed to get cached pokemon details: $e');
    }
  }

  @override
  Future<void> cachePokemonList(List<PokemonModel> pokemonModels) async {
    final batch = database.batch();

    for (final pokemon in pokemonModels) {
      batch.insert(
        'pokemons',
        {
          'id': pokemon.id,
          'name': pokemon.name,
          'imageUrl': pokemon.imageUrl,
          'types': json.encode(pokemon.types),
          'weightInHg': pokemon.weightInHg,
          'heightInDm': pokemon.heightInDm,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit(noResult: true);
  }

  @override
  Future<void> cachePokemonDetails(PokemonModel pokemonModel) async {
    await database.insert(
      'pokemons',
      {
        'id': pokemonModel.id,
        'name': pokemonModel.name,
        'imageUrl': pokemonModel.imageUrl,
        'types': json.encode(pokemonModel.types),
        'weightInHg': pokemonModel.weightInHg,
        'heightInDm': pokemonModel.heightInDm,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}