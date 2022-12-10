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

class VerifyEmailScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return EmailVerificationScreen(
            headerBuilder: headerIcon(Icons.verified),
            sideBuilder: sideIcon(Icons.verified),
            actionCodeSettings: _actionCodeSettings,
            actions: [
              EmailVerifiedAction(() {
                Navigator.pushReplacementNamed(context, 'profile_ui');
              }),
              AuthCancelledAction((context) {
                FirebaseUIAuth.signOut(context: context);
                Navigator.pushReplacementNamed(context, 'login');
              }),
            ],
          );
  }
}