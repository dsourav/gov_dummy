import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AppState extends ChangeNotifier{
  bool _obscureTextLogin;

  bool get obscureTextLogin => _obscureTextLogin;

  
  bool _obscureTextSignup;

  bool get obscureTextSignup => _obscureTextSignup;

  
  bool _obscureTextSignupConfirm;

  bool get obscureTextSignupConfirm => _obscureTextSignupConfirm;

  Color _colorLeft;

  Color get colorLeft => _colorLeft;

  
  Color _colorRight;

  Color get colorRight => _colorRight;

  

  
  AppState(this._obscureTextLogin,this._obscureTextSignup,this._obscureTextSignupConfirm,
  this._colorLeft,this._colorRight);

  void obSecureLogin(){
    _obscureTextLogin = !_obscureTextLogin;
    notifyListeners();
  }

  void obsecureSignup(){
    _obscureTextSignup = !_obscureTextSignup;
    notifyListeners();
  }

  void obsecureSignupConfirm(){
    _obscureTextSignupConfirm = !_obscureTextSignupConfirm;
    notifyListeners();
  }
  void colorLeftReverse(){
   _colorLeft=Colors.black;
    _colorRight=Colors.white;
    notifyListeners();

  }

  void colorRightReverse(){
    _colorLeft=Colors.white;
    _colorRight=Colors.black;
    notifyListeners();

  }
  
  }
  

