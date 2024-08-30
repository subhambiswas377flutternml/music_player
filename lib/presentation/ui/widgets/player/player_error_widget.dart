import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_visualizer/core/extensions/context_extension.dart';

import '../../../bloc/music/music_bloc.dart';

class PlayerErrorWidget extends StatelessWidget {
  const PlayerErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.screenHeightPercentage(25),
      width: context.screenWidth,
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: Colors.white,
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        IconButton(
          onPressed: (){
            context.read<MusicBloc>().add(const FetchMusic());
          },
          icon: Icon(Icons.replay_outlined, size: 30.w,)),
          SizedBox(height: 10.h,),
          Flexible(
            child: Text("Something went wrong ! Try again.", style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: Colors.red,
            ),),
          )
      ],),
    );
  }
}