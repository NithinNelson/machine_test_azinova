final String tableItems = 'items';

class ItemFields {
  static final List<String> values = [
    id,
    itemName,
    itemImage,
    itemDetails,
  ];

  static final String id = '_id';
  static final String itemName = 'itemName';
  static final String itemImage = 'itemImage';
  static final String itemDetails = 'itemDetails';
}

class Items {
  final int? id;
  final String itemName;
  final String itemImage;
  final String itemDetails;

  const Items({
    this.id,
    required this.itemName,
    required this.itemImage,
    required this.itemDetails,
  });

  Items copy({
    int? id,
    String? itemName,
    String? itemImage,
    String? itemDetails,
  }) =>
      Items(
        id: id ?? this.id,
        itemName: itemName ?? this.itemName,
        itemImage: itemImage ?? this.itemImage,
        itemDetails: itemDetails ?? this.itemDetails,
      );

  static Items fromJson(Map<String, Object?> json) => Items(
    id: json[ItemFields.id] as int?,
    itemName: json[ItemFields.itemName] as String,
    itemImage: json[ItemFields.itemImage] as String,
    itemDetails: json[ItemFields.itemDetails] as String,
  );

  Map<String, Object?> toJson() => {
    ItemFields.id: id,
    ItemFields.itemName: itemName,
    ItemFields.itemImage: itemImage,
    ItemFields.itemDetails: itemDetails,
  };
}
