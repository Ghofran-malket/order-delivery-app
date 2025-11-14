import 'package:algenie/presentation/widgets/slider_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RateScreen extends StatefulWidget {
  final String orderId;

  const RateScreen({super.key, required this.orderId});

  @override
  _RateScreenState createState() => _RateScreenState();
}

class _RateScreenState extends State<RateScreen> {

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
          child: Column(
            children: <Widget>[
              //appBar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      "Reviews",
                      textAlign: TextAlign.center,
                      //style: FontConfig.semiBold_20,
                    ),
                  ),
                  Image.asset('assets/logoCircle.png')
                ],
              ),

              SizedBox(height: ScreenUtil().setHeight(50)),

              Container(
                  height: ScreenUtil().setHeight(100),
                  width: ScreenUtil().setHeight(100),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/person.png')))),
              
              SizedBox(height: ScreenUtil().setHeight(10)),

              Text(
                'Customer name',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Poppins-Medium",
                  fontSize: ScreenUtil().setSp(18),
                  color: Color(0xFF252B37),
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(3)),
              Text(
                "City , Country",
                style: TextStyle(
                  fontFamily: "Poppins-Regular",
                  fontSize: ScreenUtil().setSp(12),
                  //color: HexColor("#858585"),
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(3)),

              Text(
                "knows these Languages",
                style: TextStyle(
                  fontFamily: "Poppins-Regular",
                  fontSize: ScreenUtil().setSp(12),
                  color: Color(0xFF858585),
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(20)),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Wrap(
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.start,
                    spacing: ScreenUtil().setWidth(5.3),
                    children: <Widget>[
                      Text(
                        "25",
                        //style: FontConfig.semiBold_12
                      ),
                      Icon(
                        Icons.thumb_up_alt,
                        color: Color(0xFFAB2929),
                      )
                    ],
                  ),
                  Wrap(
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.start,
                      spacing: ScreenUtil().setWidth(5.3),
                      children: <Widget>[
                        Text(
                          "10",
                          //style: FontConfig.semiBold_12
                        ),
                        Icon(
                          Icons.thumb_down_alt,
                          color: Color(0xFFAB2929),
                        )
                      ])
                ],
              ),

              SizedBox(height: ScreenUtil().setHeight(20)),

              Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscingelit, sed do eiusmod tempor incididunt ut labore et.",
                style: TextStyle(
                  fontFamily: "Poppins-Regular",
                  fontSize: ScreenUtil().setSp(13.2),
                  color: Color(0xFF858585),
                ),
              ),

              SizedBox(height: ScreenUtil().setHeight(40)),

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
                  InkWell(
                    onTap: () async {
                      //Evaluate the Customer and then go to online screen
                    },
                    child: Container(
                        height: ScreenUtil().setHeight(60),
                        width: ScreenUtil().setHeight(60),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(color: Colors.grey)),
                        child:
                            Icon(Icons.thumb_up_rounded, color: Colors.grey)),
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(64),
                  ),
                  InkWell(
                    onTap: () async {
                      //Evaluate the Customer and then go to online screen
                    },
                    child: Container(
                        height: ScreenUtil().setHeight(60),
                        width: ScreenUtil().setHeight(60),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(color: Colors.grey)),
                        child:
                            Icon(Icons.thumb_down_rounded, color: Colors.grey)),
                  ),
                ],
              ),

              SizedBox(height: ScreenUtil().setHeight(50)),

              //button
              SliderButtonWidget(
                  label: "Report a Customer",
                  onAction: () async {
                    // go to reports screen
                  }),

            ],
          ),
        ),
      ),
    );
  }
}
