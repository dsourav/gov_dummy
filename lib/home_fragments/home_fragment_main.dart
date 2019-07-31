import 'package:design_demo/data_server_from_dart/product_details.dart';
import 'package:design_demo/home_fragments/all_products.dart';
import 'package:design_demo/home_fragments/categories.dart';
import 'package:design_demo/login_signup/style/theme.dart' as prefix0;
import 'package:design_demo/product_detals/product_detailt.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controller.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:design_demo/global_variable/global query.dart' as globals;

class HomeFragmentMain extends StatefulWidget {
  @override
  _HomeFragmentMainState createState() => _HomeFragmentMainState();
}

class _HomeFragmentMainState extends State<HomeFragmentMain> {

  
  List<ProductDetailsDart> productsDeataildartData =
      new List<ProductDetailsDart>();
  @override
  Widget build(BuildContext context) {
    return new Container(
        child: new ListView(
      children: <Widget>[
        new Container(
          padding: EdgeInsets.only(top: 5.0, left: 5.0),
          alignment: Alignment.centerLeft,
          child: new Text(
            "Categories",
            style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
        ),
       // categories section
        // new Query(
        //   builder: (QueryResult result, {VoidCallback refetch}) {
        //     if (result.errors != null) {
        //       return Text(result.errors.toString());
        //     }

        //     if (result.loading) {
        //       return Text('Loading');
        //     }
        //     List cateGorieslist = result.data['categories'];

        //     return new Container(
        //         child: new Column(
        //       children: <Widget>[
        //         Container(
        //           padding: EdgeInsets.only(
        //             top: 10,
        //           ),
        //           height: MediaQuery.of(context).size.height / 4,
        //           width: MediaQuery.of(context).size.width,
        //           child: ListView.builder(
        //             scrollDirection: Axis.horizontal,
        //             primary: false,
        //             itemCount:
        //                 cateGorieslist.length??0 ,
        //             itemBuilder: (BuildContext context, int index) {
        //               //Map place = places.reversed.toList()[index];
        //               final _catName = cateGorieslist[index]['name']??"no";
        //               final _catImage = cateGorieslist[index]['image']??'assets/veg.jpg';
        //               //print(_catImage);

        //               return new Card(
        //                 elevation: 6.0,
        //                 child: new InkWell(
        //                   child: Container(
        //                     width: 140.0,
        //                     child: GridTile(
        //                       child: FadeInImage.assetNetwork(
        //                        image: 'assets/veg.jpg',
        //                         placeholder: 'assets/veg.jpg',
        //                         fit: BoxFit.fill,
        //                       ),
                       
        //                       footer: Container(
        //                         decoration:
        //                             BoxDecoration(color: Colors.amberAccent),
        //                         padding: EdgeInsets.only(left: 5.0),
        //                         alignment: Alignment.centerLeft,
        //                         child: Text(
        //                           _catName ,
        //                           style: TextStyle(
        //                             fontWeight: FontWeight.bold,
        //                             fontSize: 15,
        //                           ),
        //                           textAlign: TextAlign.left,
        //                         ),
        //                       ),
        //                     ),
        //                   ),
        //                 ),
        //               );
        //             },
        //           ),
        //         ),
        //       ],
        //     ));
        //   },
        //   options: QueryOptions(document: globals.categoriesQuery),
        // ),

        //all product text section
        new Container(
          padding: EdgeInsets.only(top: 5.0, left: 5.0),
          alignment: Alignment.centerLeft,
          child: new Text(
            "All Products",
            style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
        ),

        // new Query(
        //   builder: (QueryResult result, {VoidCallback refetch}) {
        //     if (result.hasErrors) {
        //       print(result.errors.toString());
        //     }
        //     if (result.loading) {
        //       return Text('Loading');
        //     }

        //     //print(result.data);
        //     List allProductslist = result.data['products']['edges'] ?? 2;

        //     //print(allProductslist.length.toString());
        //     return Card(
        //       elevation: 8.0,
        //       child: new Container(
        //           child: GridView.builder(
        //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //             crossAxisCount: 2),
        //         itemBuilder: (BuildContext context, int index) {
        //           final produtDescription = allProductslist[index] ;
        //           //final productImages=produtDescription['images']
        //           //print(produtDescription['user']['image']['url']);
        //           productsDeataildartData.add(new ProductDetailsDart(
        //               id: produtDescription['id'] ?? null,
        //               productName: produtDescription['name'] ?? null,
        //               quantity: produtDescription['quantity'] ?? null,
        //               quantityExtension:
        //                   produtDescription['quantity_extension'] ?? null,
        //               price: produtDescription['price'] ?? null,
        //               priceExtension:
        //                   produtDescription['price_extension'] ?? null,
        //               availableNow: produtDescription['available_now'] ?? null,
        //               govPrice: produtDescription['gov_price'] ?? null,
        //               govPriceExtension:
        //                   produtDescription['gov_price_extension'] ?? null,
        //               categoryName:
        //                   produtDescription['category']['name'] ?? null,
        //               retailable: produtDescription['retailable'] ?? null,
        //               images: produtDescription['images'] ?? null,
        //               ownerName: produtDescription['user']['full_name'] ?? null,
        //               ownerAddress:
        //                   produtDescription['user']['address'] ?? null,
        //               ownerDivision:
        //                   produtDescription['user']['division'] ?? null,
        //               ownerRegion: produtDescription['user']['region'] ?? null,
        //               ownerImage:
        //                   produtDescription['user']['image']['url'] ?? null,
        //               productDescription:
        //                   produtDescription['description'] ?? null,
        //               ownerPhone: produtDescription['user']['phone'] ?? null));
        //           // print(produtDescription['images'][0]);
        //           return InkWell(
        //             child: Card(
        //               elevation: 8.0,
        //               child: new GridTile(
        //                 child: FadeInImage.assetNetwork(
        //                   fit: BoxFit.fill,
        //                   image:produtDescription['images']!=null?produtDescription['images'][0]['url']
        //                           .toString(): 'assets/veg.jpg'??
        //                       'assets/vej.jpg',
        //                   placeholder: 'assets/veg.jpg',
        //                 ),
        //                 header: Opacity(
        //                   opacity: 0.9,
        //                   child: new Container(
        //                     padding: EdgeInsets.only(
        //                         left: 5.0, top: 5.0, bottom: 5.0),
        //                     decoration: new BoxDecoration(
        //                       color: Colors.teal,
        //                     ),
        //                     child: new Align(
        //                       alignment: Alignment.centerLeft,
        //                       child: new Text(
        //                         produtDescription['name'].toString() ??
        //                             "not found",
        //                         style: new TextStyle(color: Colors.white),
        //                       ),
        //                     ),
        //                   ),
        //                 ),
        //                 footer: new Opacity(
        //                   opacity: 0.8,
        //                   child: new Container(
        //                     padding: EdgeInsets.only(
        //                         left: 5.0, top: 5.0, bottom: 5.0),
        //                     decoration: new BoxDecoration(
        //                       color: Colors.greenAccent,
        //                     ),
        //                     child: new Row(
        //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                       children: <Widget>[
        //                         new Flexible(
        //                           child: new Container(
        //                             padding:
        //                                 EdgeInsets.only(left: 2.0, right: 2.0),
        //                             child: new Text(
        //                               "৳${produtDescription['price'].toString() ?? "not found"}",
        //                               style: new TextStyle(color: Colors.black),
        //                               textAlign: TextAlign.left,
        //                               maxLines: 1,
        //                             ),
        //                           ),
        //                         ),
        //                         new Flexible(
        //                           child: Container(
        //                             padding:
        //                                 EdgeInsets.only(left: 2.0, right: 2.0),
        //                             child: new Text(
        //                               "Qty: ${produtDescription['price_extension'].toString() ?? "not found"}",
        //                               style: new TextStyle(color: Colors.black),
        //                               textAlign: TextAlign.right,
        //                               maxLines: 1,
        //                             ),
        //                           ),
        //                         ),
        //                       ],
        //                     ),
        //                   ),
        //                 ),
        //               ),
        //             ),
        //             onTap: () {
        //               Navigator.of(context).push(new MaterialPageRoute(
        //                   builder: (BuildContext context) =>
        //                       new ProductDetailPage(
        //                         detailsDart: productsDeataildartData[index],
        //                       )));
        //             },
        //           );
        //         },
        //         itemCount: allProductslist.length,
        //         physics: ScrollPhysics(), // to disable GridView's scrolling
        //         shrinkWrap: true,
        //       )),
        //     );
        //   },
        //   options: QueryOptions(document: globals.allProductsQuery),
        // )
      ],
    ));
  }
}
