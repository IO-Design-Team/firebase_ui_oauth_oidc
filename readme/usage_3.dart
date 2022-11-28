import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyScreen extends StatelessWidget {
  const MyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OidcSignInButton(
      loadingIndicator: const CircularProgressIndicator(),
      onSignedIn: (UserCredential credential) {
        // perform navigation.
      },
    );
  }
}
