class ShopProductItem {
  String name;
  String category;
  double price;
  double rating;
  String imageUrl;

  ShopProductItem(
      {this.name,
      this.category,
      this.price,
      this.rating,
      this.imageUrl: 'assets/cat.png'});
}