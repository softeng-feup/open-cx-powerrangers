import 'package:cloud_firestore/cloud_firestore.dart';

class Attendee {
  final Map topics;

  Attendee({
    this.topics});

  factory Attendee.fromDoc(DocumentSnapshot doc) {
    return Attendee(
        topics: doc['topics']
    );
  }
}