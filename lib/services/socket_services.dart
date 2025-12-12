import 'package:algenie/data/models/message_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:developer';

class SocketService {
  late IO.Socket socket;

  void connect(String chatId) {
    socket = IO.io(
      "http://192.168.1.89:3000",
      IO.OptionBuilder()
        .setTransports(['websocket'])
        .disableAutoConnect()
        .build(),
    );

    socket.connect();

    socket.onConnect((_) {
      log("SOCKET CONNECTED");
      socket.emit("join_room", chatId);
    });
  }

  void sendMessage({required String chatId, required Message message}) {
    socket.emit("send_message", {
      "chatId": chatId,
      "senderId": message.senderId,
      "receiverId": message.receiverId,
      "text": message.text,
      "type": message.type
    });
  }

  void onMessage(Function(dynamic msg) callback) {
    socket.on("receive_message", (data) {
      callback(data);
    });
  }

  void dispose() {
    socket.off("receive_message");
    socket.dispose();
  }
}
