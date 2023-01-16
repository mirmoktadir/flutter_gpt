import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(bottom: 100.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(
            'animations/error.json',
            height: 180.h,
            repeat: true,
            reverse: true,
            fit: BoxFit.cover,
          ),
          Center(
              child: Text(
            "Empty or No data !",
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w400,
              color: theme.hintColor,
            ),
          ))
        ],
      ),
    );
  }
}
