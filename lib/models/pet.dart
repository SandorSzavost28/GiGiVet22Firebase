// To parse this JSON data, do
//
//     final pet = petFromMap(jsonString);

import 'dart:convert';

class Pet {
    Pet({
        required this.petActive,
        required this.petBirthday,
        required this.petGender,
        required this.petName,
        this.petPicture, //Uso de Campos no obligatorios
        required this.petSpecies,
        this.id,
        required this.ownerId,
        required this.petColor,
        required this.petWeight,
    });

    bool petActive;
    DateTime petBirthday;
    String petGender;
    String petName;
    String? petPicture; //Uso de Campos no obligatorios
    String petSpecies;
    String? id;
    String ownerId;
    String petColor;
    double petWeight;
    
    factory Pet.fromJson(String str) => Pet.fromMap(json.decode(str));
    //recibir un String y generar una instancia de Pet

    String toJson() => json.encode(toMap());
    //para enviar al servidor el json string

    factory Pet.fromMap(Map<String, dynamic> json) => Pet(
        petActive: json["pet_active"],
        petBirthday: DateTime.parse(json["pet_birthday"]),
        petGender: json["pet_gender"],
        petName: json["pet_name"],
        petPicture: json["pet_picture"],
        petSpecies: json["pet_species"],
        ownerId: json["pet_ownwerId"],
        petColor: json["pet_color"],
        petWeight: json["pet_weight"].toDouble(),
    );

    Map<String, dynamic> toMap() => {
        "pet_active": petActive,
        "pet_birthday": petBirthday.toIso8601String(),
        "pet_gender": petGender,
        "pet_name": petName,
        "pet_picture": petPicture,
        "pet_species": petSpecies,
        "pet_ownwerId": ownerId,
        "pet_color": petColor,
        "pet_weight": petWeight,
    };

    //Método para crear una copia de si mismo
    Pet copy() => Pet(
      petActive: petActive, 
      petBirthday: petBirthday, 
      petGender: petGender, 
      petName: petName, 
      petSpecies: petSpecies,
      petPicture: petPicture,
      id: id,
      ownerId: ownerId,
      petColor: petColor,
      petWeight: petWeight,

    );
}
