import 'package:design_demo/data_server_from_dart/my_product_details.dart';
import 'package:design_demo/my_product/myproduct_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:design_demo/global_variable/global query.dart' as globals;

import 'add_product.dart';
class MYProducts extends StatefulWidget {
  @override
  _MYProductsState createState() => _MYProductsState();
}

class _MYProductsState extends State<MYProducts> {

  List<MyProductDetails>_myproductDetailsdata=new List();
 
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: new AppBar(
        title: new Text("My PRoducts"),
      ),
      body: new Query(builder: (QueryResult result, {VoidCallback refetch}) {
        if(result.hasErrors){
         // print(result.errors.toString());
        }
        if(result.loading){
          return new Text("loading");
        }
       // print(result.data.toString());
        List productsData=result.data['products']['edges'];

        return new ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            var singleData=productsData[index];
            List image=singleData['images'];

            _myproductDetailsdata.add(new MyProductDetails(

              


            ));

            
            //image[0]==null;
            
            return new ListTile(
              leading: new Container(
                child: image==null?new Icon(Icons.add_a_photo):
                image.isEmpty?new Text("a"):new Image.network(image[0]['url'])
              ),
              title: new Text(singleData['name'].toString()??"not found"),
              subtitle: new Text("price:${singleData['price']}  ${singleData['price_extension']}"),
              trailing: singleData['available_now']?new Icon(Icons.assignment_turned_in,color: Colors.green,):
              new Icon(Icons.assignment_turned_in),

              onTap: (){
                print(singleData['name']);
                print(singleData['id']);
                                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new MyProductDetailPage(
                                              id: singleData['id']??null,
              productName: singleData['name']??null,
              price: singleData['price']??null,
              priceExtension: singleData['price_extension']??null,
              minQuantity: singleData['min_quantity']??null,
              minQuantityExtension: singleData['min_quantity_extension']??null,
              quantity: singleData['quantity']??null,
              quantityExtension: singleData['quantity_extension']??null,
              productDescription: singleData['description']??null,
              availableNow: singleData['available_now']??null,
              retailAble: singleData['retailable']??null,
              images: image??null
                                
                              )));
              },


            );

          },
          itemCount: productsData.length,

        );


        
      }, options: QueryOptions(
        document: globals.myProductsListQuery,
        variables:<String,dynamic> {
          'userId':globals.userOwnerId.toString()
        },
        pollInterval: null

      ),

      ),

      floatingActionButton: new FloatingActionButton(
        tooltip: 'Add Product',
        child: new Icon(Icons.add), 
        onPressed: () {
        //   Navigator.of(context).push(new MaterialPageRoute(
        //   builder: (BuildContext context) =>new AddNEwProduct()

        // ));

        _awaitReturnvalueFromAddProduct(context);
        },
      ),
      
    );
  }

  _awaitReturnvalueFromAddProduct(BuildContext context)async {

    final pollIntervalActivator=await Navigator.push(context, new MaterialPageRoute(
      builder: (BuildContext context) =>new AddNEwProduct()

    ));

    setState(() {
      //_polIntervalGetter=pollIntervalActivator;
    });


  }
}