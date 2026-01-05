import 'package:algenie/core/styles/app_style.dart';
import 'package:algenie/data/models/order_store_model.dart';
import 'package:algenie/presentation/screens/customer_screens/offre_screen.dart';
import 'package:algenie/presentation/widgets/customer_home_bar_widget.dart';
import 'package:algenie/presentation/widgets/store_card_widget.dart';
import 'package:algenie/services/customer_services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/services.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({super.key});

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _current = 0;
  List<OrderStore> nearbyStores = [
    OrderStore(
        id: '1',
        title: 'Store1',
        items: [],
        location: Position(
          latitude: 33.55,
          longitude: 33.555,
          accuracy: 0.0,
          timestamp: DateTime.now(),
          altitude: 0.0,
          altitudeAccuracy: 0.0,
          heading: 0.0,
          headingAccuracy: 0.0,
          speed: 0.0,
          speedAccuracy: 0.0,
        ),
        name: 'Aushan',
        storeStatus: 'sdsd'),
    OrderStore(
        id: '1',
        title: 'Store1',
        items: [],
        location: Position(
          latitude: 33.55,
          longitude: 33.555,
          accuracy: 0.0,
          timestamp: DateTime.now(),
          altitude: 0.0,
          altitudeAccuracy: 0.0,
          heading: 0.0,
          headingAccuracy: 0.0,
          speed: 0.0,
          speedAccuracy: 0.0,
        ),
        name: 'Aushan',
        storeStatus: 'sdsd')
  ];

  bool isLoading = false;
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) async {
        SystemNavigator.pop();
      },
      child: Scaffold(
        key: _scaffoldKey,
        body: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(17)),
            child: ListView(
              controller: scrollController,
              children: [
                SizedBox(
                  height: ScreenUtil().setHeight(25),
                ),
                //appBar
                CustomerHomeBar(scaffoldKey: _scaffoldKey, currentAddress: 'currentAddress'),

                SizedBox(height: ScreenUtil().setHeight(20)),

                Text('What would you like to order ?',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      shadows: [AppStyle.softShowStyle],
                    )),
                SizedBox(height: ScreenUtil().setHeight(10)),

                Text('New offres',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        shadows: [AppStyle.softShowStyle],
                        color: Colors.black54)),
                SizedBox(height: ScreenUtil().setHeight(5)),

                SizedBox(
                  height: ScreenUtil().setHeight(120),
                  child: FutureBuilder(
                    future: CustomerService().getOffersList(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return SpinKitFadingCircle(
                          color: Color(0xFFAB2929),
                          size: 30,
                        );
                      }

                      final offersList = snapshot.data!;
                      return ListView.builder(
                          padding: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: offersList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              splashColor: Color(0xFF252B37).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(7),)),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (context) => OfferDetailsScreen(offer: offersList[index], scaffoldKey: _scaffoldKey),
                                  ),
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.all(10),
                                padding: EdgeInsets.all(5),
                                width: ScreenUtil().setHeight(100),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(ScreenUtil().setWidth(7))),
                                  image: DecorationImage(
                                    image: NetworkImage(offersList[index].image),
                                    fit: BoxFit.fill,
                                    colorFilter: ColorFilter.mode(
                                      Color(0xFF252B37).withValues(alpha: 0.2),
                                      BlendMode.darken,
                                    ),
                                  ),
                                  boxShadow: [AppStyle.softShowStyle],
                                ),
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                    offersList[index].title,
                                    overflow: TextOverflow.clip,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(color: Colors.white,),
                                  ),
                                ),
                              ),
                            );
                          });
                    }
                  ),
                ),
                SizedBox(height: ScreenUtil().setHeight(30)),

                Text('Pick Your Items quickly',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        shadows: [AppStyle.softShowStyle],
                        color: Colors.black54)),
                SizedBox(height: ScreenUtil().setHeight(15)),

                FutureBuilder(
                    future: CustomerService().getItemsList(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return SpinKitFadingCircle(
                          color: Color(0xFFAB2929),
                          size: 30,
                        );
                      }

                      final itemsList = snapshot.data!;
                      return Column(
                        children: [
                          CarouselSlider(
                            items: itemsList
                                .map(
                                  (item) => InkWell(
                                    onTap: () {},
                                    splashColor: Color(0xFF252B37).withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(7),)),
                                    child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: ScreenUtil().setWidth(10)),
                                        margin:
                                            EdgeInsets.all(ScreenUtil().setHeight(10)),
                                        height: ScreenUtil().setHeight(130),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(Radius.circular(
                                            ScreenUtil().setWidth(7),
                                          )),
                                          image: DecorationImage(
                                            image: NetworkImage(item.image),
                                            fit: BoxFit.contain,
                                          ),
                                          boxShadow: [AppStyle.softShowStyle],
                                        )),
                                  ),
                                )
                                .toList(),
                            options: CarouselOptions(
                              autoPlay: true,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _current = index;
                                });
                              },
                              height: ScreenUtil().setHeight(140),
                            ),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: itemsList.map((item) {
                              int index = itemsList.indexOf(item);
                              return Container(
                                width: 8.0,
                                height: 8.0,
                                margin:
                                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [AppStyle.softShowStyle],
                                  color: _current == index
                                      ? Color(0xFFAB2929)
                                      : Color(0xFF252B37).withValues(alpha: 0.3),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      );
                    }
                ),

                SizedBox(height: ScreenUtil().setHeight(20)),

                Text('What’s Near You?',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        shadows: [AppStyle.softShowStyle],
                        color: Colors.black54)),
                SizedBox(height: ScreenUtil().setHeight(15)),

                nearbyStores.isEmpty
                    ? Center(
                        child: Text('No Data...'),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: nearbyStores.length,
                        padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(0)),
                        itemBuilder: (context, index) {
                          return StoreCardWidget(
                              store: nearbyStores[index],
                              initialPosition: nearbyStores[index].location!);
                        },
                      ),
                isLoading
                    ? SpinKitFadingCircle(
                        color: Color(0xFFAB2929),
                        size: 30,
                      )
                    : Container(),
              ],
            )),
      ),
    );
  }
}

