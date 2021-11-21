const String tableConfigs = 'messages';

class SavedCartItens {
  static final List<String> values = [id, idProduto];

  static const String id = '_id';
  static const String idProduto = 'idProduto';
}

class CartItens {
  final int? id;
  final int? idProduto;

  const CartItens({
    this.id,
    required this.idProduto,
  });

  CartItens copy({
    int? id,
    int? idMensagem,
  }) =>
      CartItens(
        id: id ?? this.id,
        idProduto: idMensagem ?? this.idProduto,
      );

  static CartItens fromJson(Map<String, Object?> json) => CartItens(
        id: json[SavedCartItens.id] as int?,
        idProduto: json[SavedCartItens.idProduto] as int?,
      );

  Map<String, Object?> toJson() => {
        SavedCartItens.id: id,
        SavedCartItens.idProduto: idProduto,
      };
}
