class ProductItem {
  String name;
  String category;
  double price;
  double rating;
  String imageUrl;

  ProductItem(
      {this.name,
      this.category,
      this.price,
      this.rating,
      this.imageUrl: 'assets/cat.png'});
}