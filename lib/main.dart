import 'package:design_demo/graphql/graphql_object1.dart';
import 'package:design_demo/model.dart';
import 'package:design_demo/navigation_main/home_page_main.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

import 'login_signup/log_in.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  // @override
  // Widget build(BuildContext context) {

  //   return GraphQLProvider(
  //        client: graphQLObject.client,
  //         child: MaterialApp(
  //       title: 'Flutter Demo',
  //       theme: ThemeData(
  //         primarySwatch: Colors.blue,
  //       ),
  //       home:new ChangeNotifierProvider(
  //         builder: (BuildContext context) =>AppState(true,true,true,Colors.black,Colors.white),
  //         child: new HomePAgeMAin(),

  //       ),

  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return new ChangeNotifierProvider(
      builder: (BuildContext context) =>
          AppState(true, true, true, Colors.black, Colors.white),
      child: new GraphQLProvider(
        client: graphQLObject.client,
        child: new MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: new HomePAgeMAin()),
      ),
    );
  }
}
