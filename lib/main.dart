import 'services/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gigivet22firebase/routes/routes.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:gigivet22firebase/firebase_options.dart';

import 'package:firebase_auth/firebase_auth.dart'
    hide PhoneAuthProvider, EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:firebase_ui_oauth_facebook/firebase_ui_oauth_facebook.dart';
// import 'package:firebase_ui_oauth_apple/firebase_ui_oauth_apple.dart';
// import 'package:firebase_ui_oauth_twitter/firebase_ui_oauth_twitter.dart';

import 'package:firebase_ui_localizations/firebase_ui_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';




//Documentacion https://firebase.google.com/docs/auth/admin/email-action-links?hl=en

// final actionCodeSettings = ActionCodeSettings(
//   url: 'https://gigivet22firebase.firebaseapp.com', //esta correcta para que envie el correo de verificación
//   handleCodeInApp: false, // en FALSO para que envie el dynamic link correcto
//   androidMinimumVersion: '1',
//   androidPackageName: 'com.davdev88.gigivet22firebase',
//   //iOSBundleId: 'io.flutter.plugins.fireabaseUiExample',
//   dynamicLinkDomain: 'gigivet22fb.page.link',
  
// );
// final emailLinkProviderConfig = EmailLinkAuthProvider(
//   actionCodeSettings: actionCodeSettings,
// );


void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await FirebaseAppCheck.instance.activate(
  //   //webRecaptchaSiteKey: 'recaptcha-v3-site-key',
  //   // Default provider for Android is the Play Integrity provider. You can use the "AndroidProvider" enum to choose
  //   // your preferred provider. Choose from:
  //   // 1. debug provider
  //   // 2. safety net provider
  //   // 3. play integrity provider
  //   androidProvider: AndroidProvider.debug,
  //   // androidProvider: AndroidProvider.playIntegrity,
  // );

  FirebaseUIAuth.configureProviders([
    EmailAuthProvider(),
    //emailLinkProviderConfig,
    //PhoneAuthProvider(),
    // GoogleProvider(clientId: GOOGLE_CLIENT_ID),
    GoogleProvider(clientId: '1067083310608-ufm234hshfq533edjkh29iej7fmu0ef5.apps.googleusercontent.com'),
    FacebookProvider(clientId: '1ad4bdc7b053d97ccb3cb92af69a7b6c'),
    // AppleProvider(),
    // TwitterProvider(
    //   apiKey: TWITTER_API_KEY,
    //   apiSecretKey: TWITTER_API_SECRET_KEY,
    //   redirectUri: TWITTER_REDIRECT_URI,
    // ),
  ]);

  runApp( AppState());

  // FirebaseAppCheck.instance.getToken();
  
}

// Overrides a label for en locale
// To add localization for a custom language follow the guide here:
// https://flutter.dev/docs/development/accessibility-and-localization/internationalization#an-alternative-class-for-the-apps-localized-resources
class LabelOverrides extends DefaultLocalizations {
  const LabelOverrides();

  @override
  String get emailInputLabel => 'Enter your email';

}


class AppState extends StatelessWidget {
  AppState({super.key});

  // final appCheck = FirebaseAppCheck.instance.getToken();
  
  

  // NEW
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    // print('inicio Multiprovider main');
    
    // return MyApp();
    return MultiProvider(
      //builder: ,
      providers: [
        // ChangeNotifierProvider(create: ( _ ) => PetsService(), lazy: true,),
        ChangeNotifierProvider(create: ( _ ) => PetsService(auth.currentUser!.uid), lazy: true, ),
        // ChangeNotifierProvider(create: ( _ ) => VetcontsultsService()),


      ],
      child: MyApp(),
    );
  
  }
}











class MyApp extends StatelessWidget {
  const MyApp({super.key});


  //Definicioan de initaiRoute
  String get initialRoute {
    final auth = FirebaseAuth.instance;



    if (auth.currentUser == null) {
      return 'login';
    }

    if (!auth.currentUser!.emailVerified && auth.currentUser!.email != null) {
      return 'verify-email';
    }

    print('ID de usuario firmado (main): ${auth.currentUser!.uid}');
    // print('ID de token firmado (main): ${auth.currentUser!.getIdToken().toString()}');

    return 'mainmenu';
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    final buttonStyle = ButtonStyle(
      padding: MaterialStateProperty.all(const EdgeInsets.all(12)),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );

    // final mfaAction = AuthStateChangeAction<MFARequired>(
    //   (context, state) async {
    //     final nav = Navigator.of(context);

    //     await startMFAVerification(
    //       resolver: state.resolver,
    //       context: context,
    //     );

    //     nav.pushReplacementNamed('mainmenu');
    //   },
    // );




    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,

      //builder del Google_nav_bar
      // builder: (context, child) {
      //   return Directionality(textDirection: TextDirection.ltr, child: child!);
      // },

      // theme: ThemeData(
      //   // This is the theme of your application.
      //   //
      //   // Try running your application with "flutter run". You'll see the
      //   // application has a blue toolbar. Then, without quitting the app, try
      //   // changing the primarySwatch below to Colors.green and then invoke
      //   // "hot reload" (press "r" in the console where you ran "flutter run",
      //   // or simply save your changes to "hot reload" in a Flutter IDE).
      //   // Notice that the counter didn't reset back to zero; the application
      //   // is not restarted.
      //   primarySwatch: Colors.orange,
      // ),
      theme: ThemeData(
        brightness: Brightness.light,
        visualDensity: VisualDensity.standard,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(style: buttonStyle),
        textButtonTheme: TextButtonThemeData(style: buttonStyle),
        outlinedButtonTheme: OutlinedButtonThemeData(style: buttonStyle),
      ),
      initialRoute: initialRoute,
      routes: appRoutes,
      supportedLocales: [
        Locale('en', 'US'), // English, no country code
        // Locale('es', 'ES'), // Spanish, no country code
      ],
      locale: const Locale('es'),
      localizationsDelegates: [
        FirebaseUILocalizations.withDefaultOverrides(const LabelOverrides()),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        FirebaseUILocalizations.delegate,
      ],

      //home: const MyHomePage(title: 'Gigi Firebase Home Page'),
    );
  }
}

