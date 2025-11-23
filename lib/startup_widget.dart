import 'package:algenie/data/models/order_model.dart';
import 'package:algenie/presentation/screens/genie_screens/customer_location_screen.dart';
import 'package:algenie/presentation/screens/genie_screens/deliver_to_customer_screen.dart';
import 'package:algenie/presentation/screens/genie_screens/home_screen.dart';
import 'package:algenie/presentation/screens/genie_screens/order_details-screen.dart';
import 'package:algenie/presentation/screens/genie_screens/order_stages_pageview_screen.dart';
import 'package:algenie/presentation/screens/genie_screens/receipt_photo_screen.dart';
import 'package:algenie/presentation/screens/rate_screen.dart';
import 'package:algenie/presentation/screens/welcome_screen.dart';
import 'package:algenie/services/api_service.dart';
import 'package:flutter/material.dart';

class StartupWidget extends StatelessWidget {
  const StartupWidget({super.key});

  Widget orderStep(Order order){
    final storeIndex = order.genieProgress['storeIndex'];
    switch (order.genieProgress['step']) {
      case "genieHome":
        return GenieHome(order: order);
      case "orderDetails":
        return OrderDetailsScreen(order: order);
      case "goToStore":
        return OrderStagesPageviewScreen(order: order, store: order.stores[storeIndex], page: 0, storeIndex: storeIndex,);
      case "arriveToStore":
        return OrderStagesPageviewScreen(order: order, store: order.stores[storeIndex], page: 1, storeIndex: storeIndex,);
      case "pickUpDone":
        return OrderStagesPageviewScreen(order: order, store: order.stores[storeIndex], page: 2,storeIndex: storeIndex,);
      case "receiptPhoto":
        return ReceiptPhotoScreen(order: order,store: order.stores[storeIndex]);
      case "customerLocation":
        return CustomerLocationScreen(order: order);
      case "deliverToCustomer":
        return DeliverToCustomerScreen(order: order);
      case "rate":
        return RateScreen(order: order);
      default:
        return GenieHome();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService().loadUserStatus(),
      builder: (context, snapshot){
        if(!snapshot.hasData) return WelcomeScreen();
        
        //data map {role, hasTakenOrder}
        final data = snapshot.data;
        final role = data['role'];
        //if customer then go to customer section
        if(role == "customer") return Scaffold(body: Center(child:Text("Customer")));
        //if genie go to genie section
        final Order order = data['order'];
        final active = data['active'];
        return  active ? orderStep(order) : GenieHome();
      }
    );
  }
}
