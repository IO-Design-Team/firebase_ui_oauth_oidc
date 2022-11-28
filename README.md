# Firebase UI OAuth OIDC

[![pub package](https://img.shields.io/pub/v/firebase_ui_oauth_oidc.svg)](https://pub.dev/packages/firebase_ui_oauth_oidc)

OIDC Sign In for [Firebase UI Auth](https://pub.dev/packages/firebase_ui_auth)

## Installation

Add dependency

```sh
flutter pub add firebase_ui_auth
flutter pub add firebase_ui_oauth_oidc

flutter pub global activate flutterfire_cli
flutterfire configure
```

Enable OIDC provider on [firebase console](https://console.firebase.google.com/).

## Usage

<!-- embedme readme/usage_1.dart -->
```dart
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_oidc/firebase_ui_oauth_oidc.dart';
import 'package:flutter/material.dart';

import 'example_button_style.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseUIAuth.configureProviders([
    OidcProvider(providerId: 'oidc.example', style: const ExampleButtonStyle()),
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignInScreen(
        actions: [
          AuthStateChangeAction<SignedIn>((context, state) {
            // redirect to other screen
          })
        ],
      ),
    );
  }
}

```

Alternatively you could use the `OAuthProviderButton`

<!-- embedme readme/usage_2.dart -->
```dart
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

```

Also there is a standalone version of the `OidcSignInButton`

<!-- embedme readme/usage_3.dart -->
```dart
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

```
