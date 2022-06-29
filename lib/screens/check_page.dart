import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_sample/firebase/authpage.dart';
import 'package:firebase_sample/firebase/verify_email_page.dart';
import 'package:flutter/material.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Something went wrong'));
            } else if (snapshot.hasData) {
              return VerifyEmailPAge();
            } else {
              return AuthPage();
            }
          }),
    );
  }
}
