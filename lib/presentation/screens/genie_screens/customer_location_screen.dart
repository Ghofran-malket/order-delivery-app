import 'package:algenie/data/models/order_model.dart';
import 'package:algenie/presentation/screens/genie_screens/deliver_to_customer_screen.dart';
import 'package:algenie/presentation/widgets/order_stages_bar_widget.dart';
import 'package:algenie/presentation/widgets/order_timer_widget.dart';
import 'package:algenie/presentation/widgets/slider_button_widget.dart';
import 'package:algenie/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomerLocationScreen extends StatelessWidget {
  final Order order;
  const CustomerLocationScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            OrderStagesBarWidget(
              order: order,
            ),

            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Container(
                  height: ScreenUtil().setHeight(2),
                  width: MediaQuery.of(context).size.width / 2.01,
                  color: Color.fromRGBO(0, 0, 0, 0.12)),
              Container(
                  height: ScreenUtil().setHeight(2),
                  width: MediaQuery.of(context).size.width / 2.01,
                  color: Color(0xFF252B37))
            ]),

            SizedBox(height: ScreenUtil().setHeight(20)),

            //timer
            CountdownTimerWidget(),

            SizedBox(height: ScreenUtil().setHeight(30)),

            Center(
              child: Text(
                "Go to customer location",
                style: TextStyle(
                  fontFamily: "Poppins-Medium",
                  fontSize: 20,
                  color: Color(0xFF000000),
                ),
              ),
            ),

            SizedBox(
              height: ScreenUtil().setHeight(17),
            ),

            Image.asset(
              "assets/route-finder.gif",
              height: ScreenUtil().setHeight(188),
              width: ScreenUtil().setWidth(190),
            ),

            SizedBox(height: ScreenUtil().setHeight(17)),

            //navigate
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset("assets/arrows.png",
                    height: ScreenUtil().setHeight(18.5),
                    width: ScreenUtil().setWidth(18.5),
                    color: Color(0xFFAB2929)),
                SizedBox(
                  width: ScreenUtil().setWidth(8.4),
                ),
                InkWell(
                  onTap: () async {
                    
                  },
                  child: Text(
                    "Navigate",
                    style: TextStyle(
                      fontFamily: "poppin-semibold",
                      fontSize: ScreenUtil().setSp(17),
                      color: Color(0xFFAB2929),
                    ),
                  ),
                )
              ],
            ),

            SizedBox(height: ScreenUtil().setHeight(30)),

            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(17)),
              child: Column(
                children: [
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.location_on,
                        color: Color(0xFFAB2929),
                      ),
                      SizedBox(
                        width: ScreenUtil().setWidth(4),
                      ),
                      Text(
                        "Customer Address",
                        style: TextStyle(
                          fontFamily: "Poppins-Medium",
                          fontSize: ScreenUtil().setSp(15),
                          color: Color(0xFF252B37),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(10),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(
                        ScreenUtil().setWidth(8),
                      )),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.12),
                          offset: Offset(
                            0.0,
                            ScreenUtil().setWidth(3.0),
                          ), //(x,y)
                          blurRadius: ScreenUtil().setWidth(6.0),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.only(
                        top: 12, bottom: 12, left: 12, right: 22),
                    child: Text(
                      "${order.orderLocation}",
                      style: TextStyle(
                        fontFamily: "Poppins-Regular",
                        fontSize: ScreenUtil().setSp(12),
                        color: Color(0xFF252B37),
                      ),
                    ),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(40)),
                  SliderButtonWidget(
                    label: "Arrived to Cutomer",
                    onAction: () async{
                      await AuthService().updateGenieProgress(orderId: order.orderId, step: 'deliverToCustomer');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DeliverToCustomerScreen(
                              order: order,
                            ),
                          ));
                    },
                  ),
                  SizedBox(height: ScreenUtil().setHeight(20)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
