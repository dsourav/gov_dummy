import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:design_demo/data_server_from_dart/product_details.dart';
import 'package:numberpicker/numberpicker.dart';

class ProductDetailPage extends StatefulWidget {
  final ProductDetailsDart detailsDart;

  ProductDetailPage({Key key, @required this.detailsDart}) : super(key: key);
  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  List<dynamic> _imagesProduct = new List();
  double _currentProductQuantity = 1.0;
  @override
  Widget build(BuildContext context) {
    print(widget.detailsDart.ownerImage);
    // _currentProductQuantity=widget.detailsDart.priceExtension.toString();
    for (int i = 0; i < widget.detailsDart.images.length; i++) {
      _imagesProduct.add(Image.network(
        widget.detailsDart.images[i]['url'],
        fit: BoxFit.fill,
      ));
    }

    return Scaffold(
      appBar: new AppBar(
        title: new Text("Product Details"),
      ),
      body: Container(
        child: new ListView(
          children: <Widget>[
            _productImagesCarusual(),
            new SizedBox(
              height: 2.0,
            ),
            _productNameAvailability(),
            new SizedBox(
              height: 2.0,
            ),
            _productVendorGovprice(),
            _quantitySelection(),
            Container(
              padding: EdgeInsets.only(left: 8.0),
              child: new Text(
                "Description",
                textAlign: TextAlign.left,
                style: new TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            new Card(
              elevation: 5.0,
              child: new Container(
                padding: EdgeInsets.only(
                    left: 8.0, right: 8.0, top: 5.0, bottom: 5.0),
                child: new AutoSizeText(
                  widget.detailsDart.productDescription ??
                      "not description available",
                  softWrap: true,
                  wrapWords: true,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 8.0),
              child: new Text(
                "About Vendor",
                textAlign: TextAlign.left,
                style: new TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            _venDorDescription()
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  _productImagesCarusual() {
    return new Container(
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
              images: _imagesProduct),
        ),
      ),
    );
  }

  _productNameAvailability() {
    return new Card(
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
                  child: widget.detailsDart.availableNow
                      ? new Text(
                          "Available",
                          textAlign: TextAlign.right,
                          style: new TextStyle(
                              color: Colors.green,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold),
                        )
                      : new Text(
                          "Not Available",
                          textAlign: TextAlign.right,
                          style: new TextStyle(
                            color: Colors.red,
                            fontSize: 14.0,
                          ),
                        )),
            )
          ],
        ),
      ),
    );
  }

  _productVendorGovprice() {
    return new Card(
      child: new Container(
        padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Flexible(
              child: new Container(
                padding: EdgeInsets.only(left: 5.0, right: 5.0),
                child: new Text(
                  "৳${widget.detailsDart.price} (${widget.detailsDart.priceExtension})" ??
                      "not found",
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
                  "Gov: ৳${widget.detailsDart.govPrice} (${widget.detailsDart.govPriceExtension})" ??
                      "null",
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
    );
  }

  _quantitySelection() {
    return new Card(
      child: new Container(
        padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
        child: new InkWell(
          splashColor: Colors.green,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                  padding: EdgeInsets.only(left: 5.0, right: 5.0),
                  child: new Text(
                    "Select Quantity",
                    textAlign: TextAlign.left,
                  )),
              new Container(
                padding: EdgeInsets.only(left: 5.0, right: 5.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.amber)),
                child: new Icon(Icons.remove),
              ),
              new Container(
                  child: new GestureDetector(
                child: new Container(
                  decoration: BoxDecoration(),
                  child: new Text(_currentProductQuantity.toString() +
                          " ${widget.detailsDart.quantityExtension}" ??
                      null),
                ),
              )),
              new Container(
                padding: EdgeInsets.only(left: 5.0, right: 5.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.amber)),
                child: new Icon(Icons.add),
              ),
            ],
          ),
          onTap: () {
            // print("dialoude");
            _showDialog();
          },
        ),
      ),
    );
  }

  _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new NumberPickerDialog.decimal(
              minValue: 1,
              maxValue: int.parse(widget.detailsDart.quantity),
              title: new Text("Pick Product Quantity"),
              initialDoubleValue: _currentProductQuantity);
        }).then((value) {
      if (value != null) {
        setState(() => _currentProductQuantity = value);
      }
    });
  }

  _venDorDescription() {
    return new Card(
      child: new Container(
        padding:
            EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // new Container(
            //   width: 60.0,
            //   height: 80.0,
            //   decoration: new BoxDecoration(
            //     shape: BoxShape.circle,

            //   ),
            //   // child: widget.detailsDart.ownerImage!=null?
            //   // new Image.network(widget.detailsDart.ownerImage,
            //   // fit: BoxFit.fill,):
            //   // new Image.asset('assets/veg.jpg')
            //   child:
            //   ,

            // ),

            ClipOval(
              child: FadeInImage.assetNetwork(
                image: widget.detailsDart.ownerImage,
                placeholder: 'assets/veg.jpg',
                height: 80.0,
                width: 80.0,
              ),
            ),
            new Text("Name: " + widget.detailsDart.ownerName ??
                "not available"),
            new Text("Phone: " + widget.detailsDart.ownerPhone ??
                "not available"),
            new Text("Address: " + widget.detailsDart.ownerAddress ??
                "not available")

            // new Row(
            //   children: <Widget>[
            //     new Text("Name: "),
            //     new Text()
            //   ],
            // ),
            // new Row(
            //   children: <Widget>[

            //     new Text( ?? )
            //   ],
            // ),

            // new Row(
            //   children: <Widget>[

            //     new Text( ?? "not available")
            //   ],
            // )
          ],
        ),
      ),
    );
  }

  _buildBottomNavigationBar() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50.0,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: RaisedButton(
              onPressed: () {},
              color: Colors.amberAccent,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.list,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 4.0,
                    ),
                    Text(
                      "PLACE ORDER",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: RaisedButton(
              onPressed: () {},
              color: Colors.pinkAccent,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.card_travel,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 4.0,
                    ),
                    Text(
                      "ADD TO BAG",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
