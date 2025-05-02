import 'package:flutter/material.dart';
import 'package:flutter_application_2/form_practice/myRadio.dart';
import 'package:flutter_application_2/enums/jenis_kelamin.dart';

class FormScreen extends StatelessWidget {
  const FormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Contoh Form Flutter')),
        body: const Padding(padding: EdgeInsets.all(16.0), child: MyForm()),
      ),
    );
  }
}

class MyForm extends StatefulWidget {
  const MyForm({super.key});

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  var nameController = TextEditingController();
  JenisKelamin? _selectedGender;

  @override
  void dispose() {
    // Dispose controller untuk mencegah kebocoran memori
    nameController.dispose();
    super.dispose(); // Jangan lupa panggil super.dispose() setelahnya
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey, // Mengaitkan form dengan global key
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Email'),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Nama tidak boleh kosong';
              }
              const emailPattern =
                  r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
              final emailRegExp = RegExp(emailPattern);
              if (!emailRegExp.hasMatch(value)) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Format email tidak valid')),
                );
              }
              return null;
            },
            onSaved: (newValue) {
              _name = newValue ?? '';
            },
          ),
          MyRadio(selectedGender: _selectedGender, onChanged: (value) {
            setState(() {
              _selectedGender = value;
            });
          }),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              // Validasi form
              if (_formKey.currentState!.validate()) {
                // Jalankan onSaved pada setiap TextFormField
                _formKey.currentState!.save();

                // Tampilkan hasil input
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Data disimpan: $_name, email : ${nameController.text}',
                    ),
                  ),
                );
              }
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }
}