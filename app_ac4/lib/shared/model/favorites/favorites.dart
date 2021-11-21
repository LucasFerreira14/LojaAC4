const String tableConfigs = 'messages';

class SavedFavorites {
  static final List<String> values = [id, idProduto];

  static const String id = '_id';
  static const String idProduto = 'idProduto';
}

class Favorits {
  final int? id;
  final int? idProduto;

  const Favorits({
    this.id,
    required this.idProduto,
  });

  Favorits copy({
    int? id,
    int? idMensagem,
  }) =>
      Favorits(
        id: id ?? this.id,
        idProduto: idMensagem ?? this.idProduto,
      );

  static Favorits fromJson(Map<String, Object?> json) => Favorits(
        id: json[SavedFavorites.id] as int?,
        idProduto: json[SavedFavorites.idProduto] as int?,
      );

  Map<String, Object?> toJson() => {
        SavedFavorites.id: id,
        SavedFavorites.idProduto: idProduto,
      };
}
