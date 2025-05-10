import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/authentications/register_screen.dart';
import 'package:flutter_application_2/services/auth_service.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  // Variabel input
  String _email = '';
  String _password = '';
  String _error = '';

  Future<void> handleSignIn() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Proses login, autentikasi, dll
      dynamic result = await _auth.signInWithEmail(_email, _password);

      if (result == null) {
        print(_error);
      }
    }
  }

  Future<void> handleAnon() async {
      // Proses login, autentikasi, dll
      dynamic result = await _auth.signInAnon();

      if (result == null) {
        print(_error);
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Input Email
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email wajib diisi';
                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Format email tidak valid';
                  }
                  return null;
                },
                onSaved: (value) => _email = value!,
              ),

              // Input Password
              TextFormField(
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Password wajib diisi'
                            : null,
                onSaved: (value) => _password = value!,
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: handleSignIn,
                child: const Text('Login'),
              ),
              ElevatedButton(
                onPressed: handleAnon,
                child: const Text('Login Anon'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const RegisterScreen()),
                  );
                },
                child: const Text("Don't have an account? Register"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
