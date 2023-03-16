import 'package:chatapp/constants.dart';
import 'package:chatapp/screens/chat_screen.dart';
import 'package:chatapp/screens/signup_screen.dart';
import 'package:chatapp/widgets/custom_button.dart';
import 'package:chatapp/widgets/custom_texfformtield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../help_tools/show_snack_bar.dart';

class SigninScreen extends StatefulWidget {
  SigninScreen({super.key});

  static String id = 'SigninScreen';

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  String? email;

  String? password;

  bool isLoading = false;

  GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: kPrimaryColor,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Form(
            key: formkey,
            child: ListView(
              children: [
                Container(
                  width: 500,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 60,
                        ),
                        Container(
                          width: 100,
                          height: 100,
                          child: Image.asset(
                            'assets/images/chat.png',
                          ),
                        ),
                        Text(
                          'EasyChat',
                          style: TextStyle(
                            fontSize: 45,
                            fontFamily: 'Shadow',
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              'Sign in',
                              style: TextStyle(fontSize: 25),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        CustomTextFormField(
                          onchanged: (data) {
                            email = data;
                          },
                          hintText: 'Entet your e-mail',
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomTextFormField(
                          hidden: true,
                          onchanged: (data) {
                            password = data;
                          },
                          hintText: 'Enter your password',
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomButton(
                          ontap: () async {
                            if (formkey.currentState!.validate()) {
                              isLoading = true;
                              setState(() {});
                              try {
                                await singinAccount();
                                showSnackBar(context, 'Welcome back');
                                Navigator.pushNamed(context, ChatScreen.id,
                                    arguments: email);
                              } on FirebaseAuthException catch (ex) {
                                if (ex.code == 'user-not-found') {
                                  showSnackBar(
                                      context, 'No user found for that email.');
                                } else if (ex.code == 'wrong-password') {
                                  showSnackBar(context, 'Wrong password.');
                                }
                              }
                              isLoading = false;
                              setState(() {});
                            } else {}
                          },
                          text: 'Sign in',
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account ?",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, SignupScreen.id);
                              },
                              child: Text(
                                '  Sign up',
                                style: TextStyle(
                                  color: Colors.lightBlueAccent,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> singinAccount() async {
    var auth = FirebaseAuth.instance;
    UserCredential user = await auth.signInWithEmailAndPassword(
        email: email!, password: password!);
  }
}
