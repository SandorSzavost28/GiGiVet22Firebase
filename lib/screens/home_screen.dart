import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final auth = FirebaseAuth.instance;

    return Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Home Screen GIGI22 Firebase'),
            SizedBox(height: 20,),
            Text('Bienvenido: ${auth.currentUser!.displayName}'),

          ],
        ),
     );
  }
}