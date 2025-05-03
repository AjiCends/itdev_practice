class EventRegisteredModel {
  int? id;
  final String name;
  final String email;
  final String gender;
  final String ticketType;
  final bool agree;
  final int eventId;

  EventRegisteredModel({
    this.id,
    required this.name,
    required this.email,
    required this.gender,
    required this.ticketType,
    required this.agree,
    required this.eventId,
  });
}
