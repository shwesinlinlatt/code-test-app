import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:union/database/union.dart';
import 'package:union/models/patient.dart';
import 'package:union/newPatient/inputForm.dart';
import 'package:union/providers/patient_provider.dart';
import 'package:union/utils/toast.dart';
import 'package:union/widgets/progress_hub.dart';
import 'package:union/widgets/slideupTransition.dart';

class Patients extends StatefulWidget {
  const Patients({super.key});

  @override
  _PatientsState createState() =>
      _PatientsState();
}

class _PatientsState
    extends State<Patients> {
  bool _isInit = false;
  bool _isLoading = false;
  List<PatientModel> patients = [];

  Future<void> loadData() async {
    setState(() {
      _isLoading = true;
    });

    patients = await UnionDB.readAllPatients();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void didChangeDependencies() {
    if (!_isInit) {
      loadData();
      _isInit = true;
    }
    super.didChangeDependencies();
  }

  Future<void> _sync() async {
    try {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<PatientProvider>(context, listen: false).syncData();
      await UnionDB.readAllPatients();
      return showToast(context, 'Success');
    } catch (error) {
      print(error);
      
      return showToast(context, 'Please try again');
    } finally {
       setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Patients",
            style: const TextStyle(fontSize: 12),
          ),
          backgroundColor: Colors.purpleAccent,
          actions: [
            TextButton(
              onPressed: _sync,
              child: Text(
                "Sync ",
                style: const TextStyle(color: Colors.white, fontSize: 11),
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.add,
                color: Colors.white,
                size: 25.0,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewPatientInputForm(),
                  ),
                );
              },
            ),
          ],
        ),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                onRefresh: loadData,
                child: ProgressHUD(
                    inAsyncCall: _isLoading,
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: ListView.builder(
                              padding: const EdgeInsets.all(8),
                              itemCount: patients?.length,
                              itemBuilder: (BuildContext context, int index) {
                                PatientModel patientModel = patients![index];
                                return InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, 'patient_detail',
                                        arguments: {'data': patients![index]});
                                  },
                                  child: Card(
                                      color: Colors.white,
                                      elevation: 2,
                                      child: ListTile(
                                          leading: const Icon(Icons.person),
                                          subtitle: Text(
                                            'age - ${patientModel.age.toString()}',
                                            style: TextStyle(
                                                color: Colors.green,
                                                fontSize: 15),
                                          ),
                                          title: Text(
                                              'Name - ${patientModel.name}'))),
                                );
                              }),
                        )
                      ],
                    ))));
  }
}
