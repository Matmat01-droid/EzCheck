import 'package:ezcheck_app/models/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;

  DatabaseHelper._privateConstructor();

  factory DatabaseHelper() {
    if (_instance == null) {
      _instance = DatabaseHelper._privateConstructor();
    }
    return _instance!;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    try {
      String path = join(await getDatabasesPath(), 'your_database.db');
      return await openDatabase(
        path,
        version: 4,
        onCreate: _createDb,
        onUpgrade: _onUpgrade,
      );
    } catch (e) {
      print('Error initializing database: $e');
      rethrow; // Rethrow the exception after logging it.
    }
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      // Check if the table exists
      bool tableExists = await _tableExists(db, 'users');

      if (tableExists) {
        // If the table exists, alter it
        await db.execute('ALTER TABLE users ADD COLUMN new_column TEXT;');
      } else {
        // If the table doesn't exist, create it
        await _createDb(db, newVersion);
      }
    }
  }

  Future<bool> _tableExists(Database db, String tableName) async {
    var result = await db.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table' AND name='$tableName';",
    );
    return result.isNotEmpty;
  }

  Future<void> _createDb(Database db, int version) async {
    await _createUsersTable(db);
    await _createProductsTable(db);
  }

  Future<void> _createUsersTable(Database db) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS users (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      fullname TEXT,
      email TEXT,
      password TEXT
    );
  ''');
  }

  Future<void> _createProductsTable(Database db) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS products (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      category TEXT,
      name TEXT,
      description TEXT,
      price REAL,
      imageUrl TEXT
    );
  ''');
  }

  Future<int> registerUser(User user) async {
    Database db = await database;

      return await db.insert(
        'users',
        user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
  }

  Future<bool> loginUser(String email, String password) async {
    Database db = await database; // Ensure the database is initialized
    final List<Map<String, dynamic>> result = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (result.isNotEmpty) {
      // Convert the map to a User object
      User user = User.fromMap(result.first);
      // Now you have access to user.id, user.username, etc.
      return true;
    } else {
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> getProductsByCategory(
      String category) async {
    Database db = await database;
    return await db
        .query('products', where: 'category = ?', whereArgs: [category]);
  }
}
