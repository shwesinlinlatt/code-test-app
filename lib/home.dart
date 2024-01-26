import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:union/login.dart';
import 'package:union/providers/auth_provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Union'),
        backgroundColor: Colors.purpleAccent,
        actions: [
          TextButton(
            onPressed: () async {
              await Provider.of<AuthProvider>(context, listen: false).logout();
              Navigator.of(context).pop();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
            child: Text(
              "Logout ",
              style: const TextStyle(color: Colors.white, fontSize: 11),
            ),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          // Navigate to another route on card tap
          Navigator.pushNamed(
            context,
            '/patients',
          );
        },
        child: Card(
          margin: EdgeInsets.all(16.0),
          child: ListTile(
            title: Text('Go to patients page'),
            trailing: Icon(Icons.forward),
          ),
        ),
      ),
    );
  }
}
