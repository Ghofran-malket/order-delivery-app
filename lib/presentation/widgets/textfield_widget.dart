import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFieldWidget extends StatelessWidget {
  String hint;
  TextEditingController controller = TextEditingController();
  IconData? icon;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  double? height;

  TextFieldWidget(
      {super.key,
      required this.hint,
      required this.controller,
      this.icon,
      this.inputFormatters,
      this.keyboardType,
      this.maxLines = 1,
      this.height =50});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(10), horizontal: ScreenUtil().setWidth(12)),
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(0, 0, 0, 0.122),
            offset: Offset(
              0.0,
              ScreenUtil().setWidth(3.0),
            ), //(x,y)
            blurRadius: ScreenUtil().setWidth(6.0),
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(
          ScreenUtil().setWidth(20),
        )),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        maxLines: maxLines,
        decoration: InputDecoration(
            prefixIcon: icon != null
                ? Icon(
                    icon,
                    color: Color(0xFF252B37),
                  )
                : null,
            hintText: hint,
            border: InputBorder.none,
            hintStyle: keyboardType == TextInputType.multiline ? TextStyle(
              fontFamily: "Poppin-semibold",
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Color(0xFF4B4B4B),
            ): null),
      ),
    );
  }
}
