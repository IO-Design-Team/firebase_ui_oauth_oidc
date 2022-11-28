import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_oauth_oidc/firebase_ui_oauth_oidc.dart';
import 'package:flutter/material.dart';

import 'example_button_style.dart';

class MyScreen extends StatelessWidget {
  const MyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OidcSignInButton(
      providerId: 'oidc.example',
      style: const ExampleButtonStyle(),
      loadingIndicator: const CircularProgressIndicator(),
      onSignedIn: (UserCredential credential) {
        // perform navigation.
      },
    );
  }
}
