import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  static const int DATABASE_VERSION = 1;

  static Future<Database> initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'pokemon_database.db');

    return await openDatabase(
      path,
      version: DATABASE_VERSION,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE pokemons(
            id INTEGER PRIMARY KEY,
            name TEXT,
            imageUrl TEXT,
            types TEXT,
            weightInHg INTEGER,
            heightInDm INTEGER,
            localImagePath TEXT
          )
        ''');
      },
    );
  }
}