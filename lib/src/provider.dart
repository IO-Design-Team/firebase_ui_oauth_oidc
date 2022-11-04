import 'package:firebase_auth/firebase_auth.dart' as fba;
import 'package:flutter/foundation.dart';
import 'package:firebase_ui_oauth/firebase_ui_oauth.dart';

import 'theme.dart';

/// A provider for OIDC OAuth
class OidcProvider extends OAuthProvider {
  @override
  final String providerId;

  @override
  final ThemedOAuthProviderButtonStyle style;

  @override
  final fba.OAuthProvider firebaseAuthProvider;

  /// Constructor
  OidcProvider({
    required this.providerId,
    this.style = const OidcProviderButtonStyle(),
    Map<String, dynamic> customParameters = const {},
    Set<String> scopes = const {},
  })  : assert(providerId.startsWith('oidc.')),
        firebaseAuthProvider = fba.OAuthProvider(providerId) {
    firebaseAuthProvider.setCustomParameters(customParameters);
    scopes.forEach(firebaseAuthProvider.addScope);
  }

  @override
  void mobileSignIn(AuthAction action) {
    authListener.onBeforeSignIn();

    auth.signInWithProvider(firebaseAuthProvider).then((userCred) {
      if (action == AuthAction.signIn) {
        authListener.onSignedIn(userCred);
      } else {
        authListener.onCredentialLinked(userCred.credential!);
      }
    }).catchError((err) {
      authListener.onError(err);
    });
  }

  @override
  void desktopSignIn(AuthAction action) {
    mobileSignIn(action);
  }

  @override
  ProviderArgs get desktopSignInArgs => throw UnimplementedError();

  @override
  fba.OAuthCredential fromDesktopAuthResult(AuthResult result) {
    throw UnimplementedError();
  }

  @override
  Future<void> logOutProvider() {
    return SynchronousFuture(null);
  }

  @override
  bool supportsPlatform(TargetPlatform platform) => true;
}
