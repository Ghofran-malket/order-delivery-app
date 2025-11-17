import 'package:algenie/presentation/screens/genie_screens/home_screen.dart';
import 'package:algenie/presentation/screens/welcome_screen.dart';
import 'package:algenie/services/api_service.dart';
import 'package:flutter/material.dart';

class StartupWidget extends StatefulWidget {
  const StartupWidget({super.key});

  @override
  State<StartupWidget> createState() => _StartupWidgetState();
}

class _StartupWidgetState extends State<StartupWidget> {
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
        return GenieHome();
      }
    );
  }
}