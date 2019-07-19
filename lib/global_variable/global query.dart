
library govdummy.globals;
import 'package:shared_preferences/shared_preferences.dart';
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


 getToken() async {
final prefs = await SharedPreferences.getInstance();
final tokenValue=prefs.getString("token");
return tokenValue??null;
}

setToken(String tokenValue) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString("token", tokenValue);
}

removeToken() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.remove("token");

}