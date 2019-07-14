import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';


class GraphQLObject{
  static HttpLink httpLink = HttpLink(
    uri: 'https://agro-e-commerce.herokuapp.com/graphql',
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

