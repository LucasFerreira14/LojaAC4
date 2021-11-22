const String tableFavorite = 'favoriteItens';

class SavedFavorites {
  static final List<String> values = [id, idProduto, isSaved];

  static const String id = '_id';
  static const String idProduto = 'idProduto';
  static const String isSaved = 'isSaved';
}

class Favorites {
  final int? id;
  final int idProduto;
  final String isSaved;

  const Favorites({this.id, required this.idProduto, required this.isSaved});

  Favorites copy({int? id, int? idProduto, String? isSaved}) => Favorites(
      id: id ?? this.id,
      idProduto: idProduto ?? this.idProduto,
      isSaved: isSaved ?? this.isSaved);

  static Favorites fromJson(Map<String, Object?> json) => Favorites(
      id: json[SavedFavorites.id] as int?,
      idProduto: json[SavedFavorites.idProduto] as int,
      isSaved: json[SavedFavorites.isSaved] as String);

  Map<String, Object?> toJson() => {
        SavedFavorites.id: id,
        SavedFavorites.idProduto: idProduto,
        SavedFavorites.isSaved: isSaved
      };
}
