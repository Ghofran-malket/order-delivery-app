import 'package:flutter/material.dart';
import 'dart:math';


class NotificationTimerWidget extends StatefulWidget {
  const NotificationTimerWidget({super.key});

  @override
  NotificationTimerWidgetState createState() => NotificationTimerWidgetState();
}

class NotificationTimerWidgetState extends State<NotificationTimerWidget>
    with TickerProviderStateMixin {
  late AnimationController animationController;

  String get timerString {
    Duration duration =
        animationController.duration !* animationController.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();

    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 60));
    animationController.reverse(
        from:
        animationController.value == 0.0 ? 1.0 : animationController.value);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 60,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: AnimatedBuilder(
                animation: animationController,
                builder: (BuildContext context, Widget? child) {
                  return CustomPaint(
                    painter: TimerPainter(
                        animation: animationController,
                        backgroundColor: Color(0xFFAB2929),
                        color: Colors.white),
                  );
                },
              ),
            ),
            Align(
                alignment: FractionalOffset.center,
                child: AnimatedBuilder(
                    animation: animationController,
                    builder: (context, Widget? child) {
                      return Text(
                        timerString,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          letterSpacing: 0.5,
                          color: Color(0xFF252B37),
                        ),
                      );
                    }))
          ],
        ),
      ),
    );
  }
}

class TimerPainter extends CustomPainter {
  final Animation<double> animation;
  final Color backgroundColor;
  final Color color;

  TimerPainter({required this.animation, required this.backgroundColor, required this.color})
      : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 5.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    paint.color = color;
    double progress = (1.0 - animation.value) * 2 * pi;
    canvas.drawArc(Offset.zero & size, pi * 1.5, -progress, false, paint);
  }

  @override
  bool shouldRepaint(TimerPainter old) {
    return animation.value != old.animation.value ||
        color != old.color ||
        backgroundColor != old.backgroundColor;
  }
}
