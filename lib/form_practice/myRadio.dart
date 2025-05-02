import 'package:flutter/material.dart';
import 'package:flutter_application_2/enums/jenis_kelamin.dart';


class MyRadio extends StatelessWidget {
  final JenisKelamin? selectedGender;
  final ValueChanged<JenisKelamin?> onChanged;

  const MyRadio({
    super.key,
    required this.selectedGender,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: const Text('Laki-laki'),
          leading: Radio<JenisKelamin>(
            value: JenisKelamin.lakiLaki,
            groupValue: selectedGender,
            onChanged: onChanged,
          ),
        ),
        ListTile(
          title: const Text('Perempuan'),
          leading: Radio<JenisKelamin>(
            value: JenisKelamin.perempuan,
            groupValue: selectedGender,
            onChanged: onChanged,
          ),
        ),
        SizedBox(height: 20),
        Text(
          'Jenis Kelamin yang dipilih: ${selectedGender == null ? 'Belum dipilih' : selectedGender.toString().split('.').last}',
        ),
      ],
    );
  }
}
