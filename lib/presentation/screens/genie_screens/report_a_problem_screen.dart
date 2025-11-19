import 'package:algenie/data/models/report_model.dart';
import 'package:algenie/services/api_service.dart';
import 'package:algenie/services/order_api_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:algenie/presentation/widgets/slider_button_widget.dart';
import 'package:algenie/presentation/widgets/textfield_widget.dart';
import 'package:algenie/data/models/order_model.dart';
import 'package:algenie/presentation/screens/genie_screens/home_screen.dart';

class ReportAProblemScreen extends StatefulWidget {
  final Order order;
  const ReportAProblemScreen({
    super.key,
    required this.order,
  });
  @override
  _ReportAProblemScreenState createState() => _ReportAProblemScreenState();
}

class _ReportAProblemScreenState extends State<ReportAProblemScreen> {
  TextEditingController descriptionController = TextEditingController();
  List<String> reports = [
    "Customer is not responding",
    "Customer did not pay the fee",
    "Report abuse",
    "Something else"
  ];
  List<String> selectedReports = [];

  void toggleReport(String report) {
    setState(() {
      if (selectedReports.contains(report)) {
        selectedReports.remove(report); // Uncheck
      } else {
        selectedReports.add(report); // Check
      }
    });
  }

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 17, vertical: 30),
        child: FutureBuilder(
            future: AuthService().getUserInfo(widget.order.customerId),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return CircularProgressIndicator();

              var customer = snapshot.data!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //appBar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.keyboard_arrow_left,
                              color: Color(0xFF252B37),
                              size: ScreenUtil().setSp(20))),
                      Text(
                        customer.name,
                        textAlign: TextAlign.center,
                      ),
                      Container(
                          height: ScreenUtil().setHeight(28),
                          width: ScreenUtil().setHeight(28),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(customer.image!)))),
                    ],
                  ),
                  SizedBox(height: 40),

                  //reports
                  ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: reports.length,
                      padding: EdgeInsets.all(0),
                      itemBuilder: (BuildContext context, int index) {
                        final isChecked =
                            selectedReports.contains(reports[index]);
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: ScreenUtil().setHeight(13)),
                          child: InkWell(
                            onTap: () async {
                              toggleReport(reports[index]);
                            },
                            child: Row(
                              children: <Widget>[
                                Container(
                                  height: ScreenUtil().setHeight(20),
                                  width: ScreenUtil().setHeight(20),
                                  decoration: BoxDecoration(
                                      borderRadius: const 
                                          BorderRadius.all(Radius.circular(3.0)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color.fromRGBO(0, 0, 0, 0.16),
                                          offset: Offset(
                                            0.0,
                                            ScreenUtil().setWidth(1.0),
                                          ), //(x,y)
                                          blurRadius: ScreenUtil().setWidth(3.0),
                                        ),
                                      ],
                                      color: Colors.white),
                                  child: isChecked
                                      ? Icon(
                                          Icons.check,
                                          color: Color(0xFFAB2929),
                                          size: ScreenUtil().setHeight(20),
                                        )
                                      : Container(),
                                ),
                                SizedBox(
                                  width: ScreenUtil().setWidth(12),
                                ),
                                Text(
                                  reports[index],
                                  style: TextStyle(
                                    fontFamily: "Poppins-Medium",
                                    fontSize: ScreenUtil().setSp(15),
                                    color: Color(0xFF2F343F),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }),

                  SizedBox(
                    height: 50,
                  ),

                  Text(
                    "Please, Describe the Problem",
                    style: TextStyle(
                      fontFamily: "Poppins-Medium",
                      fontSize: ScreenUtil().setSp(15),
                      color: Color(0xFF252B37),
                    ),
                  ),

                  SizedBox(height: 10),

                  TextFieldWidget(
                    hint: 'Please, Describe your problem here . . .',
                    controller: descriptionController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 5,
                    height: 150,
                  ),

                  SizedBox(height: 100),

                  SliderButtonWidget(
                    label: "Submit and continue",
                    onAction: () async {
                      // call api to post a report to the backend (selectedReports)
                      widget.order.orderId;
                      widget.order.customerId;
                      widget.order.genieId;
                      selectedReports;
                      descriptionController;
                      await OrderApiService().report(Report(orderId: widget.order.orderId, 
                      customerId: widget.order.customerId, genieId: widget.order.genieId, reports: selectedReports, 
                      description: descriptionController.text));
                      await OrderApiService().updateOrderStatus(widget.order.orderId, 'unpublished');
                      Navigator.of(context).popUntil((route) => route.isFirst);
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => GenieHome()),
                        );
                    },
                  ),

                  SizedBox(height: 20),

                  Center(
                    child: InkWell(
                      onTap: () async {
                        await OrderApiService().updateOrderStatus(widget.order.orderId, "canceled");
                        Navigator.of(context).pop((route) => route.isFirst);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => GenieHome()),
                        );
                      },
                      child: Text(
                        "Cancel Order",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: "Poppin-semibold",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFAB2929),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
