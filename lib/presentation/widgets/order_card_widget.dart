import 'package:algenie/data/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart' as intl;

class OrderCardWidget extends StatelessWidget {
  final Order order;
  const OrderCardWidget({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Order #${order.orderId.substring(0, 4)}",
              style: Theme.of(context).textTheme.titleSmall,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 15.5),
              child: Divider(
                color: Color.fromRGBO(0, 0, 0, 0.12),
                height: 0.5,
              ),
            ),
            Text(
              "Status: ${order.orderStatus.toUpperCase()}",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            SizedBox(height: 5,),
            Text(
              "Accepted ${DateTime.now().difference(order.updatedAt!).inMinutes} min ago",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            SizedBox(height: 5,),
            Text(
              "From: ${order.stores.map((store) => store.name).join(', ')}",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            SizedBox(height: 5,),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text(
            //       intl.DateFormat("EEEE, yyyy-MM-dd").format(order.createdAt!),
            //       style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 12),
            //     ),
            //     const Spacer(),
            //     Text(
            //       "At",
            //       style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 12),
            //     ),
            //     const SizedBox(width:10),
            //     Text(
            //       intl.DateFormat("h:mm a").format(order.createdAt!),
            //       style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 12),
            //     ),
            //     Container(
            //       width: MediaQuery.of(context).size.width / 3 -
            //           ScreenUtil().setWidth(50),
            //       alignment: Alignment.centerRight,
            //       child: Container(
            //         width: ScreenUtil().setHeight(40),
            //         height: ScreenUtil().setHeight(40),
            //         decoration: BoxDecoration(
            //           color: Color(0xFFAB2929), //HexColor("#FFFFFF"),
            //           shape: BoxShape.circle,
            //           boxShadow: [
            //             BoxShadow(
            //               color: Color(0xFF707070),
            //               offset: const Offset(
            //                 0.0,
            //                 0.0,
            //               ), //(x,y)
            //               blurRadius: ScreenUtil().setWidth(6.0),
            //             ),
            //           ],
            //         ),
            //         child: Center(
            //           child: Text(
            //             //'${order.chargeService}\$',
            //             "52",
            //             style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 12, color: Colors.white),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'more details ',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: 12, color: Color(0xFFAB2929)),
              ),
            ),
          ],
    );
  }
}
