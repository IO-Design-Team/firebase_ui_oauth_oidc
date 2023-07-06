import 'package:firebase_ui_oauth_oidc/firebase_ui_oauth_oidc.dart';
import 'package:flutter/material.dart';

const _backgroundColor = ThemedColor(Colors.black, Colors.white);
const _color = ThemedColor(Colors.white, Colors.black);

const _dartIconSvgLight = '''
<svg xmlns:svg="http://www.w3.org/2000/svg" xmlns="http://www.w3.org/2000/svg" version="1.1" id="Layer_1" x="0px" y="0px" viewBox="188 251.8 110.5 110.5" enable-background="new 188 251.8 415.8 110.5" xml:space="preserve" width="110.5" height="110.5">
<path d="m217.7,281.7-7.1,-7.1v51.2l0.1,2.4c0,1.1 0.2,2.4 0.6,3.7l56.2,19.8 14,-6.2v0z" id="path2" style="fill:#00c4b3" />
<path d="m211.3,331.9v0c0,0 0,0 0,0 0,0 0,0 0,0zm70.2,13.6-14,6.2-56.1,-19.8c1.1,4.1 3.4,8.7 6,11.3l18.3,18.2 40.8,0.1z" id="path4" style="fill:#22d3c5" />
<path d="m210.8,274.6-21.8,33c-1.8,1.9-0.9,5.9 2,8.9l12.6,12.7 7.9,2.8c-0.3,-1.3-0.6,-2.6-0.6,-3.7l-0.1,-2.4z" id="path6" style="fill:#0075c9" />
<path d="m267.9,275.2c-1.3,-0.3-2.6,-0.5-3.7,-0.6l-2.5,-0.1h-51.1l70.9,70.9v0l6.2,-14z" id="path8" style="fill:#0075c9" />
<path d="m267.8,275.2c0.1,0 0.1,0 0,0v0c0.1,0 0.1,0 0,0zm11.4,6c-2.6,-2.6-7.1,-5-11.3,-6l19.8,56.2-6.2,14v0l15.2,-4.9v-41.7z" id="path10" style="fill:#00a8e1" />
<path d="m265.1,267.4-12.7,-12.6c-2.9,-2.9-6.9,-3.8-8.9,-2l-33,21.8h51.1l2.5,0.1c1.1,0 2.4,0.2 3.7,0.6z" id="path12" style="fill:#00c4b3" />
</svg>
''';

// Actually use a dark version of the svg here
const _dartIconSvgDark = _dartIconSvgLight;

const _dartIconSrc = ThemedIconSrc(_dartIconSvgLight, _dartIconSvgDark);

class ExampleButtonStyle extends OidcProviderButtonStyle {
  const ExampleButtonStyle();

  @override
  ThemedColor get backgroundColor => _backgroundColor;

  @override
  ThemedColor get color => _color;

  @override
  ThemedIconSrc get iconSrc => _dartIconSrc;

  @override
  double get iconPadding => 6;

  @override
  String get label => 'Sign in with pub.dev';
}
