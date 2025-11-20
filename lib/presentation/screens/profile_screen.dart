import 'package:algenie/data/models/order_model.dart';
import 'package:algenie/presentation/screens/genie_screens/report_a_problem_screen.dart';
import 'package:algenie/presentation/widgets/slider_button_widget.dart';
import 'package:algenie/presentation/widgets/user_data_widget.dart';
import 'package:algenie/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatelessWidget {
  final Order? order;
  final String userId;

  const ProfileScreen({super.key, this.order, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(17),
            vertical: ScreenUtil().setHeight(30)),
        child: FutureBuilder(
            future: AuthService().getUserInfo(userId),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return CircularProgressIndicator();

              var customer = snapshot.data!;
              return Column(
                children: [
                  UserDataWidget(
                    user: customer,
                    title: 'Profile',
                  ),

                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      //like button
                      InkWell(
                        onTap: () async {
                          // go to contact call
                        },
                        child: Container(
                            height: ScreenUtil().setHeight(60),
                            width: ScreenUtil().setHeight(60),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFFAB2929).withAlpha(50)),
                            child: Icon(Icons.call, color: Color(0xFFAB2929))),
                      ),
                      SizedBox(
                        width: ScreenUtil().setWidth(64),
                      ),
                      InkWell(
                        onTap: () async {
                          // go to chat screen
                        },
                        child: Container(
                            height: ScreenUtil().setHeight(60),
                            width: ScreenUtil().setHeight(60),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFFAB2929).withAlpha(50)),
                            child: Icon(Icons.chat, color: Color(0xFFAB2929))),
                      ),
                    ],
                  ),
                  SizedBox(height: ScreenUtil().setHeight(50)),

                  //button
                  order != null ? SliderButtonWidget(
                      label: "Report a Customer",
                      onAction: () async {
                        // go to reports screen
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (context) => ReportAProblemScreen(order:order!,),
                          ),
                        );
                      }): Container(),
                ],
              );
            }),
      ),
    );
  }
}
