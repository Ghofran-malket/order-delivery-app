import 'package:algenie/core/constants/app_constants.dart';
import 'package:algenie/data/models/message_model.dart';
import 'package:algenie/presentation/screens/genie_screens/customer_location_screen.dart';
import 'package:algenie/services/api_service.dart';
import 'package:algenie/services/socket_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';
import 'package:algenie/data/models/order_model.dart';
import 'package:algenie/data/models/store_model.dart';
import 'package:algenie/presentation/screens/genie_screens/order_details-screen.dart';
import 'package:algenie/presentation/widgets/order_stages_bar_widget.dart';
import 'package:algenie/presentation/widgets/primary_button_widget.dart';
import 'package:algenie/presentation/widgets/slider_button_widget.dart';
import 'package:algenie/presentation/widgets/textfield_widget.dart';
import 'package:algenie/services/order_api_services.dart';

class ReceiptPhotoScreen extends StatefulWidget {
  final Order order;
  final Store store;

  const ReceiptPhotoScreen({super.key, required this.order, required this.store});

  @override
  _ReceiptPhotoScreenScreenState createState() => _ReceiptPhotoScreenScreenState();
}

class _ReceiptPhotoScreenScreenState extends State<ReceiptPhotoScreen> {
  TextEditingController receiptController = TextEditingController();
  bool emptyReceipt = false;
  bool noPhoto = false;
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: await _showPickerDialog(), // either camera or gallery
      imageQuality: 80,
    );

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        noPhoto = false;
      });
    }
  }

  Future<ImageSource> _showPickerDialog() async {
    return await showModalBottomSheet<ImageSource>(
          context: context,
          builder: (context) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text(
                  'Take a photo',
                  style: Theme.of(context).textTheme.bodyMedium
                ),
                onTap: () => Navigator.pop(context, ImageSource.camera),
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text(
                  'Choose from gallery',
                  style: Theme.of(context).textTheme.bodyMedium
                ),
                onTap: () => Navigator.pop(context, ImageSource.gallery),
              ),
            ],
          ),
        ) ??
        ImageSource.gallery; // default fallback
  }

  int? hasPendingStores(Order order) {
    //return order.stores.any((store) => store.storeStatus == 'pending');
  
    return  order.stores.indexWhere(
      (store) => store.storeStatus == 'pending',
    );
  }

  @override
  void dispose() {
    receiptController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result)  async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          padding: EdgeInsets.all(0),
          children: <Widget>[
            //appBar
            OrderStagesBarWidget(
              order: widget.order,
            ),

            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Container(
                  height: ScreenUtil().setHeight(2),
                  width: MediaQuery.of(context).size.width / 2.01,
                  color: Color.fromRGBO(0, 0, 0, 0.12)),
              Container(
                  height: ScreenUtil().setHeight(2),
                  width: MediaQuery.of(context).size.width / 2.01,
                  color: Color(0xFF252B37))
            ]),

            SizedBox(height: ScreenUtil().setHeight(20)),

            Center(
              child: Text(
                "Receipt from ${widget.store.name}",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(17),
                  vertical: ScreenUtil().setHeight(30)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 3,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.all(Radius.circular(
                        ScreenUtil().setWidth(8),
                      )),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.12),
                          offset: Offset(
                            0.0,
                            ScreenUtil().setWidth(3.0),
                          ),
                          blurRadius: ScreenUtil().setWidth(6.0),
                        ),
                      ],
                      image: _imageFile != null
                          ? DecorationImage(
                              fit: BoxFit.fill, image: FileImage(_imageFile!))
                          : null,
                    ),
                    padding: EdgeInsets.all(0),
                    child: _imageFile == null
                        ? InkWell(
                            onTap: _pickImage,
                            child: Center(
                                child: Icon(Icons.camera_alt,
                                    color: Colors.white,
                                    size: ScreenUtil().setSp(50))))
                        : Container(),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(20),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _imageFile = null;
                        noPhoto = true;
                      });
                      Future.delayed(
                        Duration(seconds: 1),
                        () => _pickImage(),
                      );
                    },
                    child: Center(
                        child: Text(
                      "Retake reciept photo",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Color(0xFFAB2929), fontWeight: FontWeight.bold)
                    )),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(10)),
                  noPhoto ? emptyField() : Container(),
                  SizedBox(height: ScreenUtil().setHeight(10)),
                  TextFieldWidget(
                    hint: "Receipt value",
                    controller: receiptController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: () {
                      if(receiptController.text.isEmpty){
                        setState(() {
                          emptyReceipt = true;
                        });
                      }else{
                        setState(() {
                          emptyReceipt = false;
                        });
                      }
                    },
                    
                    icon: Icons.location_on,
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(10),
                  ),
                  emptyReceipt ? emptyField() : Container(),
                  SizedBox(height: ScreenUtil().setHeight(50)),
                  receiptController.text.isEmpty || _imageFile == null
                      ? PrimaryButtonWidget(
                          color: Color(0xFF252B37),
                          title: "Done",
                          function: () {
                            if (receiptController.text.isEmpty) {
                              setState(() {
                                emptyReceipt = true;
                              });
                            }
                            if (_imageFile == null) {
                              setState(() {
                                noPhoto = true;
                              });
                            }
                          },
                          isLoading: false,
                        )
                      : SliderButtonWidget(
                          label: "Done",
                          onAction: () async {
                            final navigator = Navigator.of(context);
                            //send msg to customer 
                            Message message = Message(senderId: widget.order.genieId, receiverId: widget.order.customerId, 
                              text: 'A photo of the receipt will be sent to you.');
                            SocketService().sendMessage(chatId: ChatId, message: message);
                            //update store status to done
                            await OrderApiService().updateStoreStatus(widget.order.orderId, widget.store.id);
                            //update the order receipt value field to the sum of the old value and the receiptController value
                            final int totalvalue = int.parse(widget.order.totalReceiptValue) + int.parse(receiptController.text) ;
                            final updatedOrder = await OrderApiService().updateOrderReceiptValue(widget.order.orderId, totalvalue.toString());
                            // if this is the last store then send notification to customer the summary is ready and go to customer location screen
                            // else go back to orderstages pageview
                            int index = hasPendingStores(updatedOrder!) ??  -1;
                            if(index != -1){
                              await AuthService().updateGenieProgress(orderId: widget.order.orderId, step: 'orderDetails', storeIndex: index);
                              navigator.push(
                                MaterialPageRoute<void>(
                                  builder: (context) => OrderDetailsScreen(order: updatedOrder,),
                                ),
                              );
                            }else{
                              print("No pending store left");
                              await AuthService().updateGenieProgress(orderId: widget.order.orderId, step: 'customerLocation');
                              navigator.pushReplacement(
                                MaterialPageRoute<void>(
                                  builder: (context) => CustomerLocationScreen(order: widget.order,),
                                ),
                              );
                            }
                          }),
                  SizedBox(height: ScreenUtil().setHeight(5)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget emptyField() {
    return Text(
      "Please fill this field it can't be empty..",
      style: Theme.of(context).textTheme.labelSmall!.copyWith(color: Color(0xFFAB2929))
    );
  }
}
