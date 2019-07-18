library govdummy.globals;

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