class FormValidator{
  static String validateSignUpFullName(String value){
    if(value.isEmpty){
      return "Full Name is Required";
    }
    if(value.length<5){
      return "Full Name Must Contain 5 Character";
    }
    else{
      return null;
    }
  }

  static String validateSignUpUserName(String value){
    if(value.isEmpty){
      return "User Name is Required";
    }
    if(value.length<3){
      return "User Name Must Contain 3 Character";
    }
    else{
      return null;
    }
  }

    static String validateSignUpUserAddress(String value){
    if(value.isEmpty){
      return "Address is Required";
    }
    if(value.length<6){
      return "Address Must Contain 6 Character";
    }
    else{
      return null;
    }
  }
  static String validateSignUpPhone(String value){
    if(value.isEmpty){
      return "Phone Number is Required";
    }
    if(value.length<11){
      return "Phone Number Must Have 11 Digit";
    }
    else{
      return null;
    }
  }

   static String validateSignUpEmail(String value){
    if(value.isEmpty){
      return "Email is Required";
    }
    bool emailValid = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
    if(!emailValid){
      return "Valid Email Is Required";
    }
    else{
      return null;
    }
  }

   static String validateSignUpPassword(String value){
     bool passWordValid=RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$").hasMatch(value);
    if(!passWordValid){
      return "Min 8 Characters, 1 letter and 1 number";
    }
   
    else{
      return null;
    }
  }

     static String validateSignUpPasswordConfirm(String value1,String value2){
     bool passWordValid2=RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$").hasMatch(value2);
    if(!passWordValid2){
      return "Min 8 Characters, 1 letter and 1 number";
    }
    
    if(!value1.contains(value2)){
      return "Password Doesn't Match";
    }
   
    else{
      return null;
    }
  }
}