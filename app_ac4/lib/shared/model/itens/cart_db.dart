import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'cart.dart';

class CartItensDB {
  static final CartItensDB instance = CartItensDB._init();

  static Database? _database;

  CartItensDB._init();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDB('favorites.db');
      return _database!;
    }
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final integerType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE $tableConfigs ( 
  ${SavedCartItens.id} $idType, 
  ${SavedCartItens.idProduto} $integerType,
''');
  }

  Future<CartItens> create(CartItens configs) async {
    final db = await instance.database;
    final id = await db.insert(tableConfigs, configs.toJson());
    return configs.copy(id: id);
  }

  Future<CartItens> readConfig(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableConfigs,
      columns: SavedCartItens.values,
      where: '${SavedCartItens.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return CartItens.fromJson(maps.first);
    } else {
      throw Exception('Id $id not found');
    }
  }

  Future<List<CartItens>> readAllConfigs() async {
    final db = await instance.database;

    final result = await db.query(tableConfigs);

    return result.map((json) => CartItens.fromJson(json)).toList();
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(tableConfigs,
        where: '${SavedCartItens.idProduto} = ?', whereArgs: [id]);
  }

  // Future close() async {
  //   final db = await instance.database;
  //   db.close();
  // }
}
