import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PrimaryButtonWidget extends StatelessWidget {
  Color? color;
  String title;
  bool isLoading;
  GestureTapCallback function;

  PrimaryButtonWidget({super.key, required this.color, required this.title, required this.isLoading, required this.function});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Container(
        height: ScreenUtil().setHeight(40),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(
          Radius.circular(ScreenUtil().setWidth(20))),
        ),
        child: Center(
          child: isLoading ? SpinKitThreeBounce(
            color: Colors.white,
            size: 30,
          ): Text( title,
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontFamily: "Poppin-semibold",
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          )
        ),
      ),
    );
  }
}
