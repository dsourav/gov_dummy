import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:design_demo/global_variable/global query.dart'as globals;


class GraphQLObject{
  static HttpLink httpLink = HttpLink(
    uri: 'https://agro-e-commerce.herokuapp.com/graphql',
    headers: <String,String>{
      "x-token":globals.token??""
    }
  );
  static Link link = httpLink as Link;
  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      cache: InMemoryCache(),
      link: link,
      
    ),
  );
}

GraphQLObject graphQLObject=new GraphQLObject();

