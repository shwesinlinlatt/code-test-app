import 'package:dio/dio.dart';
import 'package:union/database/union.dart';
import 'package:union/models/patient.dart';

import 'package:union/network/PatientService.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class PatientProvider with ChangeNotifier {
  List<PatientModel> patients = [];
  PatientModel? patient;

  String? errorMessage;

  Future<void> syncData() async {
    try {
      List<PatientModel> data = await UnionDB.notSyncPatients();

      //get local patient
      var jsonPatient = [];
      if (data.isNotEmpty) {
        for (var i = 0; i < data.length; i++) {
          var patient = {
            "name": data[i].name,
            "age": data[i].age,
            'address': data[i].address,
            'sex': data[i].sex,
            'is_VOT': data[i].is_VOT,
            'treatment_start_date': data[i].treatment_start_date,
          };

          jsonPatient.add(patient);
        }
      }

      Response? result = await PatientService.syncData({"patients" : jsonPatient});
      if (result!.statusCode == 200) {
        errorMessage = null;
        var data = result.data['data'];
        await UnionDB.deleteAllPatients();
        if (data.isNotEmpty) {
          await UnionDB.batchInsertPatients(data);
        }
      } else if (result.statusCode == 401) {
        errorMessage = result.data['data']['message'];
      } else {
        errorMessage = 'Something was wrong!';
      }
    } catch (e) {
      print("error $e");
    }

    notifyListeners();
  }

  static PatientModel _getObject(Map<String, dynamic> data) {
    return PatientModel(
      id: data["id"],
      name: data["name"],
      age: data["age"].runtimeType == String
          ? int.parse(data["age"])
          : data["age"],
      sex: data["sex"],
      address: data["address"],
      is_VOT: data["is_VOT"],
      treatment_start_date: data["treatment_start_date"],
    );
  }

  Future<void> getPatients({String queryString = ''}) async {
    Response? result = await PatientService.getPatients(queryString);
    if (result!.statusCode == 200) {
      errorMessage = null;
      List<PatientModel> patientList = [];
      var data = result.data['data'];

      if (data.isNotEmpty) {
        for (Map<String, dynamic> element in data) {
          patientList.add(_getObject(element));
        }
      }
      patients = patientList;
    } else if (result.statusCode == 401) {
      errorMessage = result.data['data']['message'];
    } else {
      errorMessage = 'Something was wrong!';
    }
    notifyListeners();
  }
}
