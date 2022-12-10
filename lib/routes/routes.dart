import 'package:flutter/material.dart';
import 'package:gigivet22firebase/screens/all_screens.dart';


final Map<String, Widget Function(BuildContext)> appRoutes = {
  
  'email-link-sign-in'  : ( _ ) => EmailLinkScreen(),
  'forgot-password'     : ( _ ) => ForgotPassScreen(),
  'login'               : ( _ ) => LoginScreen(),
  'mainmenu'            : ( _ ) => MainMenuScreen(),
  'phone'               : ( _ ) => PhoneInputScreenGG(),
  'profile_ui'          : ( _ ) => Profile1_Screen(),
  'sms'                 : ( _ ) => EmailLinkScreen(),
  'verify-email'        : ( _ ) => VerifyEmailScreen(),







  
  

  
  
};