import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../utils/constants.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Initialize the database
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), DatabaseConstants.dbName);
    return await openDatabase(
      path,
      version: DatabaseConstants.dbVersion,
      onCreate: _onCreate,
    );
  }

  // Create the notes table
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE ${DatabaseConstants.notesTable} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        content TEXT NOT NULL,
        created_at TEXT NOT NULL
      )
    ''');
  }

  // Insert a new note
  Future<int> insertNote(String content) async {
    final db = await database;
    final timestamp = DateTime.now().toIso8601String();
    return await db.insert(
      DatabaseConstants.notesTable,
      {'content': content, 'created_at': timestamp},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Get all notes
  Future<List<Map<String, dynamic>>> getNotes() async {
    final db = await database;
    return await db.query(
      DatabaseConstants.notesTable,
      orderBy: 'created_at DESC',
    );
  }

  // Delete a note
  Future<int> deleteNote(int id) async {
    final db = await database;
    return await db.delete(
      DatabaseConstants.notesTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}