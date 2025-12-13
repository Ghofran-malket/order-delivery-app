import 'package:algenie/data/models/message_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:developer';

class SocketService {
  //create ONE shared instance of SocketService
  static final SocketService _instance = SocketService._internal();

  //returns the same _instance every time. 
  factory SocketService() => _instance;
  //private constructor  prevent to create multiple constructors
  SocketService._internal();

  IO.Socket? socket;
  bool _connected = false;

  final List<Map<String, dynamic>> _pendingMessages = [];

  void init(String chatId) {
    if (socket != null) return;

    socket = IO.io(
      "http://192.168.1.89:3000",
      IO.OptionBuilder()
        .setTransports(['websocket'])
        .disableAutoConnect()
        .build(),
    );

    socket!.onConnect((_) {
      _connected = true;
      socket!.emit("join_room", chatId);

      // Flush queued messages
      for (final msg in _pendingMessages) {
        socket!.emit("send_message", msg);
      }
      _pendingMessages.clear();
    });

    socket!.connect();
  }

  void sendMessage({required String chatId, required Message message}) {
    final payload = {
      "chatId": chatId,
      "senderId": message.senderId,
      "receiverId": message.receiverId,
      "text": message.text,
      "type": message.type
    };
    if (_connected) {
      socket!.emit("send_message", payload);
    } else {
      // Queue until connected
      _pendingMessages.add(payload);
    }
  }

  void onMessage(Function(dynamic msg) callback) {
    socket?.on("receive_message", (data) {
      callback(data);
    });
  }

  void removeListener() {
    socket?.off("receive_message");
  }

  void dispose() {
    socket?.disconnect();
    socket?.dispose();
    socket = null;
    _connected = false;
    _pendingMessages.clear();
  }
}
