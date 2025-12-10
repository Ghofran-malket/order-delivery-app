import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatService {
  final String baseUrl = "http://192.168.1.89:3000/api/";


  //get the messages between genie and customer
  Future<List> getMessages(String chatId) async {
    try{
      var url = Uri.parse("${baseUrl}messages/getMessages/$chatId");
      var res = await http.get(url);

      if (res.statusCode == 200) {
        return jsonDecode(res.body);
      }
      return [];
    } catch(e){
      throw Exception(e.toString());
    }
  }

}