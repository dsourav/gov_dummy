import 'package:design_demo/data_server_from_dart/my_product_details.dart';
import 'package:flutter/material.dart';

class MyProductDetailPage extends StatefulWidget {
  final MyProductDetails details;
  MyProductDetailPage({this.details});
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
          children: <Widget>[_myProductImages(), 
          _product("Name :  ",widget.details.productName??"not found",1),
          _product("Price :  ",widget.details.price??"not found",2),
          _product("Price Extension :  ",widget.details.priceExtension??"not found",3),
          _product("Max Quantity :  ",widget.details.quantity??"not found",4),
          _product("Max Quantity Extension :  ",widget.details.quantityExtension??"not found",5),
           _product("Min Quantity :  ",widget.details.minQuantity??"not found",6),
          _product("Min Quantity Extension :  ",widget.details.minQuantityExtension??"not found",7),
          
          
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
                    child: widget.details.images == null
                        ? new Icon(Icons.add_a_photo)
                        : widget.details.images.isEmpty ||
                                widget.details.images[0] == null
                            ? new Icon(Icons.add_a_photo)
                            : new Stack(
                                fit: StackFit.expand,
                                children: <Widget>[
                                  new Image.network(
                                    widget.details.images[0]['url'],
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
                    child: widget.details.images == null
                        ? new Icon(Icons.add_a_photo)
                        : widget.details.images.isEmpty ||
                                widget.details.images[1] == null
                            ? new Icon(Icons.add_a_photo)
                            : new Stack(
                                fit: StackFit.expand,
                                children: <Widget>[
                                  new Image.network(
                                    widget.details.images[1]['url'],
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
                    child: widget.details.images == null
                        ? new Icon(Icons.add_a_photo)
                        : widget.details.images.isEmpty ||
                                widget.details.images[2] == null
                            ? new Icon(Icons.add_a_photo)
                            : new Stack(
                                fit: StackFit.expand,
                                children: <Widget>[
                                  new Image.network(
                                    widget.details.images[2]['url'],
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
        padding: EdgeInsets.only(left: 5.0, right: 5.0),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Flexible(
              child: new Container(
                child: new Text(label.toString()+""+ name.toString()),
              ),
            ),
            new Flexible(
              child: new GestureDetector(
                child: new Icon(Icons.edit),
              ),
            )
          ],
        ),
      ),
    );
  }
}
