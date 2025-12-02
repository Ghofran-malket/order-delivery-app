import 'dart:developer';
import 'package:algenie/data/models/order_model.dart';
import 'package:algenie/presentation/screens/genie_screens/order_details-screen.dart';
import 'package:algenie/presentation/widgets/notification_timer_widget.dart';
import 'package:algenie/presentation/widgets/primary_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';

class OrderNotificationScreen extends StatefulWidget {
  final Order order;
  const OrderNotificationScreen({super.key, required this.order});

  @override
  OrderNotificationScreenState createState() => OrderNotificationScreenState();
}

class OrderNotificationScreenState extends State<OrderNotificationScreen> {
  final player = AudioPlayer();
  bool clicked = false;

  ring() async {
    await player.setAsset('assets/notification.mp3');
    await player.setLoopMode(LoopMode.one);
    player.play();
    await Future.delayed(Duration(seconds: 60), () async {
      if (!clicked) {
        log("You didn't take this order");
        //TODO genie ignore this order
        //Navigator.of(context).pop();
      }
      await player.stop();
    });
  }

  @override
  void initState() {
    ring();
    super.initState();
  }

  @override
  void dispose() async {
    await player.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(0.00, -2.00),
              color: Color(0xff000000).withValues(alpha: 0.16),
              blurRadius: ScreenUtil().setWidth(6),
            ),
          ],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(11.00),
            topRight: Radius.circular(11.00),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(17)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                top: ScreenUtil().setHeight(1.5),
              ),
              child: SizedBox(
                height: ScreenUtil().setHeight(2.0),
                width: ScreenUtil().setWidth(43),
                child: DecoratedBox(
                  decoration: BoxDecoration(color: Color(0xFFC4C4C4)),
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(
                //top: ScreenUtil().setHeight(38),
                left: ScreenUtil().setWidth(15),
                right: ScreenUtil().setWidth(15),
              ),
              child: NotificationTimerWidget(),
            ),
            Spacer(),
            SizedBox(
              width: ScreenUtil().setWidth(300),
              child: Image.asset(
                "assets/bell.gif",
                //  fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: ScreenUtil().setHeight(6)),
            Text("10 Minutes Away",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: "Poppins-Medium",
                  //fontSize: ScreenUtil().setHeight(17),
                  color: Color(0xFF858585),
                )),
            SizedBox(
              height: ScreenUtil().setHeight(5),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //order.chargeService}
                Text("50\$ ",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: "poppin-semibold",
                      //fontSize: 22,
                      color: Color(0xFFAB2929),
                    )),
                Text(" Estimated Total",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: "Poppins-Medium",
                      //fontSize: ScreenUtil().setHeight(16),
                      color: Colors.black,
                    )),
              ],
            ),
            Spacer(),
            PrimaryButtonWidget(
                color: Color(0xFFAB2929),
                title: "let's go",
                isLoading: clicked,
                function: () async => {
                      //TODO accept order then go to orderdetails page
                      setState(() {
                        clicked = !clicked;
                      }),
                      await player.stop(),
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                OrderDetailsScreen(order: widget.order)),
                      ),
                    }),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () async {
                    await player.stop();
                    //TODO reject order and go to online screen
                  },
                  child: Text(
                    "Reject",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: "poppin-semibold",
                      //fontSize: ScreenUtil().setSp(16),
                      color: Color(0xFFAB2929),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    final navigator = Navigator.of(context);

                    await player.stop();
                    navigator.popUntil((route) => route.isFirst);
                    //TODO go to order deatils screen with accept and reject buttons
                    navigator.push(
                      MaterialPageRoute(
                          builder: (context) =>
                              OrderDetailsScreen(order: widget.order)),
                    );
                  },
                  child: Text(
                    "More details ...",
                    textAlign: TextAlign.left,
                    softWrap: true,
                    style: TextStyle(
                      fontFamily: "poppin-semibold",
                      //fontSize: ScreenUtil().setSp(16),
                      // color: Config.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
