class ProductFavModel {
  int id;
  String title;
  String description;
  String discount;
  String price;
  String image;

  ProductFavModel({
     required this.id,
    required this.title,
    required this.description,
    required this.discount,
    required this.price,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'discount': discount,
      'description': description,
      'image': image,

    };
  }

  factory ProductFavModel.fromMap(Map<String, dynamic> dbData) {
    return ProductFavModel(
      id: dbData['id'],
      title: dbData['title'],
      description: dbData['description'],
      price: dbData['price'],
      discount: dbData['discount'],
      image: dbData['image'],
    );
  }
}
