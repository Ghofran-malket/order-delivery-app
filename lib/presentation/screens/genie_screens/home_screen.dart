import 'package:algenie/providers/auth_provider.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class GenieHome extends StatefulWidget {
  const GenieHome({super.key});

  @override
  _GenieHomeState createState() => _GenieHomeState();
}

class _GenieHomeState extends State<GenieHome> {
  
  bool loading = false;
  //bool online = false;
  bool show = true;
  bool data = true;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<AuthProvider>().checkOnlineStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    return WillPopScope(
        onWillPop: () async {
          SystemNavigator.pop();
          return true;
        },
        child: Scaffold(
            // key: scaffoldKey,
            // drawer: GenieDrawer(),
            body: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/influencer1.png'),
                        fit: BoxFit.cover)),
                child: SlidingUpPanel(
                    panel: loading
                        ? Center(
                            child: SpinKitThreeBounce(
                              color: Color(0xFFAB2929),
                              size: 30,
                            ),
                          )
                        : auth.isOnline!
                            ? Text('_goOfflineWidget(context)')
                            : _buildGoOnlineBar(),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromRGBO(0, 0, 0, 0.16),
                        offset: Offset(
                          0.0,
                          ScreenUtil().setWidth(-2.0),
                        ), //(x,y)
                        blurRadius: ScreenUtil().setWidth(6.0),
                      ),
                    ],
                    onPanelOpened: () {
                      setState(() {
                        show = true;
                      });
                    },
                    onPanelClosed: () {
                      setState(() {
                        show = false;
                      });
                    },
                    minHeight: ScreenUtil().setHeight(90), //146
                    maxHeight: ScreenUtil().setHeight(190), //246
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(ScreenUtil().setWidth(11)),
                        topLeft: Radius.circular(ScreenUtil().setWidth(11))),
                    collapsed: loading
                        ? Center(
                            child: SpinKitThreeBounce(
                              color: Color(0xFFAB2929),
                              size: 30,
                            ),
                          )
                        : auth.isOnline!
                            ? Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: ScreenUtil().setWidth(20)),
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: ScreenUtil().setHeight(1.5),
                                          bottom: ScreenUtil().setHeight(29.5)),
                                      child: SizedBox(
                                        height: ScreenUtil().setHeight(2.0),
                                        width: ScreenUtil().setWidth(43),
                                        child: DecoratedBox(
                                          decoration: BoxDecoration(
                                              color: Color(0xFFC4C4C4)),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          Icons.keyboard_arrow_up,
                                          color: Color(
                                              0xFFED1B24), //AnimatedTextKit FadeAnimatedText
                                          size: 40,
                                        ),
                                        Expanded(
                                          child: AnimatedTextKit(
                                            animatedTexts: [
                                              FadeAnimatedText(
                                                "looking for customers",
                                                textStyle: const TextStyle(
                                                  fontFamily: "Poppin-semibold",
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              FadeAnimatedText(
                                                "You are online",
                                                textStyle: const TextStyle(
                                                  fontFamily: "Poppin-semibold",
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                            repeatForever: true,
                                          ),
                                        ),
                                        Center(
                                            child: Image.asset(
                                          'assets/look-for.png',
                                          width: ScreenUtil().setWidth(48),
                                          height: ScreenUtil().setHeight(48),
                                        ))
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            : _buildGoOnlineBar(),
                    body: Stack(children: [
                      Positioned(
                        top: ScreenUtil().setHeight(50),
                        right: ScreenUtil().setWidth(17),
                        left: ScreenUtil().setWidth(17),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                // scaffoldKey.currentState!.openDrawer();
                              },
                              child: Container(
                                width: ScreenUtil().setWidth(33),
                                height: ScreenUtil().setWidth(33),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(
                                    ScreenUtil().setWidth(19),
                                  )),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          const Color.fromRGBO(0, 0, 0, 0.12),
                                      offset: Offset(
                                        0.0,
                                        ScreenUtil().setWidth(3.0),
                                      ), //(x,y)
                                      blurRadius: ScreenUtil().setWidth(6.0),
                                    ),
                                  ],
                                ),
                                padding:
                                    EdgeInsets.all(ScreenUtil().setWidth(5)),
                                child: Image.asset('assets/group55.png'),
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                //await myBox.put('name', 'Ghofran');
                              },
                              child: const Text(
                                'Enjoy your offers',
                                style: TextStyle(
                                  fontFamily: "Poppin-semibold",
                                  fontSize: 19,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Builder(
                              builder: (context) => (InkWell(
                                  onTap: () {},
                                  child: Image.asset('assets/alert.png',
                                      width: ScreenUtil().setWidth(30),
                                      height: ScreenUtil().setHeight(30)))),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        top: ScreenUtil().setHeight(100),
                        right: ScreenUtil().setWidth(5),
                        left: ScreenUtil().setWidth(5),
                        bottom: ScreenUtil().setHeight(80),
                        child: Scrollbar(
                            thickness: ScreenUtil().setWidth(5),
                            child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: ScreenUtil().setWidth(17)),
                                child: Container())),
                      )
                    ])))));
  }

  _buildGoOnlineBar() {
    return Container(
      height: ScreenUtil().setHeight(90),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(ScreenUtil().setWidth(11)),
            topLeft: Radius.circular(ScreenUtil().setWidth(11))),
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(0, 0, 0, 0.16),
            offset: Offset(
              0.0,
              ScreenUtil().setWidth(-2.0),
            ), //(x,y)
            blurRadius: ScreenUtil().setWidth(6.0),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  top: ScreenUtil().setHeight(1.5),
                  bottom: ScreenUtil().setHeight(29.5)),
              child: SizedBox(
                height: ScreenUtil().setHeight(2.0),
                width: ScreenUtil().setWidth(43),
                child: DecoratedBox(
                  decoration: BoxDecoration(color: Color(0xFFC4C4C4)),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "You Are Offline",
                  style: const TextStyle(
                    fontFamily: "Poppin-semibold",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                InkWell(
                  onTap: () async{
                    //genieRepository.updateGenieLocation();
                    await  context.read<AuthProvider>().goOnline();
                    
                  },
                  child: Container(
                    width: ScreenUtil().setWidth(126),
                    height: ScreenUtil().setHeight(33),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xFFAB2929),
                        width: ScreenUtil().setWidth(1.5),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(
                        ScreenUtil().setWidth(8),
                      )),
                      color: Colors.white,
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.power_settings_new,
                          color: Color(0xFFAB2929),
                          size: ScreenUtil().setWidth(18),
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(4),
                        ),
                        Text(
                          "Go Online",
                          style: TextStyle(
                            fontFamily: "Poppin-semibold",
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFFAB2929),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
