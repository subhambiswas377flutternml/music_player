import 'package:flutter/material.dart';

extension ContextExtension on BuildContext{
  double get screenHeight => MediaQuery.of(this).size.height;
  double get screenWidth => MediaQuery.of(this).size.width;
  double screenHeightPercentage(double val){
    assert(val<=100,"Percentahe can't be more than 100");
    return MediaQuery.of(this).size.height*val/100;
  }
  double screenWidthPercentage(double val){
    assert(val<=100,"Percentahe can't be more than 100");
    return MediaQuery.of(this).size.width*val/100;
  }
}