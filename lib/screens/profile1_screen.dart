import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

final _actionCodeSettings = ActionCodeSettings(
  url: 'https://gigivet22firebase.firebaseapp.com', //esta correcta para que envie el correo de verificación
  handleCodeInApp: false, // en FALSO para que envie el dynamic link correcto
  androidMinimumVersion: '1',
  androidPackageName: 'com.davdev88.gigivet22firebase',
  //iOSBundleId: 'io.flutter.plugins.fireabaseUiExample',
  dynamicLinkDomain: 'gigivet22fb.page.link',
  
);


class Profile1_Screen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final mfaAction = AuthStateChangeAction<MFARequired>(
      (context, state) async {
        final nav = Navigator.of(context);

        await startMFAVerification(
          resolver: state.resolver,
          context: context,
        );

        nav.pushReplacementNamed('mainmenu');
      },
    );

    return ProfileScreen(
            actions: [
              SignedOutAction((context) {
                Navigator.pushReplacementNamed(context, 'login');
              }),
              mfaAction,
            ],
            actionCodeSettings: _actionCodeSettings,
            showMFATile: true,
            
          );
  }
}