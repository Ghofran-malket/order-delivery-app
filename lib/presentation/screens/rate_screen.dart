import 'package:algenie/data/models/order_model.dart';
import 'package:algenie/presentation/screens/genie_screens/home_screen.dart';
import 'package:algenie/presentation/screens/genie_screens/report_a_problem_screen.dart';
import 'package:algenie/presentation/widgets/slider_button_widget.dart';
import 'package:algenie/presentation/widgets/user_data_widget.dart';
import 'package:algenie/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RateScreen extends StatefulWidget {
  final Order order;

  const RateScreen({super.key, required this.order});

  @override
  _RateScreenState createState() => _RateScreenState();
}

class _RateScreenState extends State<RateScreen> {
  bool likeClicked = false;
  bool disLikeClicked = false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) async {
        //SystemNavigator.pop();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setWidth(17),
              vertical: ScreenUtil().setHeight(30)),
          child: FutureBuilder(
            future: AuthService().getUserInfo(widget.order.customerId),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return CircularProgressIndicator();

              var customer = snapshot.data!;
              return Column(
                children: <Widget>[
                  UserDataWidget(user: customer, title: 'Reviews'),
              
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Review Customer by Pressing Like or Dislike",
                          style: TextStyle(
                            fontFamily: "Poppins-Medium",
                            fontSize: ScreenUtil().setSp(15),
                            color: Color(0xFF252B37),
                          ),
                        ),
                      ),
                    ],
                  ),
              
                  SizedBox(height: ScreenUtil().setHeight(15)),
              
                  //like or dislike this customer
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      //like button
                      GestureDetector(
                        onTap: () async {
                          //Evaluate the Customer and then go to online screen
                          var result = await AuthService().giveRating(widget.order.customerId, 1);
                          setState(() {
                            customer = result;
                            likeClicked = !likeClicked;
                          });
                        },
                        child: Container(
                            height: ScreenUtil().setHeight(60),
                            width: ScreenUtil().setHeight(60),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey[200]),
                            child:
                                Icon(Icons.thumb_up_rounded, color: likeClicked ?Color(0xFFAB2929) :Colors.grey)),
                      ),
                      SizedBox(
                        width: ScreenUtil().setWidth(64),
                      ),
                      GestureDetector(
                        onTap: () async {
                          //Evaluate the Customer and then go to online screen
                          var result = await AuthService().giveRating(widget.order.customerId, -1);
                          setState(() {
                            customer = result;
                            disLikeClicked = !disLikeClicked;
                          });
                        },
                        child: Container(
                            height: ScreenUtil().setHeight(60),
                            width: ScreenUtil().setHeight(60),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey[200]
                            ),
                            child:
                                Icon(Icons.thumb_down_rounded, color: disLikeClicked ?Color(0xFFAB2929) :Colors.grey)),
                      ),
                    ],
                  ),
              
                  SizedBox(height: ScreenUtil().setHeight(50)),
              
                  //button
                  SliderButtonWidget(
                      label: "Report a Customer",
                      onAction: () async {
                        // go to reports screen
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (context) => ReportAProblemScreen(order:widget.order),
                          ),
                        );
                      }),
                  
                  SizedBox(height: 20),
                  
                  GestureDetector(
                    onTap: () async {
                      await AuthService().updateGenieProgress(orderId: widget.order.orderId, step: 'delivered');
                      Navigator.of(context).popUntil((route) => route.isFirst);
                      Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (context) => GenieHome(),
                          ),
                        );
                    },
                    child: Text(
                          "Go more orders",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: "Poppin-semibold",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFAB2929),
                          ),
                        ),
                  ),
              
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}
