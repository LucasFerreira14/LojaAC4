const String tableCart = 'cartItens';

class SavedCartItens {
  static final List<String> values = [id, idProduto, isSaved];

  static const String id = '_id';
  static const String idProduto = 'idProduto';
  static const String isSaved = 'isSaved';
}

class CartItens {
  final int? id;
  final int idProduto;
  final String isSaved;

  const CartItens({this.id, required this.idProduto, required this.isSaved});

  CartItens copy({int? id, int? idProduto, String? isSaved}) => CartItens(
      id: id ?? this.id,
      idProduto: idProduto ?? this.idProduto,
      isSaved: isSaved ?? this.isSaved);

  static CartItens fromJson(Map<String, Object?> json) => CartItens(
      id: json[SavedCartItens.id] as int?,
      idProduto: json[SavedCartItens.idProduto] as int,
      isSaved: json[SavedCartItens.isSaved] as String);

  Map<String, Object?> toJson() => {
        SavedCartItens.id: id,
        SavedCartItens.idProduto: idProduto,
        SavedCartItens.isSaved: isSaved
      };
}
