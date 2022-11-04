import 'package:firebase_ui_oauth/firebase_ui_oauth.dart';

/// Base for creating an OIDC provider button style
abstract class OidcProviderButtonStyle extends ThemedOAuthProviderButtonStyle {
  /// Constructor
  const OidcProviderButtonStyle();

  @override
  String get assetsPackage => 'firebase_ui_oauth_oidc';

  @override
  String get label;
}
