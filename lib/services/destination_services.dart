import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_2/models/destination_model.dart';

class DestinationServices {
  final CollectionReference _collections = FirebaseFirestore.instance
      .collection('destinations');

  Stream streamAll() {
    return _collections.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return DestinationModel.fromJson(
          doc.data() as Map<String, dynamic>,
          doc.id,
        );
      }).toList();
    });
  }

  Future<List<DestinationModel>> futureAll() async {
    final QuerySnapshot snapshot = await _collections.get();
    return snapshot.docs.map((doc) {
      return DestinationModel.fromJson(
        doc.data() as Map<String, dynamic>,
        doc.id,
      );
    }).toList();
  }

  Future store(DestinationModel data) async {
    try {
      var post = await _collections.add(data.toMap());
      return post.id;
    } catch (e) {
      print("==============");
      print(e.toString());
      print("==============");

      return null;
    }
  }

  Future<DestinationModel?> find(String itemId) async {
    try {
      DocumentSnapshot doc = await _collections.doc(itemId).get();
      if (doc.exists) {
        return DestinationModel.fromJson(
          doc.data() as Map<String, dynamic>,
          doc.id,
        );
      }
      return null;
    } catch (e) {
      print("Error getting item: $e");
      return null;
    }
  }

  Future delete(String itemId) async {
    try {
      await _collections.doc(itemId).delete();
      return true;
    } catch (e) {
      print("==============");
      print(e.toString());
      print("==============");

      return null;
    }
  }

  Future update(DestinationModel data) async {
    try {
      await _collections.doc(data.id).update(data.toMap());
      return true;
    } catch (e) {
      print("==============");
      print(e.toString());
      print("==============");

      return null;
    }
  }
}
