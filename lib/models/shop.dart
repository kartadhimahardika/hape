class Shop {
  String id;
  String title;
  String description;
  String image;
  String harga;

  Shop({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.harga,
  });

  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      image: json['image'],
      harga: json['harga'],
    );
  }
}
