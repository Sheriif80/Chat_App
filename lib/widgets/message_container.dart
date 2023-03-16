import 'package:chatapp/models/message_model.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class MessageContainerSent extends StatelessWidget {
  const MessageContainerSent({super.key, required this.message});
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.only(left: 12, top: 15, bottom: 15, right: 12),
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
              bottomRight: Radius.circular(30)),
          gradient: LinearGradient(colors: kPrimaryColor),
        ),
        child: Text(
          message.message,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}

class MessageContainerReceived extends StatelessWidget {
  const MessageContainerReceived({super.key, required this.message});
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.only(left: 12, top: 15, bottom: 15, right: 12),
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
              bottomLeft: Radius.circular(30)),
          gradient: LinearGradient(colors: kPrimaryColor),
        ),
        child: Text(
          message.message,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
