import 'package:flutter/material.dart';

class KelilingLingkaran extends StatefulWidget {
  final ValueChanged calculateKeliling;

  const KelilingLingkaran({super.key, required this.calculateKeliling});

  @override
  State<KelilingLingkaran> createState() => _KelilingLingkaranState();
}

class _KelilingLingkaranState extends State<KelilingLingkaran> {
  var kelilingLingkaranController = TextEditingController();
  int? jariJariLingkaran;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(label: Text('Jari-jari Lingkaran')),
          keyboardType: TextInputType.number,
          onChanged: <int>(value) {
            jariJariLingkaran = value;
          },
        ),
        TextField(
          decoration: InputDecoration(label: Text('Keliling Lingkaran')),
          controller: kelilingLingkaranController,
          enabled: false,
        ),
      ],
    );
  }
}
