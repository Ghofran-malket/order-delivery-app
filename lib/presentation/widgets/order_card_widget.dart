import 'package:algenie/data/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:intl/intl.dart' as intl;

class OrderCardWidget extends StatelessWidget {
  final Order order;
  const OrderCardWidget({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(20)),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(
            ScreenUtil().setWidth(8),
          )),
          boxShadow: [
            BoxShadow(
              color: const Color.fromRGBO(0, 0, 0, 0.12),
              offset: Offset(
                0.0,
                ScreenUtil().setWidth(3.0),
              ), //(x,y)
              blurRadius: ScreenUtil().setWidth(6.0),
            ),
          ],
        ),
        padding: const EdgeInsets.all(17),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: ScreenUtil().setWidth(12.7)),
                  child: Text(
                    //"stores[index].name}",
                    "Customer: order.customerId",
                    style: const TextStyle(
                      fontFamily: "Poppin-semibold",
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 15.5),
              child: Divider(
                color: Color.fromRGBO(0, 0, 0, 0.12),
                height: 0.5,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  intl.DateFormat("EEEE, yyyy-MM-dd").format(order.createdAt!),
                  style: const TextStyle(
                    fontFamily: "Poppin-semibold",
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                const Spacer(),
                Text(
                  "At",
                  style: const TextStyle(
                    fontFamily: "Poppin-semibold",
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width:10),
                Text(
                  //"${stores[index].items![i].quantity}",
                  intl.DateFormat("h:mm a").format(order.createdAt!),
                  style: const TextStyle(
                    fontFamily: "Poppin-semibold",
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 3 -
                      ScreenUtil().setWidth(50),
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: ScreenUtil().setHeight(40),
                    height: ScreenUtil().setHeight(40),
                    decoration: BoxDecoration(
                      color: Color(0xFFAB2929), //HexColor("#FFFFFF"),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF707070),
                          offset: const Offset(
                            0.0,
                            0.0,
                          ), //(x,y)
                          blurRadius: ScreenUtil().setWidth(6.0),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        //'${order.chargeService}\$',
                        "52",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'more details ',
                style: TextStyle(
                  fontFamily: "Poppin-semibold",
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFAB2929),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
