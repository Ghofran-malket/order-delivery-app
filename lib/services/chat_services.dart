import 'dart:convert';
import 'package:algenie/data/models/message_model.dart';
import 'package:http/http.dart' as http;

class ChatService {
  final String baseUrl = "http://192.168.1.89:3000/api/";


  //get the messages between genie and customer
  Future<List<Message>> getMessages(String chatId) async {
    try{
      var url = Uri.parse("${baseUrl}chat/getMessages/$chatId");
      var res = await http.get(url);

      if (res.statusCode == 200) {
        final List<dynamic> data = jsonDecode(res.body);
        final List<Message> messages = data.map((e) => Message.fromJson(e)).toList();
        return messages;
      }
      return [];
    } catch(e){
      throw Exception(e.toString());
    }
  }

}