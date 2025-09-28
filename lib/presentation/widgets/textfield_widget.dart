import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFieldWidget extends StatelessWidget {
  String hint;
  TextEditingController controller = TextEditingController();
  IconData icon;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  TextFieldWidget({super.key, required this.hint, required this.controller, required this.icon, this.inputFormatters, this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
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
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: TextField(
          controller: controller,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: Color(0xFF252B37),
            ),
            hintText: hint,
            border: InputBorder.none,
            
          ),
        ),
      ),
    );
  }
}
