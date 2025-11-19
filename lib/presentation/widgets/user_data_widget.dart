import 'package:algenie/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserDataWidget extends StatelessWidget {
  final User user;
  final String title;
  const UserDataWidget({super.key, required this.user, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(Icons.keyboard_arrow_left,
                color: Color(0xFF252B37),
                size: ScreenUtil().setSp(25)),
            ),
            Expanded(
              child: Text(
                title,
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
                    fit: BoxFit.fill, image: NetworkImage(user.image!)))),
        SizedBox(height: ScreenUtil().setHeight(10)),
        Text(
          user.name,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: "Poppins-Medium",
            fontSize: ScreenUtil().setSp(18),
            color: Color(0xFF252B37),
          ),
        ),
        SizedBox(height: ScreenUtil().setHeight(3)),
        Text(
          "${user.city!} , ${user.country!}",
          style: TextStyle(
            fontFamily: "Poppins-Regular",
            fontSize: ScreenUtil().setSp(12),
            //color: HexColor("#858585"),
          ),
        ),
        SizedBox(height: ScreenUtil().setHeight(3)),
        Text(
          "${user.name} knows these languages : ${user.languages}",
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
                  user.likeCount.toString(),
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
                    user.disLikeCount!.abs().toString(),
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
          user.bio!,
          style: TextStyle(
            fontFamily: "Poppins-Regular",
            fontSize: ScreenUtil().setSp(13.2),
            color: Color(0xFF858585),
          ),
        ),
        SizedBox(height: ScreenUtil().setHeight(40)),
        
      ],
    );
  }
}
