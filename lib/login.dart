
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:union/home.dart';
import 'package:union/models/volunteer.dart';
import 'package:union/providers/auth_provider.dart';
import 'package:union/utils/toast.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isObscureText = true;
  bool isLoading = false;

  @override
  void dispose() {
    _codeController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);
    final VolunteerModel? volunteerModel =
        authProvider.volunteerModel;

    return Builder(builder: (BuildContext context) {
      if (volunteerModel != null) {
        return Home();
      } else {
        return SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 150, bottom: 150, left: 20, right: 20),
                child: Column(children: [
                 
                  const Text(
                    "Union",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.purpleAccent),
                  ),
                  const Center(
                    child: SizedBox(
                      width: 200,
                      child: Divider(
                        thickness: 1,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  // Lottie.asset("assets/lottiefiles/pills.json", width: 250, height: 250),
                  Container(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextFormField(
                            controller: _codeController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelText: "Name",
                              prefixIcon: const Icon(Icons.code),
                            ),
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Name is required";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelText: "Password",
                              prefixIcon: const Icon(Icons.lock_outline),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isObscureText = !isObscureText;
                                  });
                                },
                                child: Icon(
                                  isObscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.purpleAccent,
                                ),
                              ),
                            ),
                            obscureText: isObscureText,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Your Password is required';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          ConstrainedBox(
                            constraints: BoxConstraints.tightFor(
                                width: MediaQuery.of(context).size.width),
                            child: ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    await context.read<AuthProvider>().login({
                                      'name': _codeController.text,
                                      'password': _passwordController.text,
                                    });

                                    if (authProvider.errorMessage != null) {
                                      if (!mounted) return;
                                      showToast(context,
                                          authProvider.errorMessage ?? '');
                                    } else {
                                      if (!mounted) return;
                                      Navigator.pushReplacementNamed(
                                          context, '/home');
                                    }
                                    setState(() {
                                      isLoading = false;
                                    });
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.purple,
                                    foregroundColor: Colors.white,
                                    maximumSize: const Size(147, 50),
                                    minimumSize: const Size(147, 50),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                child: isLoading
                                    ? const Text('Loading')
                                    : const Text('Login')),
                          )
                        ],
                      ),
                    ),
                  )
                ]),
              ),
            ),
          ),
        );
      }
    });
  }
}
