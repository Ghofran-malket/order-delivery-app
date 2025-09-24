import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFieldWidget extends StatelessWidget {
  String hint;
  TextEditingController controller = TextEditingController();
  IconData icon;

  TextFieldWidget({super.key, required this.hint, required this.controller, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(0, 0, 0, 0.12),
            offset: Offset(
              0.0,
              ScreenUtil().setWidth(3.0),
            ), //(x,y)
            blurRadius: ScreenUtil().setWidth(6.0),
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(
          ScreenUtil().setWidth(7),
        )),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: Colors.indigo,
            ),
            hintText: hint,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
