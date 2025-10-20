import 'package:algenie/data/models/order_model.dart';
import 'package:algenie/data/models/store_model.dart';
import 'package:algenie/presentation/screens/genie_screens/order_stages_base_screen.dart';
import 'package:algenie/presentation/widgets/order_stages_bar_widget.dart';
import 'package:algenie/presentation/widgets/order_timer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderStagesPageviewScreen extends StatefulWidget {
  final Order order;
  final Store store;
  OrderStagesPageviewScreen({super.key, required this.order, required this.store});

  @override
  State<OrderStagesPageviewScreen> createState() => _OrderStagesPageviewScreenState();
}

class _OrderStagesPageviewScreenState extends State<OrderStagesPageviewScreen> {
  final PageController _pageController = PageController();

  void _goToNextPage() {
    if (_pageController.page != null && _pageController.page! < 3) {
      print("page number ${_pageController.page}");
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } if (_pageController.page == 2.0){
      _pageController.animateToPage(
        _pageController.initialPage, 
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          //appBar
          OrderStagesBarWidget(order: widget.order),

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

          SizedBox(height: ScreenUtil().setHeight(30)),

          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(), // disable swipe if needed
              children: [ 
                OrderStagesBaseScreen(
                  title: 'Go to',
                  buttonLabel: 'Go',
                  order: widget.order,
                  store: widget.store,
                  onAction: _goToNextPage,
                ),
                OrderStagesBaseScreen(
                  title: 'Arrive to',
                  buttonLabel: 'Arrived',
                  order: widget.order,
                  store: widget.store,
                  onAction: _goToNextPage,
                ),
                OrderStagesBaseScreen(
                  title: 'Pick up from',
                  buttonLabel: 'Done',
                  order: widget.order,
                  store: widget.store,
                  onAction: _goToNextPage,
                  isMap: false
                ),
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}
