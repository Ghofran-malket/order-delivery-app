import 'dart:async';
import 'package:algenie/data/models/message_model.dart';
import 'package:algenie/data/models/order_model.dart';
import 'package:algenie/presentation/screens/genie_screens/home_screen.dart';
import 'package:algenie/presentation/screens/genie_screens/order_stages_pageview_screen.dart';
import 'package:algenie/presentation/widgets/order_stages_bar_widget.dart';
import 'package:algenie/presentation/widgets/order_timer_widget.dart';
import 'package:algenie/presentation/widgets/primary_button_widget.dart';
import 'package:algenie/services/api_service.dart';
import 'package:algenie/services/genie_services.dart';
import 'package:algenie/services/socket_services.dart';
import 'package:algenie/startup_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class OrderDetailsScreen extends StatelessWidget {
  final bool fromNotification;
  final Order order;
  OrderDetailsScreen({super.key, required this.order, this.fromNotification = false});

  final Stream chatMessagesStream = Stream.empty();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(0),
        children: <Widget>[
          OrderStagesBarWidget(order: order),

          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
                height: ScreenUtil().setHeight(2),
                width: MediaQuery.of(context).size.width / 2.01,
                color: Color(0xFf252B37)),
            Container(
                height: ScreenUtil().setHeight(2),
                width: MediaQuery.of(context).size.width / 2.01,
                color: Color.fromRGBO(0, 0, 0, 0.12))
          ]),

          SizedBox(height: ScreenUtil().setHeight(20)),

          //timer
          CountdownTimerWidget(),

          _storeCardWidget(),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(17)),
            child: Column(
              children: [
                //total estimate
                Container(
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
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Estimated Total",
                            style: TextStyle(
                              fontFamily: "Poppins-Medium",
                              fontSize: 15,
                              color: Color(0xFF252B37),
                            ),
                          ),
                          Text(
                            "100\$",
                            style: TextStyle(
                              fontFamily: "poppin-semibold",
                              fontSize: 16,
                              color: Color(0xFFED1B24),
                            ),
                          )
                        ],                      
                    ),                  
                ),
            
                SizedBox(
                  height: ScreenUtil().setHeight(30),
                ),
            
                //customer's note
                Row(
                    children: <Widget>[
                      Icon(Icons.note, color: Color(0xFFAB2929)),
                      SizedBox(
                        width: ScreenUtil().setWidth(4),
                      ),
                      Text(
                        "Customer Note",
                        style: TextStyle(
                          fontFamily: "Poppins-Medium",
                          fontSize: ScreenUtil().setSp(15),
                          color: Color(0xFF252B37),
                        ),
                      )
                    ],
                ),

                SizedBox(height: ScreenUtil().setHeight(10),),
                //note
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
                    padding:
                        EdgeInsets.only(top: 12, bottom: 12, left: 12, right: 22),
                    child: Text(
                      "when an unknown printer took a galley of type and scrambled it to make a type specimen book."
                      "It has survived not only five centuries,"
                      "but also the leap into electronic typesetting, remaining essentially unchanged",
                      style: TextStyle(
                        fontFamily: "Poppins-Regular",
                        fontSize: ScreenUtil().setSp(12),
                        color: Color(0xFF252B37),
                      ),
                    ),
                ),
                SizedBox(height: ScreenUtil().setHeight(30),),
            
                fromNotification ? Column(
                        children: [
                          PrimaryButtonWidget(
                            color: Color(0xFFAB2929),
                            title: 'Accept the order', 
                            isLoading: false, 
                            function: () async{
                              final navigator = Navigator.of(context);
                              await GenieService().acceptOrder(order.orderId);
                              Message message = Message(senderId: order.genieId, receiverId: order.customerId, text: 'Genie accept your order');
                              String chatId = order.genieId + order.orderId;
                              SocketService().sendMessage(chatId: chatId, message: message);
                              navigator.popUntil((route) => route.isFirst);
                              navigator.push(
                                  MaterialPageRoute<void>(
                                    builder: (context) => StartupWidget(),
                                  ),
                                );
                            }
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
                                  "Reject",
                                  style: TextStyle(
                                    fontFamily: "Poppin-semibold",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFFAB2929),
                                  ),
                                ),
                              ),
                            )
                          )
                        ],
                      ) : Container(),
              
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _storeCardWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17),
      child: ListView.builder(
          primary: false,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: order.stores.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(12)),
              child: Container(
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
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.store, color: Color(0xFFAB2929)),
                        Padding(
                          padding: EdgeInsets.only(
                              left: ScreenUtil().setWidth(12.7)),
                          child: Text(
                            order.stores[index].name,
                            style: TextStyle(
                              fontFamily: "Poppins-Medium",
                              fontSize: ScreenUtil().setSp(15),
                              color: Color(0xFF252B37),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.5),
                      child: Divider(
                        color: Color.fromRGBO(0, 0, 0, 0.12),
                        height: 0.5,
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 2 * MediaQuery.of(context).size.width / 3 -
                                  ScreenUtil().setWidth(50),
                              child: ListView.builder(
                                  primary: false,
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount:
                                      order.stores[index].items.length,
                                  itemBuilder: (BuildContext context, int i) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          order.stores[index].items[i]
                                              .title,
                                          style: TextStyle(
                                            fontFamily: "Poppins-Medium",
                                            fontSize: 12,
                                            color: Color(0xFF252B37),
                                          ),
                                        ),
                                        Spacer(),
                                        Text(
                                          order.stores[index].items[i]
                                              .quantity,
                                          style: TextStyle(
                                            fontFamily: "Poppins-Medium",
                                            fontSize: 12,
                                            color: Color(0xFF252B37),
                                          ),
                                        )
                                      ],
                                    );
                                  }),
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width / 3 -
                                    ScreenUtil().setWidth(50),
                                alignment: Alignment.centerRight,
                                child: InkWell(
                                  onTap: () async{
                                    final navigator = Navigator.of(context);
                                    if(order.stores[index].storeStatus != "done"){
                                      await AuthService().updateGenieProgress(orderId: order.orderId, 
                                            step: 'goToStore', storeIndex: index);
                                      navigator.push(
                                        MaterialPageRoute(
                                          builder: (context) => OrderStagesPageviewScreen(
                                            store: order.stores[index],
                                            order: order,
                                            page: 0,
                                            storeIndex: index
                                          ),
                                        )
                                      );
                                    }
                                  },
                                  child: Container(
                                    width: ScreenUtil().setHeight(60),
                                    height: ScreenUtil().setHeight(60),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFFFFFFF),
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0xFF707070),
                                          offset: Offset(
                                            0.0,
                                            0.0,
                                          ), //(x,y)
                                          blurRadius:
                                              ScreenUtil().setWidth(6.0),
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                        child: Stack(
                                      children: <Widget>[
                                        Center(
                                          child: Container(
                                            width: 41.4,
                                            height: 41.4,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.elliptical(
                                                      20.72, 20.72)),
                                              color: const Color(0xfff7f7f7),
                                              border: Border.all(
                                                  width: 3.0,
                                                  color: Color(
                                                      order.stores[index].storeStatus ==
                                                              "done"
                                                          ? 0xff203b4c
                                                          : 0xffed1b24)),
                                            ),
                                          ),
                                        ),
                                        Center(
                                            child:
                                                order.stores[index].storeStatus ==
                                                        "done"
                                                    ? SvgPicture.string(
                                                        '<svg viewBox="22.0 25.5 19.5 13.5" ><path transform="translate(-7919.91, 2027.16)" d="M 7941.8623046875 -1994.317626953125 L 7947.931640625 -1988.248413085938 L 7961.388671875 -2001.70556640625" fill="none" stroke="#329800" stroke-width="4" stroke-linecap="round" stroke-linejoin="round" /></svg>',
                                                        allowDrawingOutsideViewBox:
                                                            true,
                                                      )
                                                    : SvgPicture.string(
                                                        '<svg viewBox="0.0 0.0 27.4 18.3" ><path transform="translate(-2123.32, -1507.76)" d="M 2140.649658203125 1526.021362304688 C 2140.1767578125 1526.021362304688 2139.70556640625 1525.8271484375 2139.365966796875 1525.446533203125 C 2138.73388671875 1524.738037109375 2138.7958984375 1523.651123046875 2139.50439453125 1523.01904296875 L 2146.40673828125 1516.861328125 L 2139.566162109375 1510.763916015625 C 2138.857421875 1510.132080078125 2138.794921875 1509.045288085938 2139.4267578125 1508.33642578125 C 2140.058349609375 1507.627685546875 2141.145263671875 1507.565063476563 2141.854248046875 1508.197021484375 L 2150.1337890625 1515.5771484375 C 2150.499755859375 1515.9033203125 2150.709228515625 1516.3701171875 2150.709228515625 1516.8603515625 C 2150.70947265625 1517.350341796875 2150.500244140625 1517.8173828125 2150.134521484375 1518.1435546875 L 2141.79345703125 1525.5849609375 C 2141.4658203125 1525.87744140625 2141.056640625 1526.021362304688 2140.649658203125 1526.021362304688 Z" fill="#203b4c" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /><path transform="translate(-2068.49, -1507.76)" d="M 2077.81884765625 1526.021362304688 C 2077.34619140625 1526.021362304688 2076.875244140625 1525.8271484375 2076.535400390625 1525.446533203125 C 2075.9033203125 1524.738037109375 2075.96533203125 1523.651123046875 2076.673828125 1523.01904296875 L 2083.576171875 1516.861328125 L 2076.73583984375 1510.763916015625 C 2076.02685546875 1510.132080078125 2075.96435546875 1509.045288085938 2076.59619140625 1508.33642578125 C 2077.22802734375 1507.627685546875 2078.31494140625 1507.565063476563 2079.0234375 1508.197021484375 L 2087.30322265625 1515.5771484375 C 2087.66943359375 1515.9033203125 2087.878662109375 1516.3701171875 2087.87890625 1516.8603515625 C 2087.87890625 1517.350341796875 2087.669921875 1517.8173828125 2087.30419921875 1518.1435546875 L 2078.962890625 1525.5849609375 C 2078.63525390625 1525.87744140625 2078.226318359375 1526.021362304688 2077.81884765625 1526.021362304688 Z" fill="#203b4c" fill-opacity="0.55" stroke="none" stroke-width="1" stroke-opacity="0.55" stroke-miterlimit="10" stroke-linecap="butt" /><path transform="translate(-2016.33, -1507.76)" d="M 2018.045654296875 1526.021362304688 C 2017.57275390625 1526.021362304688 2017.101928710938 1525.8271484375 2016.76220703125 1525.446533203125 C 2016.130126953125 1524.738037109375 2016.192016601563 1523.651123046875 2016.900512695313 1523.01904296875 L 2023.802856445313 1516.861328125 L 2016.962280273438 1510.763916015625 C 2016.25341796875 1510.132080078125 2016.19091796875 1509.045288085938 2016.82275390625 1508.33642578125 C 2017.45458984375 1507.627685546875 2018.541381835938 1507.565063476563 2019.250244140625 1508.197021484375 L 2027.530029296875 1515.5771484375 C 2027.895874023438 1515.9033203125 2028.105224609375 1516.3701171875 2028.105346679688 1516.8603515625 C 2028.10546875 1517.350341796875 2027.896362304688 1517.8173828125 2027.530639648438 1518.1435546875 L 2019.189575195313 1525.5849609375 C 2018.86181640625 1525.87744140625 2018.452880859375 1526.021362304688 2018.045654296875 1526.021362304688 Z" fill="#203b4c" fill-opacity="0.3" stroke="none" stroke-width="1" stroke-opacity="0.3" stroke-miterlimit="10" stroke-linecap="butt" /></svg>',
                                                        allowDrawingOutsideViewBox:
                                                            true,
                                                      )),
                                      ],
                                    )),
                                  ),
                                ))
                          ],
                        )),  
                  ],
                ),
              ),
            );
          }),
    );
  }
}
