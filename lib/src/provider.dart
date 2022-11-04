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
    firebaseAuthProvider.setScopes(scopes.toList());
  }

  @override
  void mobileSignIn(AuthAction action) async {
    authListener.onBeforeSignIn();

    final fba.UserCredential credential;
    try {
      credential = await auth.signInWithProvider(firebaseAuthProvider);
    } catch (err) {
      authListener.onError(err);
      return;
    }

    if (action == AuthAction.signIn) {
      authListener.onSignedIn(credential);
    } else {
      authListener.onCredentialLinked(credential.credential!);
    }
  }

  @override
  void desktopSignIn(AuthAction action) => mobileSignIn(action);

  @override
  ProviderArgs get desktopSignInArgs => throw UnimplementedError();

  @override
  fba.OAuthCredential fromDesktopAuthResult(AuthResult result) =>
      throw UnimplementedError();

  @override
  Future<void> logOutProvider() => SynchronousFuture(null);

  /// Supported on platforms that support the official Firebase plugins
  @override
  bool supportsPlatform(TargetPlatform platform) =>
      kIsWeb ||
      platform == TargetPlatform.iOS ||
      platform == TargetPlatform.android ||
      platform == TargetPlatform.macOS;
}
