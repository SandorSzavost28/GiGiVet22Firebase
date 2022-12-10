import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:gigivet22firebase/widgets/decorations.dart';

final _actionCodeSettings = ActionCodeSettings(
  url: 'https://gigivet22firebase.firebaseapp.com', //esta correcta para que envie el correo de verificación
  handleCodeInApp: false, // en FALSO para que envie el dynamic link correcto
  androidMinimumVersion: '1',
  androidPackageName: 'com.davdev88.gigivet22firebase',
  //iOSBundleId: 'io.flutter.plugins.fireabaseUiExample',
  dynamicLinkDomain: 'gigivet22fb.page.link',
  
);
final emailLinkProviderConfig = EmailLinkAuthProvider(
  actionCodeSettings: _actionCodeSettings,
);

class EmailLinkScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return EmailLinkSignInScreen(
            actions: [
              AuthStateChangeAction<SignedIn>((context, state) {
                Navigator.pushReplacementNamed(context, 'login');
              }),
            ],
            provider: emailLinkProviderConfig,
            headerMaxExtent: 200,
            headerBuilder: headerIcon(Icons.link),
            sideBuilder: sideIcon(Icons.link),
          );
  }
}