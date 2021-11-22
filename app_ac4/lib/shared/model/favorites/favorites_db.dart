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
      _database = await _initDB('favoriteItens.db');
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
    final boolType = 'BOOLEAN NOT NULL';

    await db.execute('''
CREATE TABLE $tableFavorite ( 
  ${SavedFavorites.id} $idType, 
  ${SavedFavorites.idProduto} $integerType,
  ${SavedFavorites.isSaved} $boolType
  )
''');
  }

  Future<Favorites> create(Favorites itens) async {
    final db = await instance.database;
    final id = await db.insert(tableFavorite, itens.toJson());

    return itens.copy(id: id);
  }

  Future<Favorites> readConfig(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableFavorite,
      columns: SavedFavorites.values,
      where: '${SavedFavorites.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Favorites.fromJson(maps.first);
    } else {
      throw Exception('Id $id not found');
    }
  }

  Future<List<Favorites>> readAllItens() async {
    final db = await instance.database;
    final orderBy = '${SavedFavorites.idProduto} ASC';
    final result = await db.query(tableFavorite, orderBy: orderBy);

    return result.map((json) => Favorites.fromJson(json)).toList();
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(tableFavorite,
        where: '${SavedFavorites.idProduto} = ?', whereArgs: [id]);
  }

  // Future close() async {
  //   final db = await instance.database;
  //   db.close();
  // }
}
