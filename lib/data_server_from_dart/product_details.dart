import 'dart:core';

class ProductDetailsDart{
  var productName;
  var productDescription;
  var id;
  var quantity;
  var quantityExtension;
  var price;
  var priceExtension;
  var availableNow;
  var govPrice;
  var govPriceExtension;
  var categoryName;
  var retailable;
  var images;
  var ownerName;
  var ownerAddress;
  var ownerDivision;
  var ownerRegion;
  var ownerImage;
  var ownerPhone;
  ProductDetailsDart({this.productName,this.id,this.quantity,this.quantityExtension,
  this.price,this.priceExtension,this.availableNow,this.govPrice,this.govPriceExtension,
  this.categoryName,this.retailable,this.images,this.ownerAddress,this.ownerName,
  this.ownerDivision,this.ownerImage,this.ownerRegion,this.productDescription,this.ownerPhone});
}