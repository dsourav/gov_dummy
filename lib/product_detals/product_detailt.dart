import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:design_demo/data_server_from_dart/product_details.dart';

class ProductDetailPage extends StatefulWidget {
  final ProductDetailsDart detailsDart;

  ProductDetailPage({Key key, @required this.detailsDart}) : super(key: key);
  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  List<dynamic>_imagesProduct=new List();
  @override
  Widget build(BuildContext context) {
    //print(widget.detailsDart.images.length);
        for (int i = 0; i < widget.detailsDart.images.length; i++) {
      _imagesProduct.add(Image.network(widget.detailsDart.images[i]['url'], fit: BoxFit.fill,)
     
      );
    }

    print(_productImages().toString());
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Product Details"),
      ),
      body: Container(
        child: new ListView(
          children: <Widget>[
            new Container(
              child: new Card(
                elevation: 5.0,
                child: new SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 220.0,
                  child: new Carousel(
                    dotBgColor: Colors.transparent,
                    dotColor: Colors.cyanAccent,
                    borderRadius: true,
                    boxFit: BoxFit.fill,
                    // images: [
                    //   // Image.asset('assets/veg.jpg'),
                    //   // Image.asset('assets/veg.jpg'),
                    //   // Image.asset('assets/veg.jpg'),
                    // ],
                    images: _imagesProduct
                   
                  ),
                ),
              ),
            ),
            new SizedBox(
              height: 10.0,
            ),
            new Card(
              child: new Container(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Flexible(
                      child: new Container(
                        padding: EdgeInsets.only(left: 5.0, right: 5.0),
                        child: new Text(
                          widget.detailsDart.productName ?? "not found",
                          textAlign: TextAlign.left,
                          style: new TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    new Flexible(
                      child: new Container(
                        padding: EdgeInsets.only(left: 5.0, right: 5.0),
                        child: new Text(
                          widget.detailsDart.availableNow.toString() ?? "null",
                          textAlign: TextAlign.right,
                          style: new TextStyle(
                            color: Colors.black,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

 _productImages() {

  }
}
