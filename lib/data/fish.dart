class Fish {
  final String name; // data coming from api not going to change
  final String description;
  final double price;
  final String image;

  Fish(
      {required this.name,
      required this.description,
      required this.price,
      required this.image});

  factory Fish.fromJson(Map data) {
    return Fish(
      name: data['name'],
      description: data['description'],
      price: data['price'],
      image: data['image'],
    );
  }
}
