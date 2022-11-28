library firebase_ui_oauth_oidc;

export 'package:firebase_ui_oauth/firebase_ui_oauth.dart'
    show ThemedColor, ThemedIconSrc;

export 'src/provider.dart' show OidcProvider, OidcToken;
export 'src/theme.dart' show OidcProviderButtonStyle;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_oauth_oidc/firebase_ui_oauth_oidc.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_ui_oauth/firebase_ui_oauth.dart';

/// Standalone OIDC sign-in button.
class OidcSignInButton extends _OidcSignInButton {
  /// Constructor
  const OidcSignInButton({
    super.key,
    required super.providerId,
    required super.style,
    required super.loadingIndicator,
    super.action = null,
    super.auth,
    super.isLoading,
    super.label,
    super.onDifferentProvidersFound,
    super.onSignedIn,
    super.onTap,
    super.overrideDefaultTapAction,
    super.size,
    super.onError,
    super.onCanceled,
  });
}

/// Standalone OIDC sign-in icon button.
class OidcSignInIconButton extends _OidcSignInButton {
  /// Constructor
  const OidcSignInIconButton({
    super.key,
    required super.providerId,
    required super.style,
    required super.loadingIndicator,
    super.action = null,
    super.auth,
    super.isLoading,
    super.onDifferentProvidersFound,
    super.onSignedIn,
    super.onTap,
    super.overrideDefaultTapAction,
    super.size,
    super.onError,
    super.onCanceled,
  }) : super(label: '');
}

class _OidcSignInButton extends StatelessWidget {
  final String providerId;
  final OidcProviderButtonStyle style;
  final String label;
  final Widget loadingIndicator;
  final void Function()? onTap;
  final bool overrideDefaultTapAction;
  final bool isLoading;

  /// {@macro ui.auth.auth_action}
  final AuthAction? action;

  /// {@macro ui.auth.auth_controller.auth}
  final FirebaseAuth? auth;
  final DifferentProvidersFoundCallback? onDifferentProvidersFound;
  final SignedInCallback? onSignedIn;
  final double size;
  final void Function(Exception exception)? onError;
  final VoidCallback? onCanceled;

  const _OidcSignInButton({
    super.key,
    required this.providerId,
    required this.style,
    required this.loadingIndicator,
    String? label,
    bool? overrideDefaultTapAction,
    this.onTap,
    this.isLoading = false,
    this.action = AuthAction.signIn,
    this.auth,
    this.onDifferentProvidersFound,
    this.onSignedIn,
    double? size,
    this.onError,
    this.onCanceled,
  })  : label = label ?? 'Sign in with OIDC',
        overrideDefaultTapAction = overrideDefaultTapAction ?? false,
        size = size ?? 19;

  OidcProvider get provider =>
      OidcProvider(providerId: providerId, style: style);

  @override
  Widget build(BuildContext context) {
    return OAuthProviderButtonBase(
      provider: provider,
      label: label,
      onTap: onTap,
      loadingIndicator: loadingIndicator,
      isLoading: isLoading,
      action: action,
      auth: auth ?? FirebaseAuth.instance,
      onDifferentProvidersFound: onDifferentProvidersFound,
      onSignedIn: onSignedIn,
      overrideDefaultTapAction: overrideDefaultTapAction,
      size: size,
      onError: onError,
      onCancelled: onCanceled,
    );
  }
}
