import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slider_button/slider_button.dart';

class SliderButtonWidget extends StatelessWidget {
  final String label;
  final Function onAction;
  const SliderButtonWidget(
      {required this.label, required this.onAction, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Directionality(
                textDirection: TextDirection.ltr,
                child: SliderButton(
                  action: () async => onAction(),
                  alignLabel: Alignment.center,
                  backgroundColor: Color(0xFFAB2929),
                  shimmer: false,
                  height: ScreenUtil().setHeight(40),
                  radius: ScreenUtil().setWidth(20),
                  buttonColor: Colors.white,
                  buttonSize: 40,
                  baseColor: Color(0xFFAB2929),
                  label: Text(
                    label,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),
                  ),
                  icon: const Center(
                    child: Icon(
                      Icons.lock,
                      color: Color(0xFF252B37),
                    ),
                  ),
                )),
          ),
        
      ],
    );
  }
}
