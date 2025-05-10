class DestinationModel {
  String? id;
  final String name;
  final String description;
  final String image;
  double? rating;

  DestinationModel({
    this.id,
    required this.name,
    required this.description,
    required this.image,
    this.rating,
  });

  factory DestinationModel.fromJson(Map<String, dynamic> data, String id) {
    return DestinationModel(
      id: id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      image: data['image'] ?? '',
      rating: (data['rating'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'rating': rating,
    };
  }
}
