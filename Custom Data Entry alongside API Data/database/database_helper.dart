import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;
  static final DatabaseHelper instance = DatabaseHelper._init();

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'students.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE students (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            studentname TEXT,
            fathername TEXT,
            progname TEXT,
            shift TEXT,
            rollno TEXT,
            coursecode TEXT,
            coursetitle TEXT,
            credithours TEXT,
            obtainedmarks TEXT,
            mysemester TEXT,
            consider_status TEXT
          )
        ''');
      },
    );
  }

  // Insert data into table
  Future<void> insertStudent(Map<String, dynamic> student) async {
    final db = await database;
    await db.insert('students', student, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Get all students
  Future<List<Map<String, dynamic>>> getStudents() async {
    final db = await database;
    return await db.query('students');
  }

  // Clear all data
  Future<void> clearStudents() async {
    final db = await database;
    await db.delete('students');
  }
}