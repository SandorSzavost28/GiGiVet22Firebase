import 'package:flutter/material.dart';
import 'package:gigivet22firebase/models/models.dart';

// import 'widgets.dart';



//TARJETA DE MASCOTA

class PetCard extends StatelessWidget {
  
  //propiedad
  final Pet pet;

  const PetCard({
    super.key, 
    required this.pet

  });

  
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: EdgeInsets.only(top: 30, bottom: 50),
        width: double.infinity,
        height: 350,
        //color: Colors.red,
        decoration: _cardBorders(),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            // IMAGEN DE LA TARJETA
            _BackgroundImage( pet.petPicture ),
            
            // DETALLE INFERIOR IZQUIERDA
            _PetDetails1(
              petName: pet.petName,
              petId: pet.id!, //si tiene id es que se esta mostrando
              ownerId: pet.ownerId,
            ),
            
            // DETALLE SUPERIOR DERERCHA
            Positioned(
              top: 0,
              right: 0,
              child: _PetDetalis2(
                petSpecies: pet.petSpecies,
              )
            ),


            //DETALLE DE ESTADO SUPERIOR IZQUIERDA
            //(ok, alerta, baja, perdido, )
            //TODO: Mostrar de manera condicional

            //si petActive = true
            if( pet.petActive)
              Positioned(
                top: 0,
                left: 0,
                child: _PetStateDetalis()
              ),

          ],
        )
        ,
      ),
    );
  }

  BoxDecoration _cardBorders() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(25),
    boxShadow: const [
      BoxShadow(
        color: Colors.black54,
        offset: Offset(0, 5),
        blurRadius: 10,

      ),

    ]
  );
}

const heightDetails = 80.0;

class _PetStateDetalis extends StatelessWidget {
  // const _PetStateDetalis({
  //   Key? key,
  // }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.8,
      child: Container(
        width: 100,
        height: heightDetails,
        decoration: BoxDecoration(
          color: Colors.yellow[800],
          borderRadius: BorderRadius.only(topLeft: Radius.circular(25), bottomRight: Radius.circular(25))
        ),
        alignment: Alignment.center,
        child: FittedBox(
          fit: BoxFit.contain, //también jaló con .fill
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Text('Activo', style: TextStyle(color: Colors.white, fontSize: 20),),
                //Icon(Icons.pets, color: Colors.white, size: 30,)
              ],
            )
          ),
        ),
      ),
    );
  }
}

class _PetDetalis2 extends StatelessWidget {
  // const _PetDetalis2({
  //   Key? key,
  // }) : super(key: key);

  final String petSpecies;

  const _PetDetalis2({
    super.key, 
    required this.petSpecies
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.8,
      child: Container(
        width: 100,
        height: heightDetails,
        decoration: const BoxDecoration(
          color: Colors.indigo,
          borderRadius: BorderRadius.only(topRight: Radius.circular(25), bottomLeft: Radius.circular(25))
        ),
        alignment: Alignment.center,
        child: FittedBox(
          fit: BoxFit.contain, //también jaló con .fill
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                
                Text(
                  petSpecies, 
                  style: const TextStyle(color: Colors.white, fontSize: 17),
                ),
                SizedBox(height: 3,),
                
                //TODO: Mostrar de manera condicional de acuerdo a la raza
                Icon(Icons.pets, color: Colors.white, size: 20,)
    
              ],
            )
          ),
        ),
      ),
    );
  }
}

class _PetDetails1 extends StatelessWidget {

  final String petName;
  final String petId;
  final String ownerId;

  //argumentos por posicion
  const _PetDetails1({
    //super.key, 
    required this.petName, 
    required this.petId, 
    required this.ownerId
    
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.8,
      child: Padding(
        padding: EdgeInsets.only(right: 70), //limite horizontal del detalleMascota
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          width: double.infinity,
          height: heightDetails,
          //color: Colors.indigo,
          decoration: _buildBoxDecoration(), //BoxDecoration() extraido en un método privado _buildBoxDecoration, para bordes redondeados de detalleMascota
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                petName, 
                style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                
              ),
              Text(
                'petID: ${petId}', 
                style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.normal),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                'ownerId :${ownerId}', 
                style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),


            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => const BoxDecoration(
    //propiedades
    color: Colors.indigo,
    borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(25),
      topRight: Radius.circular(25)
    )

  );
}

class _BackgroundImage extends StatelessWidget {
  //url de la imagen
  final String? url;

  //argumento porposicion
  const _BackgroundImage(
    //{
    //super.key, 
    this.url
  //}
  );

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Container(
        width: double.infinity,
        height: 400,
        color: Colors.blue,
        child: url == null  //uso de ternario
        ? const Image(
            image: AssetImage('assets/no-image.png'),
            fit: BoxFit.cover,
          )
        : FadeInImage(

          //TODO: fix produyctos sin imagen

          placeholder: AssetImage('assets/jar-loading.gif'), 
          image: NetworkImage( url! ),
          //image: AssetImage('assets/f6f6f6.png'),
          fit: BoxFit.cover, //extiende la imagen para que cubra
          
        ),
      ),
    );
  }




}