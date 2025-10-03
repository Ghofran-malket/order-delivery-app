import 'package:algenie/presentation/screens/genie_screens/home_screen.dart';
import 'package:algenie/presentation/widgets/primary_button_widget.dart';
import 'package:algenie/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class InviteFriendsScreen extends StatefulWidget {
  const InviteFriendsScreen({super.key});

  @override
  State<InviteFriendsScreen> createState() => _InviteFriendsScreenState();
}

class _InviteFriendsScreenState extends State<InviteFriendsScreen> {

  void inviteLink() async {
    final AuthService apiService = AuthService();
    await apiService.inviteFriend();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/background.jpg'),
                  fit: BoxFit.cover)),
          child: Column(
            children: <Widget>[
              //appBar
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 17, vertical: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Icon(Icons.keyboard_arrow_left,
                            color: Color(0xFF252B37),
                            size: ScreenUtil().setSp(25)),
                    Expanded(
                      child: Text(
                        "Invite Your Friends",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Poppin-semibold",
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    //Image.asset(ImageConfig.logoCircle)
                  ],
                ),
              ),

              Spacer(),

              //text Invite 3 Friends and earn
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Invite a friend and earn a ",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: "Poppin-semibold",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Text(
                        "10\$",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: "Poppin-semibold",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      )
                    ],
                  )),

              Spacer(),

              //image
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Image.asset(
                        'assets/algenie_logo.png',
                        width: 212.0,
                        height: 219.92,
                      )
                    ],
                  )
                ],
              ),

              Spacer(),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 17),
                child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: ScreenUtil().setHeight(12),
                        horizontal: ScreenUtil().setWidth(12)),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                            Radius.circular(ScreenUtil().setWidth(20))),
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
                        color: Colors.white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              "Your Referral Link Is",
                              style: TextStyle(
                                fontFamily: "Poppin-semibold",
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "algenie/referralLink",
                          style: TextStyle(
                            fontFamily: "Poppin-semibold",
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFFED1B24),
                          ),
                        )
                      ],
                    )),
              ),

              Spacer(),

              //button
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(17),
                    vertical: ScreenUtil().setHeight(16)),
                child: PrimaryButtonWidget(
                    color: Color(0xFFAB2929),
                    title: 'Invite a Friend',
                    isLoading: false,
                    function: inviteLink,
                )
              ),

              InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (context) => const GenieHome(),
                      ),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 22, horizontal: 17),
                    child: Center(
                      child: Text(
                        "Skip",
                        style: TextStyle(
                          fontFamily: "Poppin-semibold",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFAB2929),
                        ),
                      ),
                    ),
                  ))
            ],
          ),
        ),
      );
  }
}
