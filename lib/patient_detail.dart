import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:union/widgets/text_container.dart';

class PatientDetailScreen extends StatefulWidget {
  static String routeName = "/patient_detail";

  @override
  State<PatientDetailScreen> createState() => _PatientDetailScreenState();
}

class _PatientDetailScreenState extends State<PatientDetailScreen> {
  Widget build(BuildContext context) {
    Map arguments = ModalRoute.of(context)?.settings.arguments as Map;


    return Scaffold(
      appBar: AppBar(
        title: const Text("Patient Detail"),
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                width: 400,
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    TextContainer('Name', arguments['data']['name']),
                  TextContainer('Age', arguments['data']['age'].toString()),
                    TextContainer(
                        'Sex', arguments['data']['sex']),
                     TextContainer('Address', arguments['data']['address']),
                     //TextContainer('Address', arguments['data']['address']),
                     TextContainer(
                         'VOT Yes/No', arguments['data']['is_VOT']),
                    TextContainer('Treatment Start Date', arguments['data']['treatment_start_date']),
                   
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
