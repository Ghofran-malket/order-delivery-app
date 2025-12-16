import 'dart:io';

import 'package:algenie/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageWidget extends StatelessWidget {
  final bool myMessage;
  final String message;
  final String type;
  final User receiver;
  final String? orderId;

  const MessageWidget(
      {super.key,
      required this.myMessage,
      required this.message,
      required this.type,
      required this.receiver,
      this.orderId});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment:
          myMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        myMessage
            ? Container()
            : CircleAvatar(
                radius: ScreenUtil().setHeight(25),
                backgroundImage: receiver.image!.startsWith("http") ? NetworkImage(receiver.image!) : FileImage(File(receiver.image!),)
              ),
        ChatBubble(
          clipper: ChatBubbleClipper6(
              type: myMessage
                  ? BubbleType.sendBubble
                  : BubbleType.receiverBubble),
          alignment: myMessage ? Alignment.topCenter : null,
          backGroundColor: myMessage ? Color(0xFFAB2929) : Colors.white,
          margin: EdgeInsets.only(top: 20),
          child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              child: type == 'message'
                  ? Text(
                      message,
                      style: TextStyle(color: Colors.black),
                    )
                  : type == 'image'
                      ? GestureDetector(
                          onTap: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => ViewImage(
                            //         url: message,
                            //       ),
                            //     ));
                          },
                          child:
                              Hero(tag: message, child: Image.network(message)))
                      : (type == 'link' && myMessage)
                          ? Text(
                              message,
                              style: TextStyle(
                                  color: Colors.white,
                                  decoration: TextDecoration.underline),
                            )
                          : type == 'link' && !myMessage
                              ? GestureDetector(
                                  onTap: () {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //       builder: (context) => ViewOrder(
                                    //           orderId: orderId,
                                    //           genieId: receiverId),
                                    //     ));
                                  },
                                  child: Text(
                                    message,
                                    style: TextStyle(
                                        color: Colors.black,
                                        decoration: TextDecoration.underline),
                                  ))
                              : Text(
                                  message,
                                  style: TextStyle(
                                      color: Colors.black,
                                      decoration: TextDecoration.underline),
                                )),
        )
      ],
    );
  }
}
