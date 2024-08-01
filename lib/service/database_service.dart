import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../model/product_fav_model.dart';

class DatabaseService {
  DatabaseService._internal();
  static final DatabaseService _databaseService = DatabaseService._internal();
  factory DatabaseService() => _databaseService;

  static Database? _database;
  final String _dbName = "products_database.db";
  final String _tableName = "products";

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, _dbName);
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute(
          'CREATE TABLE $_tableName(id INTEGER PRIMARY KEY, title TEXT, image TEXT, description TEXT, price REAL, discount INTEGER)',
        );
      },
    );
  }

  Future<void> insertProduct(ProductFavModel productfavModel) async {
    final db = await database;
    await db.insert(
      _tableName,
      productfavModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
Future<void> deleteProduct(int id) async {
  final db = await database;
  await db.delete(
    _tableName,
    where: 'id = ?',
    whereArgs: [id],
  );
}

  Future<List<ProductFavModel>> getProducts() async {
    final db = await database;
    final List<Map<String, Object?>> productMap = await db.query(_tableName);
    return productMap.map((e) => ProductFavModel.fromMap(e)).toList();
  }

  Future<bool> isProductSaved(int id) async {
    final db = await database;
    final result = await db.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    return result.isNotEmpty;
  }

  Future<void> toggleFavoriteStatus(ProductFavModel product) async {
    final isSaved = await isProductSaved(product.id);
    if (isSaved) {
      await deleteProduct(product.id);
    } else {
      await insertProduct(product);
    }
  }
}
