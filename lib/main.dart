import 'package:flutter/material.dart';
import 'package:pokemon/core/di/injection_container.dart' as di;
import 'package:pokemon/core/navigation/app_routes.dart';
import 'package:pokemon/core/navigation/route_generation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokemon App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorKey: di.sl<GlobalKey<NavigatorState>>(),
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: AppRoutes.pokemonList,
      debugShowCheckedModeBanner: false,
    );
  }
}