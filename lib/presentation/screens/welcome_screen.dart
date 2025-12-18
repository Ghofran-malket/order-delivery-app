import 'package:algenie/presentation/screens/auth/login_screen.dart';
import 'package:algenie/presentation/screens/customer_screens/customer-home.dart';
import 'package:algenie/presentation/widgets/container_background_image_widget.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  @override
  Widget build(BuildContext context) {

    final sizeAware = MediaQuery.of(context).size;

    return Scaffold(
        body: ContainerBackgroundImage(
          child: ListView(
            children: <Widget>[
              SizedBox(height: 75),
              
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) => const CustomerHomeScreen(),
                    ),
                  );
                },
                child: Center(
                  child: Container(
                    width: sizeAware.width * 0.9,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 0.31),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.12),
                          offset: Offset(
                            0.0,
                            1,
                          ), //(x,y)
                          blurRadius: 6,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 20),
                        Image.asset(
                          'assets/customer.png',
                          height:140,
                          width: 248,
                        ),
                        SizedBox(height: 50),
                        Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            "Continue as Customer",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 19,
                            right: 16,
                            left: 13,
                            bottom: 19,
                          ),
                          child: Text(
                            "Order what you need and follow your delivery live.",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 30),
              
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
                child: Center(
                  child: Container(
                    width: sizeAware.width * 0.9,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 0.31),
                      boxShadow: [
                        BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.12),
                        offset: Offset(
                          0.0,
                          1,
                        ), //(x,y)
                        blurRadius: 6,
                      ),
                      ],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 20),
                        Image.asset(
                          'assets/genie.png',
                          height:140,
                          width: 176,
                          
                        ),
                        SizedBox(height: 50),
                        Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                                "Continue as Genie",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 19,
                            right: 16,
                            left: 13,
                            bottom: 19,
                          ),
                          child: Text(
                            "Help customers by shopping and delivering their orders.",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
}
