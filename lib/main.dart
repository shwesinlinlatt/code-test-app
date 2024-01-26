import 'package:union/home.dart';
import 'package:union/login.dart';
import 'package:union/patient_detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:union/patients.dart';
import 'package:union/providers/auth_provider.dart';
import 'package:union/providers/patient_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(),
        ),
        
        ChangeNotifierProvider<PatientProvider>(
          create: (_) => PatientProvider(),
        ),
        
      ],
    child:  MaterialApp(
      title: 'Union',
      initialRoute: '/login',
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => const LoginScreen(),
        '/home': (BuildContext context) =>  Home(),
        '/patients': (BuildContext context) => const Patients(),
        '/patient_detail': (BuildContext context) => PatientDetailScreen(),
      },
    ),);
  }
}
