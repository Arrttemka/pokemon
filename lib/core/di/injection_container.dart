import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pokemon/core/navigation/app_navigator.dart';
import 'package:pokemon/core/network/network_info.dart';
import 'package:pokemon/data/datasources/pokemon_local_data_source.dart';
import 'package:pokemon/data/datasources/pokemon_remote_data_source.dart';
import 'package:pokemon/data/repositories/pokemon_repository_impl.dart';
import 'package:pokemon/domain/repositories/pokemon_repository.dart';
import 'package:pokemon/domain/usecases/get_pokemon_details.dart';
import 'package:pokemon/domain/usecases/get_pokemon_list.dart';
import 'package:pokemon/presentation/cubits/pokemon_details_cubit.dart';
import 'package:pokemon/presentation/cubits/pokemon_list_cubit.dart';
import 'package:sqflite/sqflite.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // Navigation
  final navigatorKey = GlobalKey<NavigatorState>();
  sl.registerLazySingleton(() => navigatorKey);
  sl.registerLazySingleton(() => AppNavigator(navigatorKey: sl()));

  // External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
  final database = await PokemonLocalDataSourceImpl.initDatabase();
  sl.registerLazySingleton(() => database);

  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // Data sources
  sl.registerLazySingleton<PokemonRemoteDataSource>(
          () => PokemonRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<PokemonLocalDataSource>(
          () => PokemonLocalDataSourceImpl(database: sl()));

  // Repositories
  sl.registerLazySingleton<PokemonRepository>(() => PokemonRepositoryImpl(
    remoteDataSource: sl(),
    localDataSource: sl(),
    networkInfo: sl(),
  ));

  // Use cases
  sl.registerLazySingleton(() => GetPokemonList(sl()));
  sl.registerLazySingleton(() => GetPokemonDetails(sl()));

  // Cubits
  sl.registerFactory(() => PokemonListCubit(getPokemonList: sl()));
  sl.registerFactory(() => PokemonDetailsCubit(getPokemonDetails: sl()));
}