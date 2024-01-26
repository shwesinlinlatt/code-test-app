import 'package:union/database/union.dart';
import 'package:union/models/patient.dart';
import 'package:union/utils/customDateInput.dart';
import 'package:union/utils/customSubmitButton.dart';
import 'package:union/utils/customTextInput.dart';
import 'package:union/utils/customDropDown.dart';
import 'package:union/utils/custom_text.dart';
import 'package:union/utils/toast.dart';
import 'package:flutter/material.dart';

class NewPatientInputForm extends StatefulWidget {
  const NewPatientInputForm({super.key});
  @override
  State<NewPatientInputForm> createState() => _NewPatientInputFormState();
}

class _NewPatientInputFormState extends State<NewPatientInputForm> {
  String? selectedIsVOT;
  String? selectedSex;

  final TextEditingController treatmentStartDateController =
      TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    void submit() async {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        try {
          var age = int.parse(ageController.text);
          await UnionDB.instance.createPatient(PatientModel(
              name: nameController.text,
              is_VOT: selectedIsVOT as String,
              treatment_start_date: treatmentStartDateController.text,
              sex: selectedSex as String,
              address: addressController.text,
              age: age,
              isSync: 0));



          Navigator.of(context).pop();

          Navigator.pushNamed(context, '/patients');

          showToast(context, 'Success');
        } catch (error) {
          print(error);
         
          showToast(context, 'Please try again');
        }
      } else {
        return;
      }
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'New Patient',
            style: const TextStyle(color: Colors.white, fontSize: 15),
          ),
          backgroundColor: Colors.purpleAccent,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 13.0, vertical: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        customDropDown('VOT Yes/No', dropDownYesOrNoOptions,
                            selectedIsVOT, 'VOT Yes/No', ((value) {
                          setState(() {
                            selectedIsVOT = value;
                          });
                        })),
                        const SizedBox(height: 20),
                        customDateInputWithValidation(
                            treatmentStartDateController,
                            'Treatment Start Date',
                            context),
                        const SizedBox(
                          height: 20,
                        ),
                        customTextInput(
                            nameController, 'Name', 'text', context),
                        const SizedBox(
                          height: 10,
                        ),
                        customDropDown(
                            'Gender', sexOptions, selectedSex, 'Gender',
                            ((value) {
                          setState(() {
                            selectedSex = value;
                          });
                        })),
                        const SizedBox(
                          height: 20,
                        ),
                        customTextInputWithValidator(
                            ageController, 'Age', 'number', (value) {
                          if (value == null || value.isEmpty) {
                            return CustomText.getText(
                                context, 'Age is required');
                          } else if (int.parse(value) < 1 ||
                              int.parse(value) > 120) {
                            return CustomText.getText(context, 'Age is wrong');
                          }
                          return null;
                        }, context),
                        const SizedBox(
                          height: 10,
                        ),
                        customTextInput(
                            addressController, 'Address', 'textarea', context),
                        const SizedBox(
                          height: 10,
                        ),
                        customSubmitButton('Save', submit),
                        const SizedBox(
                          height: 20,
                        ),
                      ]),
                ))));
  }
}

const TextStyle style = TextStyle(fontSize: 14);

List<DropdownMenuItem<String>> get dropDownYesOrNoOptions {
  List<DropdownMenuItem<String>> yesOrNoOptions = [
    DropdownMenuItem(value: "Yes", child: Text(style: style, "Yes")),
    DropdownMenuItem(value: "No", child: Text(style: style, "No")),
  ];
  return yesOrNoOptions;
}

List<DropdownMenuItem<String>> get sexOptions {
  List<DropdownMenuItem<String>> sexOptions = [
    DropdownMenuItem(value: "Male", child: Text(style: style, "Male")),
    DropdownMenuItem(value: "Female", child: Text(style: style, "Female")),
  ];
  return sexOptions;
}
