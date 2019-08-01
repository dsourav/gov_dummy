import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:design_demo/global_variable/global query.dart' as globals;

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
      body: new Query(builder: (QueryResult result, {VoidCallback refetch}) {
        if(result.hasErrors){
          print(result.errors.toString());
        }
        if(result.loading){
          return new Text("loading");
        }
        print(result.data.toString());
        List productsData=result.data['products']['edges'];

        return new ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            var singleData=productsData[index];
            return new ListTile(
              leading: new CircleAvatar(
                backgroundColor: Colors.white,
                child: new Image.network(singleData['images'][0]['url'])??new Icon(Icons.ac_unit),
              ),
              title: new Text(singleData['name'].toString()??"not found"),
              subtitle: new Text("price:${singleData['price']}  ${singleData['price_extension']}"),


            );

          },
          itemCount: productsData.length,

        );


        
      }, options: QueryOptions(
        document: globals.myProductsListQuery,
        variables: {
          '\$userId':globals.userOwnerId
        }

      ),

      ),






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