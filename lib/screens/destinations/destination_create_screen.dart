import 'package:flutter/material.dart';
import 'package:flutter_application_2/providers/destination_provider.dart';
import 'package:provider/provider.dart';

class DestinationCreateScreen extends StatefulWidget {
  const DestinationCreateScreen({super.key});

  @override
  State<DestinationCreateScreen> createState() =>
      _DestinationCreateScreenState();
}

class _DestinationCreateScreenState extends State<DestinationCreateScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageController = TextEditingController();

  bool _isSubmitting = false;

  Future handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      var destinationProvider = Provider.of<DestinationProvider>(
        context,
        listen: false,
      );

      String name = _nameController.text.trim();
      String description = _descriptionController.text.trim();
      String image = _imageController.text.trim();

      var data = {'name': name, 'description': description, 'image': image};

      var submit = destinationProvider.store(data);

      return submit;

      // do submit provider here
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Destination')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nama Destinasi'),
                validator:
                    (value) =>
                        value == null || value.isEmpty ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Deskripsi'),
                maxLines: 3,
                validator:
                    (value) =>
                        value == null || value.isEmpty ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _imageController,
                decoration: const InputDecoration(labelText: 'Link Gambar'),
                validator:
                    (value) =>
                        value == null || value.isEmpty ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                onPressed: () async {
                  setState(() {
                    _isSubmitting = true;
                  });

                  var submitted = await handleSubmit();

                  setState(() {
                    _isSubmitting = false;
                  });

                  if (submitted != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Data berhasil dikirim!"),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Gagal mengirim data."),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child:
                    _isSubmitting
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
