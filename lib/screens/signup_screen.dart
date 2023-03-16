import 'package:chatapp/constants.dart';
import 'package:chatapp/screens/signin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../help_tools/show_snack_bar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_texfformtield.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({super.key});

  static String id = 'SignupScreen';

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String? email;

  String? password;

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        body: Form(
          key: formKey,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: kPrimaryColor,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
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
                              'Sign up',
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
                          onchanged: (data) {
                            password = data;
                          },
                          hintText: 'Enter your password',
                          hidden: true,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomButton(
                          ontap: () async {
                            if (formKey.currentState!.validate()) {
                              isLoading = true;
                              setState(() {});
                              try {
                                await registerAccount();
                                showSnackBar(
                                    context, 'Account created succefully.');
                                Navigator.pop(context);
                              } on FirebaseAuthException catch (ex) {
                                if (ex.code == 'weak-password') {
                                  showSnackBar(context,
                                      'The password entered is too weak.');
                                } else if (ex.code == 'email-already-in-use') {
                                  showSnackBar(context,
                                      'The account already exists for that email.');
                                }
                              }
                              isLoading = false;
                              setState(() {});
                            } else {}
                          },
                          text: ' Sign up',
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account ?",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                '  Sign in',
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

  Future<void> registerAccount() async {
    var auth = FirebaseAuth.instance;
    UserCredential user = await auth.createUserWithEmailAndPassword(
        email: email!, password: password!);
  }
}
