import 'package:design_demo/home_fragments/all_products.dart';
import 'package:design_demo/home_fragments/categories.dart';
import 'package:design_demo/login_signup/style/theme.dart' as prefix0;
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
  @override
  Widget build(BuildContext context) {
    return new Container(
        child: new ListView(
      children: <Widget>[
        new Query(
          builder: (QueryResult result, {VoidCallback refetch}) {
            if (result.errors != null) {
              return Text(result.errors.toString());
            }

            if (result.loading) {
              return Text('Loading');
            }
            List cateGorieslist = result.data['categories'];

            return new Container(
                child: new Column(
              children: <Widget>[
                new Container(
                  padding: EdgeInsets.only(top: 5.0, left: 5.0),
                  alignment: Alignment.centerLeft,
                  child: new Text(
                    "Categories",
                    style: new TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    top: 10,
                  ),
                  height: MediaQuery.of(context).size.height / 4,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    primary: false,
                    itemCount: cateGorieslist.length,
                    itemBuilder: (BuildContext context, int index) {
                      //Map place = places.reversed.toList()[index];
                      final _catName = cateGorieslist[index]['name'];
                      return new Card(
                        elevation: 6.0,
                        child: InkWell(
                          child: Container(
                            width: 140.0,
                            child: Column(
                              children: <Widget>[
                                Flexible(
                                  flex: 4,
                                  child: Image.asset(
                                    'assets/veg.jpg',

                                    // height: 178,
                                    //width: 120,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                //SizedBox(height: 7),
                                Flexible(
                                  flex: 1,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.amberAccent),
                                    padding: EdgeInsets.only(left: 5.0),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      _catName ?? null,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            //print("object");
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ));
          },
          options: QueryOptions(document: globals.categoriesQuery),
        ),
        new Container(
          padding: EdgeInsets.only(top: 5.0, left: 5.0),
          alignment: Alignment.centerLeft,
          child: new Text(
            "All Products",
            style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
            child: GridView.builder(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (BuildContext context, int index) {
            return new Card(
              child: new GridTile(
                child: Image.asset(
                  'assets/veg.jpg',
                  fit: BoxFit.fill,
                ),
                header: Opacity(
                  opacity: 0.9,
                  child: new Container(
                    padding: EdgeInsets.only(left: 5.0, top: 5.0, bottom: 5.0),
                    decoration: new BoxDecoration(
                      color: Colors.teal,
                    ),
                    child: new Align(
                      alignment: Alignment.centerLeft,
                      child: new Text(
                        "Veg Name",
                        style: new TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                footer: new Opacity(
                  opacity: 0.8,
                  child: new Container(
                    padding: EdgeInsets.only(left: 5.0, top: 5.0, bottom: 5.0),
                    decoration: new BoxDecoration(
                      color: Colors.greenAccent,
                    ),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Flexible(
                          child: new Container(
                            padding: EdgeInsets.only(left: 2.0, right: 2.0),
                            child: new Text(
                              "Price:",
                              style: new TextStyle(color: Colors.black),
                              textAlign: TextAlign.left,
                              maxLines: 1,
                            ),
                          ),
                        ),
                        new Flexible(
                          child: Container(
                            padding: EdgeInsets.only(left: 2.0, right: 2.0),
                            child: new Text(
                              "Qty:",
                              style: new TextStyle(color: Colors.black),
                              textAlign: TextAlign.right,
                              maxLines: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          itemCount: 10,
          physics: ScrollPhysics(), // to disable GridView's scrolling
          shrinkWrap: true,
        ))
      ],
    ));
  }
}
