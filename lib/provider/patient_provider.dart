import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../models/patient_model.dart';
import 'package:http/http.dart' as http;

class Patients with ChangeNotifier {
  final String? authToken;
  final String? userId;
  Patients(this.authToken, this.userId, this._patients);
  List<Patient> _patients = [];
  List<Patient> get patients {
    return [..._patients];
  }

  Future addPatients(Patient patient) async {
    final url = Uri.parse(
        'https://autism-disease-detection-default-rtdb.firebaseio.com/PATIENTS.json'); //  Ambiguity of auth token check it
    try {
      final value = await http.post(url,
          body: json.encode({
            'nameP': patient.nameP,
            'numP': patient.numP,
            'creatorId': userId,
            'report': 'Negitive',
          }));

      // print(json.decode(value.body));
      final patientsIn = Patient(
        idP: json.decode(value.body)['name'],
        nameP: patient.nameP,
        numP: patient.numP,
        creatorId: userId,
        report: 'Negitive',
      );
      _patients.insert(0, patientsIn);
      notifyListeners();

      // .catchError((error) {
      //   print(error);
      //   throw error;
      // });
    } catch (error) {
      // print(error);
      rethrow;
    }
  }

  Future<void> getAllPatients() async {
    final url = Uri.parse(
        'https://autism-disease-detection-default-rtdb.firebaseio.com/PATIENTS.json'); // collection name
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>?;
      if (extractedData == null) {
        return;
      }
      final List<Patient> loadedData = [];
      extractedData.forEach((patientId, patientData) {
        loadedData.add(Patient(
          idP: patientId,
          nameP: patientData['nameP'],
          numP: patientData['numP'],
          creatorId: patientData['creatorId'],
          report: patientData['report'],
        ));
        _patients = loadedData;
      });
    } catch (error) {
      rethrow;
    }
  }
}
