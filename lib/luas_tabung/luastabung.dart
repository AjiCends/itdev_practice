import 'package:flutter/material.dart';
import 'package:flutter_application_2/luas_tabung/kelilinglingkaran.dart';

class LuasTabung extends StatefulWidget {
  const LuasTabung({super.key});

  @override
  State<LuasTabung> createState() => _LuasTabungState();
}

class _LuasTabungState extends State<LuasTabung> {
  int? tinggi;
  int? kelilingLingkaran;

  int luasTabung(kelilingLingkaran, tinggi) {
    var luastabung = kelilingLingkaran * tinggi;
    return luastabung;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Form(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    decoration: InputDecoration(label: Text('Tinggi Tabung')),
                  ),
                  KelilingLingkaran(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
