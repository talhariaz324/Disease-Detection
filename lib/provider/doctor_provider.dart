import 'dart:convert';

import 'package:disease_detection/models/doctor_model.dart';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;

import '../models/patient_model.dart';

class Doctors with ChangeNotifier {
  final String? authToken;
  final String? userId;
  // ignore: prefer_typing_uninitialized_variables
  var id;
  Doctors(this.authToken, this.userId, this._doctors);
  List<Doctor> _doctors = [];

  List<Doctor> get doctors {
    return [..._doctors];
  }

  List<Patient> _toDoctor = [];
  List<Patient> get toDoctor {
    return [..._toDoctor];
  }

  dynamic addDoctors(Doctor doctor) async {
    final url = Uri.parse(
        'https://autism-disease-detection-default-rtdb.firebaseio.com/Doctors.json');
    try {
      final value = await http.post(url,
          body: json.encode({
            'nameD': doctor.nameD,
            'eduD': doctor.eduD,
            'expD': doctor.expD,
            'numD': doctor.numD,
            'adressD': doctor.adressD,
            'creatorId': userId,
            'verified': doctor.verified,
          }));

      // print(json.decode(value.body));
      id = json.decode(value.body)['name'];
      final doctorsIn = Doctor(
        idD: json.decode(value.body)['name'],
        nameD: doctor.nameD,
        eduD: doctor.eduD,
        expD: doctor.expD,
        numD: doctor.numD,
        adressD: doctor.adressD,
        creatorId: userId,
        verified: doctor.verified,
      );
      _doctors.insert(0, doctorsIn);
      notifyListeners();
      return id;
      // .catchError((error) {
      //   print(error);
      //   throw error;
      // });
    } catch (error) {
      // print(error);
      rethrow;
    }
  }

  Future<void> fetchAndSetDoctor() async {
    final url = Uri.parse(
        'https://autism-disease-detection-default-rtdb.firebaseio.com/Doctors.json'); // collection name
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>?;
      if (extractedData == null) {
        return;
      }
      final List<Doctor> loadedData = [];
      extractedData.forEach((doctorId, doctorData) {
        loadedData.add(Doctor(
          idD: doctorId,
          nameD: doctorData['nameD'],
          eduD: doctorData['eduD'],
          expD: doctorData['expD'],
          numD: doctorData['numD'],
          adressD: doctorData['adressD'],
          creatorId: userId,
          verified: doctorData['verified'],
        ));

        _doctors = loadedData;
      });
    } catch (error) {
      rethrow;
    }
  }

  Future<void> fetchAndSetDoctortoP() async {
    final url = Uri.parse(
        'https://autism-disease-detection-default-rtdb.firebaseio.com/Doctors.json'); // collection name
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>?;
      if (extractedData == null) {
        return;
      }
      final List<Doctor> loadedData = [];
      extractedData.forEach((doctorId, doctorData) {
        loadedData.add(Doctor(
          idD: doctorId,
          nameD: doctorData['nameD'],
          eduD: doctorData['eduD'],
          expD: doctorData['expD'],
          numD: doctorData['numD'],
          adressD: doctorData['adressD'],
          creatorId: userId,
          verified: doctorData['verified'],
        ));

        _doctors =
            loadedData.where((element) => element.verified == true).toList();
      });
    } catch (error) {
      rethrow;
    }
  }

  Future addPtoD(Patient patient, String? idDoctor, bool ver,
      {String? report}) async {
    // P is patient and D is doctor.
    final url = Uri.parse(
        'https://autism-disease-detection-default-rtdb.firebaseio.com/D_Patients.json'); //  Ambiguity of auth token check it
    try {
      final value = await http.post(url,
          body: json.encode({
            'nameP': patient.nameP,
            'numP': patient.numP,
            'creatorId': patient.creatorId,
            'doctorId': idDoctor,
            'verified': ver,
            'report': report,
          }));

      // print(json.decode(value.body));
      final patientsIn = Patient(
        idP: json.decode(value.body)['name'],
        nameP: patient.nameP,
        numP: patient.numP,
        creatorId: patient.creatorId,
        doctorId: idDoctor,
        verD: ver,
        report: patient.report,
      );
      _toDoctor.insert(0, patientsIn);
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

  Future<void> showPtoD({String? myId}) async {
    final url = Uri.parse(
        'https://autism-disease-detection-default-rtdb.firebaseio.com/D_Patients.json'); // collection name
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
          doctorId: patientData['doctorId'],
          verD: patientData['verified'],
          report: patientData['report'],
        ));
        myId == null
            ? _toDoctor = loadedData
            : _toDoctor =
                loadedData.where((dId) => dId.doctorId == myId).toList();
        // _toDoctor = loadedData;
      });
    } catch (error) {
      rethrow;
    }
  }

  Future<void> verifyStatus(String id, bool newDocV) async {
    final docId = _doctors.indexWhere((doc) => doc.idD == id);
    if (docId >= 0) {
      try {
        final url = Uri.parse(
            'https://autism-disease-detection-default-rtdb.firebaseio.com/Doctors/$id.json');
        await http.patch(url,
            body: json.encode({
              'verified': newDocV,
            }));
      } catch (error) {
        // print(error);
        rethrow;
      }
      _doctors[docId].verified = newDocV;
      notifyListeners();
    }
  }
}
