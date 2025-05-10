import 'package:flutter/material.dart';
import 'package:flutter_application_2/providers/destination_provider.dart';
import 'package:provider/provider.dart';

class DestinationUpdateScreen extends StatefulWidget {
  final String destinationId;
  const DestinationUpdateScreen({super.key, required this.destinationId});

  @override
  State<DestinationUpdateScreen> createState() =>
      _DestinationUpdateScreenState();
}

class _DestinationUpdateScreenState extends State<DestinationUpdateScreen> {
  final _formKey = GlobalKey<FormState>();

  var _nameController = TextEditingController();
  var _descriptionController = TextEditingController();
  var _imageController = TextEditingController();

  var _loading = true;

  Future handleSubmit() async {
    _loading = true;
    if (_formKey.currentState!.validate()) {
      var destinationProvider = Provider.of<DestinationProvider>(
        context,
        listen: false,
      );

      String name = _nameController.text.trim();
      String description = _descriptionController.text.trim();
      String image = _imageController.text.trim();

      var data = {
        'id': widget.destinationId,
        'name': name,
        'description': description,
        'image': image,
      };

      var submit = await destinationProvider.update(data);

      return submit;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.microtask(() async {
      await Provider.of<DestinationProvider>(
        context,
        listen: false,
      ).find(widget.destinationId);

      final destination =
          Provider.of<DestinationProvider>(context, listen: false).detail;

      _nameController = TextEditingController(text: destination?.name);
      _descriptionController = TextEditingController(
        text: destination?.description,
      );
      _imageController = TextEditingController(text: destination?.image);

      setState(() {
        _loading = false;
      });
    });
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
                    _loading = true;
                  });

                  var submitted = await handleSubmit();

                  setState(() {
                    _loading = false;
                  });

                  if (submitted == true) {
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
                    _loading
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
