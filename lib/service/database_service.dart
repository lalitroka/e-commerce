import 'package:myshop/model/product_fav_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  DatabaseService._internal();
  static final DatabaseService _databaseService = DatabaseService._internal();
  factory DatabaseService() => _databaseService;

  static Database? _database;
  final String _dbName = "product_database.db";
  final String _tableName = "product";

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
      onCreate: (db, version) {
        db.execute(
            'CREATE TABLE $_tableName(id INTEGER PRIMARY KEY, title TEXT, image TEXT, description TEXT, price REAL, discount INTEGER)');
      },
      version: 1,
    );
  }

  Future<void> insertProduct(ProductFavModel productfavModel) async {
    final db = await _databaseService.database;
    await db.insert(
      _tableName,
      productfavModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<ProductFavModel>> getProducts() async {
    final db = await _databaseService.database;
    final List<Map<String, Object?>> productMap = await db.query(_tableName);
    return productMap.map((e) => ProductFavModel.fromMap(e)).toList();
  }

  Future<void> deleteProduct(int id) async {
    final db = await _databaseService.database;
    await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
