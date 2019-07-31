
library govdummy.globals;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

var token;

String signUpQueryMutation=
"""mutation signuprun(\$full_name: String!,
\$user_name: String!,
\$email: String!,
\$phone: String!,
\$password: String!,
\$division: String!,
\$region: String!,
\$address: String!){
  signUp(data:{
    full_name:\$full_name
    user_name:\$user_name,
        email:\$email,
        phone:\$phone,
        password:\$password,
        division:\$division,
        region:\$region,
        address:\$address
    
  }){
    token
  }
}
""";

String signInQueryMutation="""
mutation signin(
\$login: String!,
\$password: String!

){
  signIn(
  login: \$login,
  password: \$password
  ){
    token
  }
}
""";

String categoriesQuery="""
query categoresitem{
  categories{
    name
    image
  }
}
""";
String categoriesNameQuery="""
query categoresitem{
  categories{
    name
    id
  }
}

""";
String allProductsQuery="""
query allproducts{
  products{
    edges{
      id
      name
      description
      quantity
      quantity_extension
      price
      price_extension
      available_now
      gov_price
      gov_price_extension
      category{
        name
      }
      retailable
      images{
        url
      }
      user{
        full_name
        image{
          url
        }
        address
        region
        division
        phone
      }     
    }
  }
}
""";

String addProductQeury="""mutation productadd(
  \$name: String!
  \$min_quantity: Int!,
  \$min_quantity_extension: String!,
  \$quantity: Int!,
  \$quantity_extension: String!,
  \$price: Float!,
  \$price_extension: String!,
  \$available_now: Boolean!,
  \$retailable: Boolean!,
  \$description: String!,
  \$gov_price: Float!,
  \$gov_price_extension: String!,
  \$categoryId: ID!
){
  addProduct(
    data:{
      name:\$name,
      min_quantity:\$min_quantity,
      min_quantity_extension:\$min_quantity_extension,
      quantity:\$quantity,
      quantity_extension:\$quantity_extension,
      price:\$price,
      price_extension:\$price_extension,
      available_now:\$available_now,
      retailable:\$retailable,
      description:\$description,
      gov_price:\$gov_price,
      gov_price_extension:\$gov_price_extension,
      categoryId:\$categoryId,
     
    }
  ){
    user{
      id
      user_name
    }
   
  }
  
}""";


String addProductImagesQuery="""
mutation productImage(\$image:Upload!){
  addProductImage(
    id:"72e31f2d-de71-4b23-a98e-4e0c78937b59"
    image:\$image
  ){
    url
    
  }
}
""";








Map<String, dynamic> parseJwt(String token) {
  final parts = token.split('.');
  if (parts.length != 3) {
    throw Exception('invalid token');
  }

  final payload = _decodeBase64(parts[1]);
  final payloadMap = json.decode(payload);
  if (payloadMap is! Map<String, dynamic>) {
    throw Exception('invalid payload');
  }

  return payloadMap;
}

String _decodeBase64(String str) {
  String output = str.replaceAll('-', '+').replaceAll('_', '/');

  switch (output.length % 4) {
    case 0:
      break;
    case 2:
      output += '==';
      break;
    case 3:
      output += '=';
      break;
    default:
      throw Exception('Illegal base64url string!"');
  }

  return utf8.decode(base64Url.decode(output));
}