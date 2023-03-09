import 'package:firebase_auth/firebase_auth.dart' as fba;
import 'package:flutter/foundation.dart';
import 'package:firebase_ui_oauth/firebase_ui_oauth.dart';

import 'package:firebase_ui_oauth_oidc/src/theme.dart';

/// A provider for OIDC OAuth
class OidcProvider extends OAuthProvider {
  @override
  final String providerId;

  @override
  final OidcProviderButtonStyle style;

  @override
  final fba.OAuthProvider firebaseAuthProvider;

  /// A custom getter for the ID token
  ///
  /// Used to provide a manual OIDC sign-in flow
  final ValueGetter<Future<OidcToken>>? getToken;

  /// Constructor
  OidcProvider({
    required this.providerId,
    required this.style,
    Map<String, dynamic> customParameters = const {},
    Set<String> scopes = const {},
    this.getToken,
  })  : assert(providerId.startsWith('oidc.')),
        firebaseAuthProvider = fba.OAuthProvider(providerId) {
    firebaseAuthProvider.setCustomParameters(customParameters);
    firebaseAuthProvider.setScopes(scopes.toList());
  }

  @override
  void platformSignIn(TargetPlatform platform, AuthAction action) async {
    authListener.onBeforeSignIn();

    final fba.UserCredential credential;
    try {
      if (getToken != null) {
        final token = await getToken!();
        credential = await auth.signInWithCredential(
          firebaseAuthProvider.credential(
            idToken: token.idToken,
            rawNonce: token.rawNonce,
          ),
        );
      } else {
        if (kIsWeb) {
          credential = await auth.signInWithPopup(firebaseAuthProvider);
        } else {
          credential = await auth.signInWithProvider(firebaseAuthProvider);
        }
      }
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
  void mobileSignIn(AuthAction action) => throw UnimplementedError();

  @override
  void desktopSignIn(AuthAction action) => throw UnimplementedError();

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

/// An intermediate OidcToken to be sent to Firebase for authentication
class OidcToken {
  /// The ID token
  final String idToken;

  /// The raw nonce
  ///
  /// See [OAuthCredential.rawNonce]
  final String? rawNonce;

  /// Constructor
  OidcToken({
    required this.idToken,
    this.rawNonce,
  });
}
