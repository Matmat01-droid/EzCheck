import 'package:ezcheck_app/models/products.dart';
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
        version: 7,
        onCreate: _createDb,
        onUpgrade: _onUpgrade,
      );
    } catch (e) {
      print('Error initializing database: $e');
      rethrow;
    }
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      bool tableExists = await _tableExists(db, 'users');

      if (tableExists) {
        await db.execute('ALTER TABLE users ADD COLUMN new_column TEXT;');
      } else {
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
    await _createCartTable(db);
    await _createPurchaseDetailsTable(db);
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
      imageUrl TEXT,
      barcode TEXT
    );
  ''');
  }

  Future<void> _createPurchaseDetailsTable(Database db) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS purchase_details (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      product_name TEXT,
      quantity INTEGER,
      price REAL
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
    Database db = await database; 
    final List<Map<String, dynamic>> result = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (result.isNotEmpty) {
      User user = User.fromMap(result.first);
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

  Future<void> _createCartTable(Database db) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS cart (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      productName TEXT,
      quantity INTEGER,
      price REAL
    );
  ''');
  }

Future<void> addToCart(String productName, int quantity, double price) async {
 
  List<Map<String, dynamic>> existingItem =
      await _instance!.queryCartItemByName(productName);

  if (existingItem.isNotEmpty) {
    
    int newQuantity = existingItem[0]['quantity'] + quantity;
    await _instance!.updateCartItemQuantity(existingItem[0]['id'], newQuantity);
  } else {
    
    await _instance!.insertCartItem(productName, quantity, price);
  }
}

Future<List<Map<String, dynamic>>> queryCartItemByName(String productName) async {
  Database db = await _instance!.database;
  return await db.query(
    'cart',  
    where: 'productName = ?', 
    whereArgs: [productName],
  );
}

Future<void> insertCartItem(String productName, int quantity, double price) async {
  try {
    final Database db = await database;

    await db.insert(
      'cart',  
      {
        'productName': productName, 
        'quantity': quantity,
        'price': price,
      },
    );
  } catch (e) {
    print('Error inserting item into cart: $e');
    rethrow;
  }
}




  Future<List<Map<String, dynamic>>> getCartItems() async {
    Database db = await database;
    List<Map<String, dynamic>> cartItems = await db.query('cart');

    print('Cart items in getCartItems: $cartItems');

    return cartItems;
  }

  Future<Map<String, dynamic>> getProductById(int productId) async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'products',
      where: 'id = ?',
      whereArgs: [productId],
      limit: 1,
    );

    print(
        'Product details query: SELECT * FROM products WHERE id = $productId');
    print('Product details result: $result');

    return result.isNotEmpty ? result.first : {};
  }

  Future<void> deleteCartItem(int itemId) async {
    Database db = await database;
    await db.delete(
      'cart',
      where: 'id = ?',
      whereArgs: [itemId],
    );
  }

  Future<void> updateCartItemQuantity(int itemId, int newQuantity) async {
    try {
      Database db = await database;
      await db.update(
        'cart',
        {'quantity': newQuantity},
        where: 'id = ?',
        whereArgs: [itemId],
      );
    } catch (e) {
      print('Error updating quantity: $e');
      rethrow;
    }
  }

  Future<void> savePurchaseDetails(
      double totalAmount, List<Map<String, dynamic>> cartItems) async {
    final Database db = await database;
    for (var item in cartItems) {
      await db.insert(
        'purchase_details',
        {
          'product_name': item['productName'],
          'quantity': item['quantity'],
          'price': item['price'],
        },
      );
    }
  }

  Future<List<Map<String, dynamic>>> getPurchaseDetails() async {
    final Database db = await database;
    return await db.query('purchase_details');
  }

  Future<void> clearCart() async {
    try {
      final Database db = await database;
      await db.delete('cart');
    } catch (e) {
      print('Error clearing cart: $e');
      rethrow;
    }
  }
}
