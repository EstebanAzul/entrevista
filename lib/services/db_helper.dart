import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:entrevista/models/persona_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'personas.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          '''
          CREATE TABLE personas(
            id INTEGER PRIMARY KEY,
            nombre TEXT,
            email TEXT,
            edad INTEGER
          )
          ''',
        );
      },
    );
  }

  Future<List<Persona>> getPersonas() async {
    final db = await database;
    final result = await db.query('personas');
    return result.map((json) => Persona.fromJson(json)).toList();
  }

  Future<int> insertPersona(Persona persona) async {
    final db = await database;
    return await db.insert(
      'personas',
      persona.toJson(),
      conflictAlgorithm:
          ConflictAlgorithm.replace, // Reemplaza si existe duplicado
    );
  }

  Future<int> updatePersona(Persona persona) async {
    final db = await database;
    return await db.update(
      'personas',
      persona.toJson(),
      where: 'id = ?',
      whereArgs: [persona.id],
    );
  }

  Future<int> deletePersona(int id) async {
    final db = await database;
    return await db.delete(
      'personas',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
