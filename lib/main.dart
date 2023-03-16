import 'package:chatapp/screens/chat_screen.dart';
import 'package:chatapp/screens/signin_screen.dart';
import 'package:chatapp/screens/signup_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        SignupScreen.id: (context) => SignupScreen(),
        SigninScreen.id: (context) => SigninScreen(),
        ChatScreen.id: (context) => ChatScreen(),
      },
      initialRoute: 'SigninScreen',
    );
  }
}
