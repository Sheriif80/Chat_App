import 'dart:ui';
import 'package:chatapp/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chatapp/constants.dart';
import 'package:flutter/material.dart';

import '../widgets/message_container.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  static String id = 'chat screen';

  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollectin);

  ScrollController scrollController = ScrollController();

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messagesList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
          }
          return Scaffold(
            appBar: AppBar(
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: kPrimaryColor),
                  ),
                ),
              ),
              automaticallyImplyLeading: false,
              backgroundColor: Colors.teal,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    kLogo,
                    height: 35,
                  ),
                  Text(
                    'EasyChat',
                    style: TextStyle(
                      fontFamily: 'Shadow',
                      fontSize: 28,
                    ),
                  ),
                ],
              ),
              centerTitle: true,
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: scrollController,
                    itemCount: messagesList.length,
                    itemBuilder: (context, index) {
                      return messagesList[index].uniqueID == email
                          ? MessageContainerSent(
                              message: messagesList[index],
                            )
                          : MessageContainerReceived(
                              message: messagesList[index]);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(6),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (value) {
                      messages.add(
                        {
                          kMessage: value,
                          kCreatedAt: DateTime.now(),
                          'id': email,
                        },
                      );
                      controller.clear();
                      scrollController.animateTo(
                        0,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                      );
                    },
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      suffix: Icon(
                        Icons.send_sharp,
                        color: Colors.blue,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Scaffold(
            body: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Loading .. ',
                    style: TextStyle(fontSize: 30),
                  ),
                  Icon(
                    Icons.chat_bubble,
                    size: 30,
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
