import 'package:cloud_firestore/cloud_firestore.dart';

class Attendee {
  final Map topics;
  final String name;

  Attendee({
    this.name,
    this.topics});

  factory Attendee.fromDoc(DocumentSnapshot doc) {
    return Attendee(
        name: doc['name'] ?? 'John Doe',
        topics: doc['topics']
    );
  }
}