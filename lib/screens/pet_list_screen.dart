import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import 'package:gigivet22firebase/screens/all_screens.dart';
import 'package:gigivet22firebase/services/services.dart';
import 'package:gigivet22firebase/models/models.dart';
import 'package:gigivet22firebase/widgets/widgets.dart';



// import 'package:gigivet22_1_flutterapp/widgets/widgets.dart';

// import 'package:gigivet22_1_flutterapp/pages/all_pages.dart';
// import 'package:gigivet22_1_flutterapp/services/services.dart';
// import 'package:gigivet22_1_flutterapp/models/models.dart';

//PetsPage
class PetListScreen extends StatelessWidget {
  //const PetsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    final user = FirebaseAuth.instance.currentUser!;

    final petsService = Provider.of<PetsService>(context);

    // TODO: llamar correctamente load pets despues de iniciar sesion
    // petsService.loadPets(user.uid);
    // PetsService().loadPets(user.uid);

    // final base = FirebaseDatabase.instance.app;
    // print(base);

    

    const pageTitle = 'PETS: ';


    //Si esta grabando regresara la pagina Loading
    if ( petsService.isLoading ) return LoadingScreen();

    

    return  Scaffold(

      backgroundColor: Colors.amberAccent,
      
      // appBar: AppBar(
      //   toolbarHeight: 90,
      //   elevation: 5,
      //   centerTitle: true,
      //   title: Column(
      //     children: [
      //       Text( pageTitle ),
      //       Text( user.email! ),
      //       Text( 
      //         'ID: ${user.uid}', 
      //         style: TextStyle(fontSize: 18, color: Colors.black),
      //       ),

    
      //     ],
      //   ),
      //   backgroundColor: Colors.amber,
      // ),
            
      body: ListView.builder(
        //listviewbuilder para mantener pocos elementos en memoria y no saturar, es mas eficiente que un listview normal
        itemCount: petsService.pets.length, //no va a pasar de 10 elementos // asignamos la longitud de acuerdo a la cantidad de elementos
        
        itemBuilder: (BuildContext context, int index) => GestureDetector(

          child: PetCard(pet: petsService.pets[index],), //asignamos la propiedad de acuerdo al contenido del petService.pets
          onTap: () {
            //asignamos el Pet selected, pero para romper la referencia al elemento del listado original. lalmaos .copy, y puedo modificar lo que quiera sin editar el original
            petsService.selectedPet = petsService.pets[index].copy();
            //llamada a petedit
            Navigator.pushNamed(context, 'petedit');
          } ,
        ),
        //scrollDirection: Axis.horizontal,
      ),
      

      //Boton para Agregar
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 60.0),
        child: FloatingActionButton(
          backgroundColor: Colors.indigoAccent,
          //TODO: CAMBIAR POSICION MAS ARRIBA PARA EXTENER EL SCAFFOLD
          child: const Icon(
            Icons.add,
            //size: 30,
          ),
          onPressed: (){
    
            //creamos producto (vacio) antes de entrar, y asuignamos a petSelected
            petsService.selectedPet = Pet(
              petActive: true, 
              petBirthday: DateTime.now(), 
              petGender: 'Female', 
              petName: '', 
              petSpecies: 'Dog',
              ownerId: user.uid,
              petColor: '',
              petWeight: 0.0,
              
            );
    
            //Agregar Pet
            Navigator.pushNamed(context, 'petedit');
    
    
    
    
          },
          
          
        ),
      ),
     );
  }
  
}