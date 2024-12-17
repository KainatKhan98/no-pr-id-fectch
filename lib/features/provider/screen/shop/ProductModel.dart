class ProductModel {
  final String id;
  final String vendorId;
  final String title;
  final String category;
  final double price;
  final String description;
  final String imageUrl;

  ProductModel({
    required this.id,
    required this.vendorId,
    required this.title,
    required this.category,
    required this.price,
    required this.description,
    required this.imageUrl,
  });

  // Convert Product to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'vendorId': vendorId,
      'title': title,
      'category': category,
      'price': price,
      'description': description,
      'imageUrl': imageUrl,
    };
  }

  // Create a ProductModel from Map
  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'],
      vendorId: map['vendorId'],
      title: map['title'],
      category: map['category'],
      price: map['price'],
      description: map['description'],
      imageUrl: map['imageUrl'],
    );
  }
}
