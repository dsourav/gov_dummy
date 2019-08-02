class MyProductDetails {
  var productName;
  var productDescription;
  var id;
  var quantity;
  var quantityExtension;
  var minQuantity;
  var minQuantityExtension;
  var price;
  var priceExtension;
  var availableNow;
  var retailAble;
  var images;
  MyProductDetails(
      {this.price,
      this.id,
      this.availableNow,
      this.images,
      this.priceExtension,
      this.productDescription,
      this.productName,
      this.quantity,
      this.quantityExtension,
      this.retailAble,
      this.minQuantity,
      this.minQuantityExtension});
}
