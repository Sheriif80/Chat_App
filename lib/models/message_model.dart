import 'package:chatapp/constants.dart';

class Message {
  final String message;
  final String uniqueID;
  Message(this.message, this.uniqueID);

  factory Message.fromJson(jsonData) {
    return Message(jsonData[kMessage], jsonData[kID]);
  }
}
