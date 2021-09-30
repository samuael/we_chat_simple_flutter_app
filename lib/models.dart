enum MessageType {
  Unknown,
  EndToEndClientMessage,
  EndToEndServerReply,
  BroadcastMessageType,
  BroadcastTypingMessage,
  BroadcastStopTypingMessage,
}

class Message {
  bool amITheOwner;
  MessageType type;
  String message;
  String from;
  String username;

  Message({
    required this.amITheOwner,
    required this.type,
    required this.message,
    required this.from,
    required this.username,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      amITheOwner: false,
      type: MessageType.values[(int.parse("${json['type']}")) - 1],
      message: json["message"],
      from: json['from'],
      username: json["username"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "type": this.type,
      "message": this.message,
      "from": this.from,
      "username": this.username,
    };
  }
}


// class Message