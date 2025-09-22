import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sizeAware = MediaQuery.of(context).size;

    //if Authenticated then 
    //  if genie then go to genie home
    // if genie is busy with order go to order details page
    //  if customer then go to customer home
    //if not authenticated go to first route

    return Scaffold(
        body:  Center(
          child: Container(
                width: 200,
                height: 150,
                color: Colors.grey[300],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.image, size: 40, color: Colors.grey[700]),
                    SizedBox(height: 8),
                    Text(
                      "Image will appear here",
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ],
                ),    
            ),
        ),
    );
  }
}
