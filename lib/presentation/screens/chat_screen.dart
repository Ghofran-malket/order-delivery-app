import 'dart:convert';

import 'package:algenie/data/models/message_model.dart';
import 'package:algenie/data/models/order_model.dart';
import 'package:algenie/presentation/widgets/message_widget.dart';
import 'package:algenie/providers/auth_provider.dart';
import 'package:algenie/services/api_service.dart';
import 'package:algenie/services/chat_services.dart';
import 'package:algenie/services/socket_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatScreen extends StatefulWidget {
  final Order order;

  const ChatScreen({super.key, required this.order});
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _hasCallSupport = false;
  final SocketService socketService = SocketService();
  final TextEditingController messageController = TextEditingController();

  List<Message> messages = [];

  loadMessages(String chatId) async{
    List<Message> msg = await ChatService().getMessages(chatId);
    setState(() {
      messages= msg;
    });
    _scrollToBottom();
  }

  @override
  void initState() {
    //chatId will be the genieId + orderId
    String chatId = widget.order.genieId + widget.order.orderId;
    //connect to the socket
    socketService.connect(chatId);

    loadMessages(chatId);
    

    // Check for phone call support.
    canLaunchUrl(Uri(scheme: 'tel', path: '123')).then((bool result) {
      setState(() {
        _hasCallSupport = result;
      });
    });

    //Listen for new messages
    socketService.onMessage((msg) {
      setState(() {
        messages.add(Message.fromJson(msg));
      });
      _scrollToBottom();
    });

    super.initState();
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }


  void sendMsg(String senderId, String receiverId,) {
    String chatId = widget.order.genieId + widget.order.orderId;
    final text = messageController.text.trim();
    if (text.isEmpty) return;

    final message = Message(senderId: senderId, receiverId: receiverId, text: text);
    
    
    socketService.sendMessage(
      chatId: chatId,
      message: message
    );

    messageController.clear();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    socketService.dispose();
    _scrollController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService().getUserInfo(widget.order.customerId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Scaffold(body: Center(child: CircularProgressIndicator()));

        var receiver = snapshot.data!;
        return Scaffold(
          backgroundColor: Color(0xFF143038),
          appBar: AppBar(
            title: Text(
              receiver.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "poppin-semibold",
                fontSize: 20,
                color: Color(0xFF252B37),
              ),
            ),
            leading: IconButton(
              icon: Icon(Icons.keyboard_arrow_left),
              color: Color(0xFF252B37),
              iconSize: ScreenUtil().setSp(25),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: [
              IconButton(
                padding:
                    EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(17)),
                icon: Icon(Icons.info_rounded),
                iconSize: ScreenUtil().setSp(25),
                color: Color(0xFF252B37),
                onPressed: () {},
              ),
              _hasCallSupport
                  ? IconButton(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(17)),
                      icon: Icon(Icons.call),
                      iconSize: ScreenUtil().setSp(25),
                      color: Color(0xFF252B37),
                      onPressed: () {
                        _makePhoneCall(receiver.number);
                      },
                    )
                  : ElevatedButton(
                      child: const Text('Calling not supported'),
                      onPressed: () {},
                    ),
            ],
          ),
          body: Consumer<AuthProvider>(builder: (context, auth, child) {
            final sender = auth.user!;
            return Column(
              children: [
                Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(ScreenUtil().setWidth(40)),
                      bottomLeft: Radius.circular(ScreenUtil().setWidth(40)),
                    ),
                  ),
                  height: MediaQuery.of(context).size.height * 0.85 -
                      AppBar().preferredSize.height,
                  child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(17),vertical: ScreenUtil().setHeight(10)),
                      
                        child: ListView.builder(
                                padding: EdgeInsets.all(0),
                                shrinkWrap: true,
                                controller: _scrollController,
                                scrollDirection: Axis.vertical,
                                itemCount: messages.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final msg = messages[index];
                                  bool isMe = msg.senderId == sender.id;
                                  return MessageWidget(
                                          myMessage: isMe,
                                          message: msg.text,
                                          type: 'message',
                                          receiver: receiver,
                                          orderId: widget.order.orderId
                                        );
                                },
                              ),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(17),
                      vertical: ScreenUtil().setHeight(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 2,
                                color: Colors.black12,
                                offset: Offset(1, 2),
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          child: TextFormField(
                            autofocus: false,
                            controller: messageController,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Write a Message ...",
                              hintStyle: TextStyle(
                                fontFamily: "Poppins-Medium",
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Transform.rotate(
                        angle: -90 * 3.1415926535 / 180,
                        child: IconButton(
                          icon: Icon(Icons.attachment),
                          color: Colors.white,
                          iconSize: ScreenUtil().setHeight(25),
                          onPressed: () {},
                        ),
                      ),
                      CircleAvatar(
                          maxRadius: ScreenUtil().setHeight(25),
                          backgroundColor: Colors.white,
                          child: Transform.rotate(
                              angle: -45 * 3.1415926535 / 180,
                              child: IconButton(
                                icon: Icon(Icons.send),
                                color: Color(0xFF252B37),
                                onPressed: () => sendMsg(sender.id!, receiver.id!),
                              ))),
                    ],
                  ),
                ),
              ],
            );
          })
        );
      }
    );
  }
}
