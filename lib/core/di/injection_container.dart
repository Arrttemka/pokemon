import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pokemon/core/database/app_database.dart';
import 'package:pokemon/core/navigation/app_navigator.dart';
import 'package:pokemon/core/network/network_info.dart';
import 'package:pokemon/core/services/image_cache_service.dart';
import 'package:pokemon/data/datasources/pokemon_local_data_source.dart';
import 'package:pokemon/data/datasources/pokemon_remote_data_source.dart';
import 'package:pokemon/data/repositories/pokemon_repository_impl.dart';
import 'package:pokemon/domain/repositories/pokemon_repository.dart';
import 'package:pokemon/domain/usecases/get_pokemon_details_use_case.dart';
import 'package:pokemon/domain/usecases/get_pokemon_list_use_case.dart';
import 'package:pokemon/presentation/features/pokemon_details/cubit/pokemon_details_cubit.dart';
import 'package:pokemon/presentation/features/pokemon_list/cubit/pokemon_list_cubit.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  final navigatorKey = GlobalKey<NavigatorState>();
  sl.registerLazySingleton(() => navigatorKey);
  sl.registerLazySingleton(() => AppNavigator(navigatorKey: sl()));

  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());

  final database = await AppDatabase.initDatabase();
  sl.registerLazySingleton(() => database);

  sl.registerLazySingleton<ImageCacheService>(() => ImageCacheService());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  sl.registerLazySingleton<PokemonRemoteDataSource>(
          () => PokemonRemoteDataSourceImpl(client: sl()));

  sl.registerLazySingleton<PokemonLocalDataSource>(
        () => PokemonLocalDataSourceImpl(
      database: sl(),
      imageCacheService: sl(),
    ),
  );

  sl.registerLazySingleton<PokemonRepository>(() => PokemonRepositoryImpl(
    remoteDataSource: sl(),
    localDataSource: sl(),
    networkInfo: sl(),
  ));

  sl.registerLazySingleton(() => GetPokemonListUseCase(sl()));
  sl.registerLazySingleton(() => GetPokemonDetailsUseCase(sl()));

  sl.registerFactory(() => PokemonListCubit(getPokemonList: sl()));
  sl.registerFactory(() => PokemonDetailsCubit(getPokemonDetails: sl()));
}