import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pokemon/core/error/exceptions.dart';
import 'package:pokemon/data/models/pokemon_list_response_model.dart';
import 'package:pokemon/data/models/pokemon_model.dart';
import 'package:pokemon/data/mappers/pokemon_mapper.dart';
import 'package:pokemon/data/mappers/pokemon_list_mapper.dart';

abstract class PokemonRemoteDataSource {

  Future<PokemonListResponseModel> getPokemonList(int offset, int limit);

  Future<PokemonModel> getPokemonDetails(int id);
}

class PokemonRemoteDataSourceImpl implements PokemonRemoteDataSource {
  final http.Client client;
  final String baseUrl = 'https://pokeapi.co/api/v2';

  PokemonRemoteDataSourceImpl({required this.client});

  @override
  Future<PokemonListResponseModel> getPokemonList(int offset, int limit) async {
    final response = await client.get(
      Uri.parse('$baseUrl/pokemon?offset=$offset&limit=$limit'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return PokemonListMapper.fromJson(json.decode(response.body));
    } else {
      throw ServerException(
          'Failed to load pokemons. Status code: ${response.statusCode}');
    }
  }

  @override
  Future<PokemonModel> getPokemonDetails(int id) async {
    final response = await client.get(
      Uri.parse('$baseUrl/pokemon/$id/'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return PokemonMapper.fromJson(json.decode(response.body));
    } else {
      throw ServerException(
          'Failed to load pokemon details. Status code: ${response.statusCode}');
    }
  }
}