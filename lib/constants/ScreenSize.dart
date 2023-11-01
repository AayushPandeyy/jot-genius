import 'package:flutter/material.dart';

class ScreenSize {
  void init({required context}){
    _mediaQueryData = MediaQuery.of(context);
    screenHeight = _mediaQueryData.size.height;
    screenWidth = _mediaQueryData.size.width;
  }

  static late MediaQueryData _mediaQueryData;
  static late double screenHeight; 
  static late double screenWidth; 
}