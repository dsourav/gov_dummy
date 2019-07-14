import 'dart:ui';

import 'package:flutter/cupertino.dart';

class Colors {

  const Colors();

  static const Color loginGradientStart = Color.fromRGBO(5, 25, 55, 1.0);
  static const Color loginGradientEnd = Color.fromRGBO(16, 200, 18, 1.0);

  static const primaryGradient = const LinearGradient(
    colors: const [loginGradientStart, loginGradientEnd],
    stops: const [0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}