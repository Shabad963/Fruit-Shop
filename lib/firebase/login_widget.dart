import 'dart:ffi' as prefix;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_sample/firebase/forgot_password_page.dart';
import 'package:firebase_sample/firebase/utils.dart';
import 'package:firebase_sample/main.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginWidget extends StatefulWidget {
  final VoidCallback onClickedSignUp;
  const LoginWidget({Key? key, required this.onClickedSignUp})
      : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 60,
          ),
          Text(
            "Checkout",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Fill details to proceed",
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          TextField(
            controller: emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
              ),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: passwordController,
            decoration: const InputDecoration(
              labelText: 'Password',
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
              ),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
            ),
            obscureText: true,
          ),
          SizedBox(
            height: 40,
          ),
          ElevatedButton.icon(
            onPressed: () {
              signIn();
            },
            label: Text(
              'Login',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            style: TextButton.styleFrom(
                minimumSize: Size.fromHeight(40), backgroundColor: Colors.teal),
            icon: Icon(Icons.lock),
          ),
          SizedBox(
            height: 24,
          ),
          GestureDetector(
            child: Text(
              'Forgot Password?',
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.teal,
                  fontSize: 20),
            ),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ForgotPassWordPage(),
            )),
          ),
          SizedBox(
            height: 40,
          ),
          RichText(
              text: TextSpan(
                  style: TextStyle(color: Colors.black),
                  text: 'No account?   ',
                  children: [
                TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = widget.onClickedSignUp,
                    text: 'SignUp',
                    style: TextStyle(color: Colors.teal))
              ]))
        ],
      ),
    );
  }

  Future signIn() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      print(e);

      Utils.showSnackBar(e.message);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
