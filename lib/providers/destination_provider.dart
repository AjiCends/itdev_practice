import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/destination_model.dart';
import 'package:flutter_application_2/services/destination_services.dart';

class DestinationProvider extends ChangeNotifier {
  final DestinationServices _destinationService = DestinationServices();

  Stream get destinations => _destinationService.streamAll();

  DestinationModel? _detail;
  DestinationModel? get detail => _detail;

  Future store(Map data) async {
    DestinationModel destination = DestinationModel(
      name: data['name'],
      description: data['description'],
      image: data['image'],
      rating: 3.0,
    );

    var response = await _destinationService.store(destination);
    notifyListeners();

    return response;
  }

  Future<void> find(String id) async {
    _detail = await _destinationService.find(id);
    notifyListeners();
  }

  Future<void> delete(String id) async {
    await _destinationService.delete(id);
    notifyListeners();
  }

  Future update(Map data) async {
    DestinationModel destination = DestinationModel(
      id: data['id'],
      name: data['name'],
      description: data['description'],
      image: data['image'],
    );

    var response = await _destinationService.update(destination);
    if (response == true) {
      _detail = await _destinationService.find(destination.id!);
    }

    notifyListeners();

    return response;
  }
}
