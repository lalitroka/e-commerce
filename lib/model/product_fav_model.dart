class ProductFavModel {
  final int id;
  final String? title;
  final String? image;
  final String? description;
  final double? price;
  final int? discount;

  ProductFavModel({
    required this.id,
    required this.title,
    required this.image,
    required this.description,
    required this.price,
    required this.discount,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'description': description,
      'price': price,
      'discount': discount,
    };
  }

  factory ProductFavModel.fromMap(Map<String, dynamic> map) {
    return ProductFavModel(
      id: map['id'] as int,
      title: map['title'] as String,
      image: map['image'] as String,
      description: map['description'] as String,
     price: (map['price'] as num?)?.toDouble() ?? 0.0,
      discount: (map['discount'] as num?)?.toInt() ?? 0,
    );
  }
}
