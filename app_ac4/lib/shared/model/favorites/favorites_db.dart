import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'favorites.dart';

class SavedFavoritesDB {
  static final SavedFavoritesDB instance = SavedFavoritesDB._init();

  static Database? _database;

  SavedFavoritesDB._init();

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
  ${SavedFavorites.id} $idType, 
  ${SavedFavorites.idProduto} $integerType,
''');
  }

  Future<Favorits> create(Favorits configs) async {
    final db = await instance.database;
    final id = await db.insert(tableConfigs, configs.toJson());
    return configs.copy(id: id);
  }

  Future<Favorits> readConfig(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableConfigs,
      columns: SavedFavorites.values,
      where: '${SavedFavorites.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Favorits.fromJson(maps.first);
    } else {
      throw Exception('Id $id not found');
    }
  }

  Future<List<Favorits>> readAllConfigs() async {
    final db = await instance.database;

    final result = await db.query(tableConfigs);

    return result.map((json) => Favorits.fromJson(json)).toList();
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(tableConfigs,
        where: '${SavedFavorites.idProduto} = ?', whereArgs: [id]);
  }

  // Future close() async {
  //   final db = await instance.database;
  //   db.close();
  // }
}
