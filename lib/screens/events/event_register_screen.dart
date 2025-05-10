import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/event_registered_model.dart';
import 'package:flutter_application_2/providers/event_registered_provider.dart';
import 'package:provider/provider.dart';

class EventRegisterScreen extends StatefulWidget {
  final int eventId;
  const EventRegisterScreen({super.key, required this.eventId});

  @override
  State<EventRegisterScreen> createState() => _EventRegisterScreenState();
}

class _EventRegisterScreenState extends State<EventRegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  String name = '';
  String email = '';
  String gender = 'Laki-laki';
  String ticketType = 'Reguler';
  bool agree = false;

  final List<String> ticketOptions = ['Reguler', 'VIP', 'VVIP'];

  Map<String, bool> selectedCategories = {
    'musik': false,
    'olahraga': false,
    'kuliner': false,
  };

  void handleSubmit() {
    EventRegisteredModel data = EventRegisteredModel(
      name: name,
      email: email,
      gender: gender,
      ticketType: ticketType,
      agree: agree,
      eventId: widget.eventId,
    );

    bool handleRegistration = Provider.of<EventRegisteredProvider>(
      context,
      listen: false,
    ).registerEvent(data);

    String message = '';

    if (handleRegistration) {
      message = 'Registrasi Sukses!';
    } else {
      message = 'Registrasi Gagal!';
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pendaftaran Event'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text(
                'Formulir Pendaftaran',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // Nama
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nama Lengkap'),
                onChanged: (value) => setState(() => name = value),
                validator:
                    (value) =>
                        value!.isEmpty ? 'Nama tidak boleh kosong' : null,
              ),

              // Email
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) => setState(() => email = value),
                validator:
                    (value) =>
                        value!.isEmpty ? 'Email tidak boleh kosong' : null,
              ),

              const SizedBox(height: 16),

              // Jenis Kelamin (Radio)
              const Text('Jenis Kelamin'),
              ListTile(
                title: const Text('Laki-laki'),
                leading: Radio<String>(
                  value: 'Laki-laki',
                  groupValue: gender,
                  onChanged: (value) => setState(() => gender = value!),
                ),
              ),
              ListTile(
                title: const Text('Perempuan'),
                leading: Radio<String>(
                  value: 'Perempuan',
                  groupValue: gender,
                  onChanged: (value) => setState(() => gender = value!),
                ),
              ),

              const SizedBox(height: 16),

              // Tipe Tiket (Dropdown)
              DropdownButtonFormField<String>(
                value: ticketType,
                decoration: const InputDecoration(labelText: 'Jenis Tiket'),
                items:
                    ticketOptions
                        .map(
                          (item) =>
                              DropdownMenuItem(value: item, child: Text(item)),
                        )
                        .toList(),
                onChanged: (value) => setState(() => ticketType = value!),
              ),

              const SizedBox(height: 16),

              // Persetujuan (Checkbox)
              CheckboxListTile(
                title: const Text('Saya menyetujui syarat dan ketentuan'),
                value: agree,
                onChanged: (value) => setState(() => agree = value ?? false),
              ),

              const SizedBox(height: 16),

              // Tombol Submit
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate() && agree) {
                    handleSubmit();
                  } else if (!agree) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Anda harus menyetujui syarat'),
                      ),
                    );
                  }
                },
                child: const Text('Daftar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
