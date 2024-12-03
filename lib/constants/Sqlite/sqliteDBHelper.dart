import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../../features/Profile/model/user.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('user.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        email TEXT,
        username TEXT,
        roles TEXT
      )
    ''');
  }

  Future<int> insertUser(User user) async {
    final db = await instance.database;
    return await db.insert('users', user.toMap());
  }

  Future<User> getUser() async {
    final db = await instance.database;
    final maps = await db.query('users', limit: 1);
    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    } else {
      throw Exception('No user found');
    }
  }
  Future<int> updateUser(User user) async {
    final db = await instance.database;

    // Use an upsert strategy to insert or update the user
    return await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace, // Replaces the old user if the primary key (id) exists
    );
  }

  Future<void> clearUserTable() async {
    final db = await instance.database;
    await db.delete('users'); // Delete all entries from the 'user' table
  }
}
