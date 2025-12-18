import 'dart:io';

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
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          ],
        ),
        SizedBox(height: ScreenUtil().setHeight(50)),
        Container(
            height: ScreenUtil().setHeight(100),
            width: ScreenUtil().setHeight(100),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    fit: BoxFit.fill, image: user.image!.startsWith("http") ? NetworkImage(user.image!) : FileImage(File(user.image!))))),
        SizedBox(height: ScreenUtil().setHeight(10)),
        Text(
          user.name,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Color(0xFF252B37))
        ),
        SizedBox(height: ScreenUtil().setHeight(3)),
        Text(
          "${user.city!} , ${user.country!}",
          style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Color(0xFF858585))
        ),
        SizedBox(height: ScreenUtil().setHeight(3)),
        Text(
          "${user.name} knows these languages : ${user.languages}",
          style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Color(0xFF858585))
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
                  style: Theme.of(context).textTheme.labelSmall
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
                    style: Theme.of(context).textTheme.labelSmall
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
          style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Color(0xFF858585))
        ),
        SizedBox(height: ScreenUtil().setHeight(40)),
        
      ],
    );
  }
}
