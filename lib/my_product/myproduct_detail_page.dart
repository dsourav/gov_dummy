import 'package:design_demo/data_server_from_dart/my_product_details.dart';
import 'package:flutter/material.dart';

class MyProductDetailPage extends StatefulWidget {
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
  MyProductDetailPage(
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
  @override
  _MyProductDetailPageState createState() => _MyProductDetailPageState();
}

class _MyProductDetailPageState extends State<MyProductDetailPage> {
  //List<dynamic> _imagesMyProduct = new List();
  @override
  Widget build(BuildContext context) {
    //  for (int i = 0; i < widget.detailsDart.images.length; i++) {
    //   _imagesProduct.add(Image.network(
    //     widget.detailsDart.images[i]['url'],
    //     fit: BoxFit.fill,
    //   ));
    // }
    return Scaffold(
        appBar: new AppBar(
          title: new Text("My Product"),
        ),
        body: ListView(
          children: <Widget>[
            _myProductImages(),
            _product("Name :  ", widget.productName ?? "not found", 1),
            _product("Price :  ", widget.price ?? "not found", 2),
            _product(
                "Price Extension :  ", widget.priceExtension ?? "not found", 3),
            _product("Max Quantity :  ", widget.quantity ?? "not found", 4),
            _product("Max Quantity Extension :  ",
                widget.quantityExtension ?? "not found", 5),
            _product("Min Quantity :  ", widget.minQuantity ?? "not found", 6),
            _product("Min Quantity Extension :  ",
                widget.minQuantityExtension ?? "not found", 7),
            _productAvailorRetail("Available  ", widget.availableNow, 8),
            _productAvailorRetail("Retailable  ", widget.retailAble, 9),
          ],
        ));
  }

  _myProductImages() {
    return new Container(
      height: 120.0,
      child: Card(
        elevation: 16.0,
        child: new GridView.count(
          childAspectRatio: 1.0,
          crossAxisCount: 3,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(5.0),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
              child: Card(
                elevation: 8.0,
                child: new GestureDetector(
                    child: widget.images == null
                        ? new Icon(Icons.add_a_photo)
                        : widget.images.isEmpty || widget.images[0] == null
                            ? new Icon(Icons.add_a_photo)
                            : new Stack(
                                fit: StackFit.expand,
                                children: <Widget>[
                                  new Image.network(
                                    widget.images[0]['url'],
                                    fit: BoxFit.fill,
                                  ),
                                  new Center(
                                    child: new Container(
                                      color: Colors.grey,
                                      child: new Icon(Icons.add_a_photo),
                                    ),
                                  )
                                ],
                              )),
              ),
            ),
            Container(
              padding: EdgeInsets.all(5.0),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
              child: Card(
                elevation: 8.0,
                child: new GestureDetector(
                    child: widget.images == null
                        ? new Icon(Icons.add_a_photo)
                        : widget.images.isEmpty || widget.images[1] == null
                            ? new Icon(Icons.add_a_photo)
                            : new Stack(
                                fit: StackFit.expand,
                                children: <Widget>[
                                  new Image.network(
                                    widget.images[1]['url'],
                                    fit: BoxFit.fill,
                                  ),
                                  new Center(
                                    child: new Container(
                                      color: Colors.grey,
                                      child: new Icon(Icons.add_a_photo),
                                    ),
                                  )
                                ],
                              )),
              ),
            ),
            Container(
              padding: EdgeInsets.all(5.0),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
              child: Card(
                elevation: 8.0,
                child: new GestureDetector(
                    child: widget.images == null
                        ? new Icon(Icons.add_a_photo)
                        : widget.images.isEmpty || widget.images[2] == null
                            ? new Icon(Icons.add_a_photo)
                            : new Stack(
                                fit: StackFit.expand,
                                children: <Widget>[
                                  new Image.network(
                                    widget.images[2]['url'],
                                    fit: BoxFit.fill,
                                  ),
                                  new Center(
                                    child: new Container(
                                      color: Colors.grey,
                                      child: new Icon(Icons.add_a_photo),
                                    ),
                                  )
                                ],
                              )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _product(var label, var name, int id) {
    return Card(
      elevation: 5.0,
      child: Container(
        padding:
            EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0, bottom: 20.0),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Flexible(
              child: new Container(
                child: new Text(
                  label.toString() + "" + name.toString(),
                  style: TextStyle(
                    fontSize: 14.0, fontWeight: FontWeight.w300, // light
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
            new Flexible(
              child: new GestureDetector(
                child: new Icon(
                  Icons.edit,
                  color: Colors.greenAccent,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _productAvailorRetail(String label, value, id) {
    var text = value ? "Yes" : "No";
    return new Card(
      elevation: 5.0,
      child: new Container(
        padding:
            EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0, bottom: 20.0),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Flexible(
              child: new Container(
                child: new Text(
                  label.toString() + "" + text.toString(),
                  style: TextStyle(
                    fontSize: 14.0, fontWeight: FontWeight.w300, // light
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
            new Flexible(
              child: new GestureDetector(
                child: new Icon(
                  Icons.edit,
                  color: Colors.greenAccent,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
