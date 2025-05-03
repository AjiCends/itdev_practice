import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/event_model.dart';
import '../models/event_registered_model.dart';

class EventRegisteredProvider extends ChangeNotifier {
  final List<EventRegisteredModel> _registrations = [
    EventRegisteredModel(
      name: 'asdf',
      email: 'ad@gmail',
      gender: 'Laki-laki',
      ticketType: 'VIP',
      agree: true,
      eventId: 1,
    ),
  ];
  late List<EventModel> events;
  int _nextId = 1;

  List<EventRegisteredModel> getAllRegistered() {
    return _registrations;
  }

  registerEvent(EventRegisteredModel registration) {
    try {
      var currId = _nextId++;
      registration.id = currId;
      _registrations.add(registration);
      notifyListeners();

      return true;
    } catch (e) {
      return false;
    }
  }

  getEventById(int id) {
    try {
      return events.firstWhere((event) => event.id == id);
    } catch (e) {
      return null;
    }
  }

  removeRegistrationById(int id) {
    try {
      _registrations.removeWhere((registration) => registration.id == id);
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }
}
