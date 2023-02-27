import 'package:flutter/material.dart';
import 'package:gigivet22firebase/screens/all_screens.dart';


final Map<String, Widget Function(BuildContext)> appRoutes = {
  
  'email-link-sign-in'  : ( _ ) => EmailLinkScreen(),
  'forgot-password'     : ( _ ) => ForgotPassScreen(),
  'phone'               : ( _ ) => PhoneInputScreenGG(),
  'sms'                 : ( _ ) => EmailLinkScreen(),
  'verify-email'        : ( _ ) => VerifyEmailScreen(),
  
  'login'               : ( _ ) => LoginScreen(),
  'mainmenu'            : ( _ ) => MainMenuScreen(),

  'home'                : ( _ ) => HomeScreen(),
  'pet_list'            : ( _ ) => PetListScreen(),
  'search1'             : ( _ ) => Search_1_Screen(),
  'profile_ui'          : ( _ ) => Profile1_Screen(),
  
  'test1'               : ( _ ) => Test1Screen(),











  
  

  
  
};