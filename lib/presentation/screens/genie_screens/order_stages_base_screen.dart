import 'package:algenie/core/styles/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:algenie/presentation/widgets/slider_button_widget.dart';
import 'package:algenie/data/models/order_model.dart';
import 'package:algenie/data/models/order_store_model.dart';

class OrderStagesBaseScreen extends StatelessWidget {
  final Order order;
  final OrderStore store;
  final String title;
  final String buttonLabel;
  final VoidCallback onAction;
  bool isMap;

  OrderStagesBaseScreen({required this.store, required this.order, required this.title, required this.buttonLabel,
  required this.onAction, this.isMap= true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(17),),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            
            //title
            Center(
              child: Text(
                "$title ${store.name}",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),

            SizedBox(height: ScreenUtil().setHeight(17),),
        
            isMap ? Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF252B37),
                    borderRadius: BorderRadius.all(Radius.circular(
                      ScreenUtil().setWidth(8),
                    )),
                    boxShadow: [
                       AppStyle.softShowStyle
                    ],
                  ),
                  height: ScreenUtil().setHeight(200),
                  width: ScreenUtil().setWidth(340),
                  padding: EdgeInsets.all(20),
                  child: Center(child:Text(store.location == null ? "Google map here shows store's location but the location is null" : "Google map here shows store's location", style: Theme.of(context).textTheme.bodyMedium!.copyWith(color:Colors.white),))
            ) : SizedBox(height: ScreenUtil().setHeight(30),),
        
            SizedBox(height: ScreenUtil().setHeight(17),),
            
            //items
            Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(
                      ScreenUtil().setWidth(8),
                    )),
                    boxShadow: [
                       AppStyle.softShowStyle
                    ],
                  ),
                padding: EdgeInsets.all(20),
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    primary: false,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: store.items.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            store.items[index].title,
                            style: Theme.of(context).textTheme.labelSmall!.copyWith(color: Color(0xFF252B37),),
                          ),
                          Text(
                            store.items[index].quantity,
                            style: Theme.of(context).textTheme.labelSmall!.copyWith(color: Color(0xFF252B37),),
                          ),
                        ],
                      );
                    }
                  ),
            ),
        
            Spacer(),
        
            //button
            SliderButtonWidget(
              label: buttonLabel,
              onAction: onAction
            ),
        
            SizedBox(height: ScreenUtil().setHeight(30)),
          ],
        ),
      ),
    );
  }
}
