import 'package:flutter/material.dart';
// import 'package:gigivet22_1_flutterapp/services/services.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatelessWidget {

  final pageTitle = 'Loading: ';

  
  @override
  Widget build(BuildContext context) {

    // final pet = Provider.of<PetsService>(context);

    // VetcontsultsService().loadVetconsults(pet.selectedPet!.id.toString());

    // final vetconsultsService  = Provider.of<VetcontsultsService>(context);

    //if (vetconsultsService.isLoading) Navigator.pushNamed(context, 'vetconsutl_list');

    return Scaffold(
      
      appBar: AppBar(
        elevation: 5,
        centerTitle: true,
        title: Text(pageTitle),
        backgroundColor: Colors.amber,
      ),
      backgroundColor: Colors.amberAccent,
      body: const Center(
        
        child: CircularProgressIndicator(
          color: Colors.indigo,
        ),
     ),
   );
  }
}