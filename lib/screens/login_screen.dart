import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:gigivet22firebase/widgets/decorations.dart';



class LoginScreen extends StatelessWidget {

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

    return SignInScreen(
            actions: [
              ForgotPasswordAction((context, email) {
                Navigator.pushNamed(
                  context,
                  'forgot-password',
                  arguments: {'email': email},
                );
              }),
              VerifyPhoneAction((context, _) {
                Navigator.pushNamed(context, 'phone');
              }),
              AuthStateChangeAction<SignedIn>((context, state) {
                if (!state.user!.emailVerified) {
                  Navigator.pushNamed(context, 'verify-email');
                } else {
                  Navigator.pushReplacementNamed(context, 'mainmenu');
                }
              }),
              AuthStateChangeAction<UserCreated>((context, state) {
                if (!state.credential.user!.emailVerified) {
                  Navigator.pushNamed(context, 'verify-email');
                } else {
                  Navigator.pushReplacementNamed(context, 'mainmenu');
                }
              }),
              mfaAction,
              EmailLinkSignInAction((context) {
                Navigator.pushReplacementNamed(context, 'email-link-sign-in');
              }),
            ],
            styles: const {
              EmailFormStyle(signInButtonVariant: ButtonVariant.filled),
            },
            headerBuilder: headerImage('assets/flutterfire_logo.png'),
            sideBuilder: sideImage('assets/flutterfire_logo.png'),
            subtitleBuilder: (context, action) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  action == AuthAction.signIn
                      ? 'Welcome to GigiFirebase! Please sign in to continue.'
                      : 'Welcome to GigiFirebase! Please create an account to continue',
                ),
              );
            },
            footerBuilder: (context, action) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    action == AuthAction.signIn
                        ? 'By signing in, you agree to our terms and conditions.'
                        : 'By registering, you agree to our terms and conditions.',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
              );
            },
          );

  }

}