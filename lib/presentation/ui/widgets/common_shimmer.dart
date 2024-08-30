import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class CommonPlaceHolder extends StatelessWidget {
  final double? height;
  final double? width;
  final double cornerRadius;
  final Gradient? gradient;
  final EdgeInsetsGeometry? margin;
  const CommonPlaceHolder({
    this.height,
    this.width,
    this.cornerRadius = 3,
    this.gradient,
    this.margin,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width?? 50.w,
      height: height?? 50.h,
      padding: margin,
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade700,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(cornerRadius.r),
            color: Colors.grey.shade100,
          ),
        ),
      ),
    );
  }
}