import 'package:flutter/material.dart';

class Doctor with ChangeNotifier {
  String idD;
  String nameD;
  String eduD;
  String expD;
  String numD;
  String adressD;
  String? creatorId;
  bool verified = false;

  Doctor({
    required this.idD,
    required this.nameD,
    required this.eduD,
    required this.expD,
    required this.numD,
    required this.adressD,
    required this.creatorId,
    required this.verified,
  });
}
