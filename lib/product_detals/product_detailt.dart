import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
class ProductDetailPage extends StatefulWidget {
  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  Widget build(BuildContext context) {
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
                    images: [
                      Image.asset('assets/veg.jpg'),
                      Image.asset('assets/veg.jpg'),
                      Image.asset('assets/veg.jpg'),
                    ],
                    
                  ),
                ),
              ) 
              ,
            ),
            new SizedBox(height: 10.0,),
            new Card(
                          child: new Container(
                           padding: EdgeInsets.only(top: 15.0,bottom: 15.0),
                                                      child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Flexible(
                    child: new Container(
                      padding: EdgeInsets.only(left: 5.0,right: 5.0),
                        child: new Text("Product Name",textAlign: TextAlign.left,
                        style: new TextStyle(
                            
                            color: Colors.black,
                            fontSize: 16.0, fontWeight: FontWeight.bold
                        ),),
                      ),

                  ),

                                   new Flexible(
                    child: new Container(
                      padding: EdgeInsets.only(left: 5.0,right: 5.0),
                        child: new Text("Available",textAlign: TextAlign.right,
                        style: new TextStyle(
                            
                            color: Colors.black,
                            fontSize: 14.0, 
                        ),),
                      ),

                  )


                ],
              ),
                          ),
            )
          ],
        )
        ,      
      ),
    );
  }
}