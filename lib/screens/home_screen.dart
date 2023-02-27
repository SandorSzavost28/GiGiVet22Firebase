import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final auth = FirebaseAuth.instance;

    return Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Home Screen  Firebase'),
            const SizedBox(height: 20,),
            Text('Display Name: ${auth.currentUser!.displayName}'),
            Text('uid: ${auth.currentUser!.uid}'),
            Text('email: ${auth.currentUser!.email}'),
            Text('emailVerified: ${auth.currentUser!.emailVerified}'),
            // Text('Bienvenido: ${auth.currentUser!.providerData}'),
            // Text('Bienvenido: ${auth.currentUser!.emailVerified}'),


          ],
        ),
     );
  }
}