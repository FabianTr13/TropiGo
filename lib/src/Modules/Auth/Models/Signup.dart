import 'package:flutter/material.dart';

class Signup {
  final String uID;
  final String email;
  final String name;
  final String phoneNumber;
  final String colony;
  final String cityId;
  final String cityName;
  final String sexo;
  final String birthday;
  final String password;
  final String rePassword;

  //update
  final String newName;
  final String newPhoneNumber;
  final String newSexo;
  final String newBirthDay;

  Signup(
      {this.uID,
      this.email,
      this.name,
      this.phoneNumber,
      @required this.colony,
      this.cityId,
      this.cityName,
      this.sexo,
      this.birthday,
      this.password,
      this.rePassword,
      this.newName,
      this.newPhoneNumber,
      this.newSexo,
      this.newBirthDay});

  Map<String, dynamic> singUptoJson() => {
        'email': this.email,
        'name': this.name,
        'phone': this.phoneNumber,
        'colony': this.colony,
        'cityId': this.cityId,
        'cityName': this.cityName,
        'sexo': this.sexo,
        'fechaNacimiento': this.birthday,
        'provider': "firebase",
        'userInDelivering': false
      };

  Map<String, dynamic> upDatetoJson() => {
        'email': this.email,
        'name': this.newName,
        'phone': this.newPhoneNumber,
        'colony': this.colony,
        'cityId': this.cityId,
        'cityName': this.cityName,
        'sexo': this.newSexo,
        'fechaNacimiento': this.newBirthDay,
        'provider': "firebase",
        'userInDelivering': false
      };
}
