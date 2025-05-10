import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/home/wrapper.dart';
import 'package:flutter_application_2/services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  String _email = '';
  String _password = '';
  String _error = '';

  Future<void> handleRegister() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final register_data = {'name': _name, 'email': _email, 'password': _password};
      // Proses login, autentikasi, dll
      dynamic result = await _auth.registerWithEmail(register_data);

      if (result == null) {
        setState(() {
          _error = 'Gagal Register';
        });
      } else {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Wrapper()),
          (Route<dynamic> route) => false,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Nama
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nama'),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Nama wajib diisi'
                            : null,
                onSaved: (value) => _name = value!,
              ),
              // Email
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
              // Password
              TextFormField(
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator:
                    (value) =>
                        value == null || value.length < 6
                            ? 'Password minimal 6 karakter'
                            : null,
                onSaved: (value) => _password = value!,
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: handleRegister,
                child: const Text('Register'),
              ),
              Text(_error),
            ],
          ),
        ),
      ),
    );
  }
}
