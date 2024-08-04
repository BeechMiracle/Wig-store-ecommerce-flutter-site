import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const String pKey = 'pk_test_7f3e633f0eb6e10c93b5a2720253daaf37fce116';
const kWhiteColor = Colors.white;

const kBColor = Color(0xFFE9E9E9);

TextStyle kAppBarTextStyle = GoogleFonts.roboto(
  textStyle: const TextStyle(
    color: Color(0xFF141414),
    fontSize: 15,
    fontWeight: FontWeight.normal,
  ),
);

TextStyle kLargeH2text = GoogleFonts.roboto(
  textStyle: const TextStyle(
      color: Color(0xFF141414), fontSize: 20, fontWeight: FontWeight.w500),
);

TextStyle kLargeH1text = GoogleFonts.roboto(
  textStyle: const TextStyle(
      color: Color(0xFF141414), fontSize: 80, fontWeight: FontWeight.normal),
);

TextStyle kLargeHeaderText = GoogleFonts.roboto(
  textStyle: const TextStyle(
    color: Color(0xFF141414),
    fontSize: 20,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.5,
  ),
);

TextStyle kLargeSubHeaderText = GoogleFonts.roboto(
  textStyle: const TextStyle(
    color: Color(0xFF707070),
    fontSize: 15,
    fontWeight: FontWeight.normal,
    letterSpacing: 0.5,
  ),
);

TextStyle kCollectionText = GoogleFonts.roboto(
  textStyle: const TextStyle(
    color: Color(0xFFFFFFFF),
    fontSize: 30,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  ),
);

TextStyle kLargeButtonStyle = GoogleFonts.roboto(
  textStyle: const TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w500,
    fontSize: 15,
  ),
);

final searchTextField = InputDecoration(
    contentPadding: const EdgeInsets.symmetric(
      vertical: 10,
      horizontal: 20,
    ),
    filled: true,
    fillColor: const Color(0xFFFFFFFF),
    hintStyle: TextStyle(
      color: const Color(0xFF141414).withOpacity(0.2),
      fontSize: 15,
      fontWeight: FontWeight.normal,
    ),
    prefixIcon: const Icon(
      Icons.search,
      color: Color(0xFF141414),
      size: 20,
    ),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none)
    // enabledBorder: OutlineInputBorder(
    //   borderRadius: BorderRadius.circular(20),
    //   borderSide: const BorderSide(
    //     width: 1,
    //     color: Color(0xFF707070),
    //   ),
    // ),
    // focusedBorder: OutlineInputBorder(
    //   borderRadius: BorderRadius.circular(20),
    //   borderSide: const BorderSide(
    //     color: Color(0xFF1A341E),
    //     width: 1,
    //   ),
    // ),
    );

extension extString on String {
  bool get isValidEmail {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(this);
  }

  bool get isValidName {
    final nameRegExp =
        RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
    return nameRegExp.hasMatch(this);
  }

  bool get isValidPassword {
    final passwordRegExp = RegExp(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\><*~]).{8,}/pre>');
    return passwordRegExp.hasMatch(this);
  }

  bool get isNotNull {
    return this != null;
  }

  bool get isValidPhone {
    final phoneRegExp = RegExp(r"^\+?0[0-9]{10}$");
    return phoneRegExp.hasMatch(this);
  }
}
