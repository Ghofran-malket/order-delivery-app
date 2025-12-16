class Message {
  String senderId;
  String receiverId;
  String text;
  String type;

  Message({required this.senderId, required this.receiverId, required this.text, this.type = 'text'});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      senderId: json['senderId'],
      receiverId: json['receiverId'] ,
      text: json['text'],
      type: json['type']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'text': text,
      'type': type

    };
  }
}