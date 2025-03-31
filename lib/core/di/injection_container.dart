import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pokemon/core/navigation/app_navigator.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // Navigation
  final navigatorKey = GlobalKey<NavigatorState>();
  sl.registerLazySingleton(() => navigatorKey);
  sl.registerLazySingleton(() => AppNavigator(navigatorKey: sl()));

}