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

    return WillPopScope(
      onWillPop: () async {
        if('cameFrom' == 'SelectLanguage'){
          Navigator.pop(context);
          return true;
        }else{
          return false;
        }
          
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background.jpg'),
              fit: BoxFit.cover
            )
          ),
          child: ListView(
            children: <Widget>[
              SizedBox(height: 75),
              
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/home');
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
                          'assets/icon1.jpg',
                          height:140,
                          width: 248,
                        ),
                        SizedBox(height: 50),
                        Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            "Continue as Customer",
                            style: TextStyle(
                              fontFamily: "Poppin-semibold",
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
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
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed doeiusmod tempor incididunt ut labore et dolore magna aliquaUt enim ad minim veniam",
                            style: TextStyle(
                              fontFamily: "Poppin-semibold",
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
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
                  Navigator.pushNamed(context, '/login',
                      arguments: {'userType': 'Genie', 'cameFrom' : ''});
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
                          'assets/icon2.jpg',
                          height:140,
                          width: 176,
                        ),
                        SizedBox(height: 50),
                        Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                                "Continue as Genie",
                                style: TextStyle(
                                  fontFamily: "Poppin-semibold",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
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
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed doeiusmod tempor incididunt ut labore et dolore magna aliquaUt enim ad minim veniam",
                            style: TextStyle(
                              fontFamily: "Poppin-semibold",
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
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
      ),
    );
  }
}
