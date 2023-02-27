import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:gigivet22firebase/models/models.dart';

class PetsService extends ChangeNotifier{

  //url para conectarme a nmi db
  final String _baseUrl = 'gigivet22firebase-default-rtdb.firebaseio.com';
  // final String _baseUrl = 'gigivet22-1-flutter-project-default-rtdb.firebaseio.com';
  // https://gigivet22firebase-default-rtdb.firebaseio.com

  //lista de elementos a mostrar en mi el Product Service a mostrar en pantalla
  List<Pet> pets = [];

  //propiedad tipo Pet, Pet seleccionada para cargar los datos en edit
  //Pet? selectedPet;
  late Pet? selectedPet;

  //propiedad para imagepicker
  File? newPictureFile;

  //propiedad para saber si esta guardando
  bool isLoading = true;

  //propiedad para saber si esta salvandoocreando
  bool isSaving = false;

  //propiedad para saber si esta borrando
  bool isDeleting = false;

  // instancia de user.id
  // final user = FirebaseAuth.instance.currentUser!;

    
  //instanca de PetService , Constructor
  PetsService(String uid){

    //this.clearPet();

    //cuando se crea la primera instancia llamo a loadPets
    this.loadPets(uid);
    // this.loadPets(user.uid);

  }

  //limpia el contenido de lista pets, no sellama en ningun lado
  void clearPets() async {
    pets.clear();  
    print('Cantidad de pets (pet_service.dart): ${pets.length}');
  }

  //al llamar a la instancia, disparare el metodo para gargar las mascotas pets y regresar[a una lista de Pets]
  Future<List<Pet>> loadPets(String userid) async{

    //para saber el usuario firmado, anterior, incorrecto
    // final user = FirebaseAuth.instance.currentUser!;
    
    // recibimos el usuario firmado correctamente
    final String userid1 = userid ;

    final String _baseUrl = 'gigivet22firebase-default-rtdb.firebaseio.com';
    // final String _baseUrl = 'gigivet22-1-flutter-project-default-rtdb.firebaseio.com';

    //notificamos que esta grabando 
    this.isLoading = true;
    notifyListeners();

   //print('XXX INICIO Composicion de la RUTA XXX');

    //composici[on de la url
    final url = Uri.https( 
      _baseUrl , 
      'pets_rtdb.json',
      {'orderBy':'"pet_ownwerId"','equalTo': '"${userid1}"'}
      // {'orderBy':'"pet_ownwerId"','equalTo': '"${user.uid}"'}
      

    );
    

    //print('URL XXX de busqueda (loadPets): $url');

    //respuesta  a la peticion
    final resp = await http.get( url );

    //print('resp.body pets_service.dart ${resp.body}');

    //convertir la resp.body en un mapa de nuestras mascotas, decodificado json
    final Map<String, dynamic> petsMap = json.decode(resp.body) ;

    //print en consola
    //print( 'pets map: (pets_service.dart) ${petsMap}' );

    //necesitamos un listado

    //barrer las llaves
    petsMap.forEach((key, value) {

      final tempPet = Pet.fromMap( value );

      //asignamos el id de acuerdo ek key
      tempPet.id = key;

      //almacenar en el listado de pets
      this.pets.add(tempPet);

        
     });

    this.isLoading = false;
    notifyListeners();
    //


    //imprime Nombde del primer Pet de la lista
    //print( this.pets[ 0 ].petName );
    return this.pets;
    
    
  }

  //metodo para guardar o crear un Pet
  Future saveOrCreatePet(Pet pet) async{

    isSaving = true;
    notifyListeners();

    //confirmar id de producto, si tengo unom va a actualizar, sino tengo es un Pet nuevo

    if ( pet.id == null ) {
      //crear
      //debemos generar ID e imagen

      await this.createPet( pet );
      

    } else {
      //actualizar
      await this.updatePet( pet );

    }
    
    isSaving = false;
    notifyListeners();

  }


  Future<String> updatePet( Pet pet) async{

    //peticion al backend
    //composici[on de la url
    final url = Uri.https( _baseUrl , 'pets_rtdb/${ pet.id }.json');

    //respuesta  a la peticion PUT ACTUALIZAR con el pet nuevo en un json
    final resp = await http.put( url, body: pet.toJson() );

    //variable respuesta
    final decodedData = resp.body;

    //imprime respuesta de Firebase
    //print(decodedData);

    //actualizar listado de Pets
    //regresa el id del pet recibido
    final index = this.pets.indexWhere((element) => element.id == pet.id );
    //actualizar el elemento actualizado
    this.pets[index] = pet;




    //regresar el id
    return pet.id! ;

  }

  //copíamos el update y generamos createPet
  Future<String> createPet( Pet pet) async{

    //recibimos un pet sin id

    //peticion al backend
    //composici[on de la url
    final url = Uri.https( _baseUrl , 'pets_rtdb.json') ;

    //respuesta  a la peticion POST POSTEAR indo CREAR con el pet nuevo en un json
    final resp = await http.post( url, body: pet.toJson() );

    //variable respuesta, decodificar a un mapa
    final decodedData = json.decode( resp.body );

    //imprime respuesta de Firebase, que es un json
    //print( decodedData );
    print( 'decodedData (pets_service.dart) ${decodedData}' );
    
    //en name firebase retorna el ID que necesitamos
    pet.id = decodedData['name'];
   
    //agregamoe a la lista pets el pet completo
    this.pets.add(pet);

    //regresar el id
    return pet.id! ;
    //return '';

  }

//TODO: Validar DELETE
  void deletePet( Pet pet) async{

    isDeleting = true;
    notifyListeners();

    //peticion al backend
    //composici[on de la url
    final url = Uri.https( _baseUrl , 'pets_rtdb/${ pet.id }.json');

    //respuesta  a la peticion POST POSTEAR indo CREAR con el pet nuevo en un json
    final resp = await http.delete( url );
   
        //eliminar a la lista pets el pet completo
    this.pets.removeWhere(((element) => element.id == pet.id));
 

    isDeleting = false;
    notifyListeners();
  }

 

  //preview de la vista , revibe un strin path
  void updateSelectedPetImage( String path){
    

    this.selectedPet!.petPicture = path;

    //crea el archivo
    this.newPictureFile = File.fromUri( Uri(path: path));

    notifyListeners();

  }

  Future<String?> uploadImage() async {

    //asegurarnos que tenemos una imagen
    if( this.newPictureFile == null) return null;

    //inicio de salvando
    this.isSaving = true;

    //notificar que estamos salvando
    notifyListeners();
    
    //
    final url = Uri.parse('https://api.cloudinary.com/v1_1/dav4dev420h1gh/image/upload?upload_preset=n47cqvvy');

    //crear el request 
    final imageUploadRequest = http.MultipartRequest(
      //que tipo de request
      'POST',
      //uri
      url
    );

    //y aadjuntar el file
    final file = await http.MultipartFile.fromPath('file', newPictureFile!.path);

    //adjuntar archivo al request
    imageUploadRequest.files.add(file);

    //disparar peticion //informacion que vamos a esperar de la peticion
    final streamResponse = await imageUploadRequest.send();

    final resp = await http.Response.fromStream(streamResponse);

    if( resp.statusCode != 200 && resp.statusCode != 201 ) {

      print('algo salio mal');
      //error de cloudinary
      //print(resp.body);
      print('resp.bod (pets_service.dart) ${resp.body}');
      return null;
    } 

    //marcar que ya lo subi
    this.newPictureFile = null;

    final decodedData = json.decode( resp.body);

    return decodedData['secure_url'];

    print('resp.bod (pets_service.dart) ${resp.body}');

  }

}