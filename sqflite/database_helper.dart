import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  // Get the database instance
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('users.db'); // Keeping the same DB name
    return _database!;
  }

  // Initialize the database
  Future<Database> _initDB(String fileName) async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = '${documentsDirectory.path}/$fileName';
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  // Create both tables when the database is first created
  Future _onCreate(Database db, int version) async {
    // Users table (from previous response)
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT NOT NULL,
        password TEXT NOT NULL
      )
    ''');

    // Subjects table (for GPA calculator)
    await db.execute('''
      CREATE TABLE subjects (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        subject TEXT NOT NULL,
        obtainedMarks REAL NOT NULL,
        totalMarks REAL NOT NULL,
        creditHours INTEGER NOT NULL
      )
    ''');
  }

  // --- Users table operations (from previous response) ---
  Future<void> insertUser(Map<String, dynamic> user) async {
    final db = await database;
    await db.insert('users', user);
  }

  Future<List<Map<String, dynamic>>> getAllUsers() async {
    final db = await database;
    return await db.query('users');
  }

  // --- Subjects table operations (for GPA calculator) ---
  Future<void> insertSubject(Map<String, dynamic> subject) async {
    final db = await database;
    await db.insert('subjects', subject);
  }

  Future<List<Map<String, dynamic>>> getAllSubjects() async {
    final db = await database;
    return await db.query('subjects');
  }

  Future<void> updateSubject(Map<String, dynamic> subject) async {
    final db = await database;
    await db.update('subjects', subject, where: 'id = ?', whereArgs: [subject['id']]);
  }

  Future<void> deleteSubject(int id) async {
    final db = await database;
    await db.delete('subjects', where: 'id = ?', whereArgs: [id]);
  }

  // Close the database (optional)
  Future<void> close() async {
    final db = await database;
    db.close();
  }
}