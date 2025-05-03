import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/event_model.dart';

class EventProvider extends ChangeNotifier {
  final List<EventModel> _events = [
    EventModel(
      id: 1,
      name: 'Festival Budaya',
      date: '12/06/2025',
      description: 'Festival budaya yang menampilkan kesenian daerah.',
    ),
    EventModel(
      id: 2,
      name: 'Lomba Fotografi',
      date: '20/06/2025',
      description: 'Kompetisi fotografi dengan tema wisata lokal.',
    ),
    EventModel(
      id: 3,
      name: 'Bazar Kuliner',
      date: '05/07/2025',
      description: 'Bazar makanan khas daerah dari seluruh nusantara.',
    ),
    EventModel(
      id: 4,
      name: 'Workshop Batik',
      date: '15/07/2025',
      description: 'Belajar membatik langsung dari ahlinya.',
    ),
    EventModel(
      id: 5,
      name: 'Festival Musik Tradisional',
      date: '25/07/2025',
      description: 'Penampilan musik tradisional dari berbagai daerah.',
    ),
    EventModel(
      id: 5,
      name: 'Festival Musik Tradisional',
      date: '25/07/2025',
      description: 'Penampilan musik tradisional dari berbagai daerah.',
    ),
  ];

  List<EventModel> getAllEvents() {
    return _events; // salinan agar tidak bisa dimodifikasi langsung
  }

  EventModel? getEventById(int id) {
    try {
      return _events.firstWhere((event) => event.id == id);
    } catch (e) {
      return null;
    }
  }
}
