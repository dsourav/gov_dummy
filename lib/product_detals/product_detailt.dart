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
   double _currentProductQuantity=1.0 ;
  @override
  Widget build(BuildContext context) {
    //print(widget.detailsDart.images.length);
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
            _quantitySelection()
          ],
        ),
      ),
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
                padding: EdgeInsets.only(left: 5.0,right: 5.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border:Border.all(color: Colors.amber)
                ),
                child: new Icon(Icons.remove),
              ),
              new Container(
                child: new GestureDetector(
                  child: new Container(
                    decoration: BoxDecoration(
                      
                    ),
                    child: new Text(_currentProductQuantity.toString()+" ${widget.detailsDart.quantityExtension}"??null),
                  ),
                )

              ),
               new Container(
                 padding: EdgeInsets.only(left: 5.0,right: 5.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border:Border.all(color: Colors.amber)
                ),
                child: new Icon(Icons.add),
              ),
            ],
          ),
          onTap: (){
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
     
      builder: (BuildContext context){
        return new NumberPickerDialog.decimal(
          minValue: 1,
          maxValue: int.parse(widget.detailsDart.quantity),
          title: new Text("Pick Product Quantity"),
          initialDoubleValue: _currentProductQuantity);
      }
    ).then((value) {
      if (value != null) {
        setState(() => _currentProductQuantity = value);
      }
    });
  }


}
