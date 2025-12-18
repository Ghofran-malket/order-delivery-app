import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CountdownTimerWidget extends StatefulWidget {
  const CountdownTimerWidget({super.key});

  @override
  _CountdownTimerWidgetState createState() => _CountdownTimerWidgetState();
}

class _CountdownTimerWidgetState extends State<CountdownTimerWidget> {
  static const int initialTimeInSeconds = 60 * 60; // 60 minutes
  int _remainingSeconds = initialTimeInSeconds;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int secs = seconds % 60;
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = secs.toString().padLeft(2, '0');
    return '$minutesStr:$secondsStr';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            color: Color(0xFFAB2929),
            borderRadius:
                BorderRadius.all(Radius.circular(ScreenUtil().setWidth(8)))),
        child: Text(
          formatTime(_remainingSeconds),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(color:Colors.white),
        ),
      ),
    );
  }
}
