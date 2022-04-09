import 'package:flutter/material.dart';

class Patient with ChangeNotifier {
  String idP;
  String nameP;
  String numP;
  String? creatorId;
  String? doctorId;
  bool? verD;
  String? report = 'Positive';
  Patient({
    required this.idP,
    required this.nameP,
    required this.numP,
    required this.creatorId,
    this.doctorId,
    this.verD,
    this.report,
  });
}
