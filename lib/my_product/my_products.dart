import 'package:flutter/material.dart';

import 'add_product.dart';
class MYProducts extends StatefulWidget {
  @override
  _MYProductsState createState() => _MYProductsState();
}

class _MYProductsState extends State<MYProducts> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: new AppBar(
        title: new Text("My PRoducts"),
      ),
      body: new Container(),
      floatingActionButton: new FloatingActionButton(
        tooltip: 'Add Product',
        child: new Icon(Icons.add), 
        onPressed: () {

          Navigator.of(context).push(new MaterialPageRoute(
          builder: (BuildContext context) =>new AddNEwProduct()

        ));
        },
      ),
      
    );
  }
}