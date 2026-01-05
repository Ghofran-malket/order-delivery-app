import 'package:algenie/core/styles/app_style.dart';
import 'package:algenie/data/models/order_store_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';

class StoreCardWidget extends StatelessWidget {
  final OrderStore store;
  final Position initialPosition;
  const StoreCardWidget(
      {super.key,
      required this.store,
      required this.initialPosition});

  @override
  Widget build(BuildContext context) {
    var distanceInMeters = Geolocator.distanceBetween(
      initialPosition.latitude,
      initialPosition.longitude,
      store.location!.latitude,
      store.location!.longitude,
    );
    distanceInMeters /= 1000;
    distanceInMeters = distanceInMeters.round().toDouble();

    return InkWell(
      onTap: () {},
      splashColor: Color(0xFF252B37).withValues(alpha: 0.1),
      borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(8),)),
      child: Padding(
        padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: ScreenUtil().setHeight(130),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.all(Radius.circular(ScreenUtil().setWidth(8))),
                image: DecorationImage(
                  image: AssetImage('assets/apple2.jpg'),
                  fit: BoxFit.cover,
                ),
                boxShadow: [AppStyle.softShowStyle],
              ),
            ),
            SizedBox(height: ScreenUtil().setHeight(5),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  store.name,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: Color(0xFF252B37)),
                ),
                Text(
                  '$distanceInMeters  KM',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: Color(0xFF252B37)),
                ),
              ],
            ),
            Text(
              "Closes at : 10:00",
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: Color(0xFF252B37)),
            ),
          ],
        ),
      ),
    );
  }
}
