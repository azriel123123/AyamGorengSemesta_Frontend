class Product {
  final String name;
  final int price;
  final String imageUrl;
  int qty;
  bool added;

  Product({
    required this.name,
    required this.price,
    required this.imageUrl,
    this.qty = 0,
    this.added = false,
  });
}
