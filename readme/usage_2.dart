import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_oidc/firebase_ui_oauth_oidc.dart';
import 'package:flutter/material.dart';

import 'example_button_style.dart';

class MyScreen extends StatelessWidget {
  const MyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthStateListener<OAuthController>(
      listener: (oldState, newState, controller) {
        if (newState is SignedIn) {
          // navigate to other screen.
          return true;
        }
        return false;
      },
      child: OAuthProviderButton(
        provider: OidcProvider(
          providerId: 'oidc.example',
          style: const ExampleButtonStyle(),
        ),
      ),
    );
  }
}
