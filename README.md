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

```dart
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_apple/firebase_ui_oauth_oidc.dart';

void main() {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

    FirebaseUIAuth.configureProviders([
        AppleProvider(),
    ]);

    runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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

```dart
class MyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AuthStateListener<OAuthController>(
      listener: (oldState, newState, controller) {
        if (newState is SignedIn) {
          // navigate to other screen.
        }
      },
      child: OAuthProviderButton(
        provider: AppleProvider(),
      ),
    );
  }
}
```

Also there is a standalone version of the `AppleSignInButton`

```dart
class MyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppleSignInButton(
      loadingIndicator: CircularProgressIndicator(),
      onSignedIn: (UserCredential credential) {
        // perform navigation.
      }
    );
  }
}
```
