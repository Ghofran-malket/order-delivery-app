import 'package:algenie/data/models/order_model.dart';
import 'package:algenie/presentation/screens/rate_screen.dart';
import 'package:algenie/presentation/widgets/order_stages_bar_widget.dart';
import 'package:algenie/presentation/widgets/slider_button_widget.dart';
import 'package:algenie/services/api_service.dart';
import 'package:algenie/services/order_api_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeliverToCustomerScreen extends StatefulWidget {
  final Order order;
  const DeliverToCustomerScreen({super.key, 
    required this.order,
  });
  @override
  _DeliverToCustomerScreenState createState() => _DeliverToCustomerScreenState();
}

class _DeliverToCustomerScreenState extends State<DeliverToCustomerScreen> {
  bool checked = false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            //appBar
            OrderStagesBarWidget(
              order: widget.order,
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

            Spacer(),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(17)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Finish",
                    style: TextStyle(
                      fontFamily: "Poppins-Medium",
                      fontSize: 20,
                      color: Color(0xFF000000),
                    ),
                  ),

                  Text(
                    "widget.order.couponCode" == ""
                        ? "Amount Duo: ${widget.order.totalReceiptValue}"
                        : "Amount Duo: AfterDiscount",
                    style: TextStyle(
                      fontFamily: "Poppins-Medium",
                      fontSize: ScreenUtil().setSp(15),
                      color: Color(0xFF252B37),
                    ),
                  ),

                  SizedBox(height: ScreenUtil().setHeight(40)),

                  Image.asset(
                    "assets/algenie_logo.png",
                    height: ScreenUtil().setHeight(188),
                    width: ScreenUtil().setWidth(190),
                  ),

                  SizedBox(height: ScreenUtil().setHeight(40)),

                  "couponCode is not null" == "couponCode is not null" ? Text(
                      "The remaining amount will be transferred to your wallet",
                      style: TextStyle(
                        fontFamily: "Poppins-Medium",
                        fontSize: ScreenUtil().setSp(15),
                        color: Color(0xFF252B37),
                      ),
                      textAlign: TextAlign.center,
                    ) : Container(),
                
                  SizedBox(height: ScreenUtil().setHeight(50)),

                  InkWell(
                    onTap: () {
                      setState(() {
                        checked = !checked;
                      });
                    },
                    child: Row(
                      children: <Widget>[
                        Container(
                          height: ScreenUtil().setHeight(30),
                          width: ScreenUtil().setHeight(30),
                          decoration: BoxDecoration(
                              borderRadius: const 
                                  BorderRadius.all(Radius.circular(3.0)),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromRGBO(0, 0, 0, 0.16),
                                  offset: Offset(
                                    0.0,
                                    ScreenUtil().setWidth(1.0),
                                  ), //(x,y)
                                  blurRadius: ScreenUtil().setWidth(3.0),
                                ),
                              ],
                              color: Colors.white),
                          child: checked
                              ? Icon(
                                  Icons.check,
                                  color: Color(0xFFAB2929),
                                  size: ScreenUtil().setHeight(25),
                                )
                              : Container(),
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(12),
                        ),
                        Expanded(
                          child: Text(
                            "I confirm that I received the amount from customer",
                            style: const TextStyle(
                              fontFamily: "Poppin-semibold",
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  SizedBox(height: ScreenUtil().setHeight(40)),

                  checked ? SliderButtonWidget(
                    label: "Order Delivered",
                    onAction: () async {
                      //await OrderApiService().updateOrderStatus(widget.order.orderId, "delivered");
                      //if okay then go to rate a customer screen
                      await AuthService().updateGenieProgress(orderId: widget.order.orderId, step: 'rate');
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (context) => RateScreen(
                            order: widget.order,
                          ),
                        ),
                      );
                    },
                  ) : Container(),

                ],
              ),
            ),

            Spacer(),
          ],
        ),
      ),
    );
  }

}
