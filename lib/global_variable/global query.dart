
library govdummy.globals;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

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
  }
}
""";

String allProductsQuery="""
query allproducts{
  products{
    
    edges{
      id
      name
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
      }     
    }
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