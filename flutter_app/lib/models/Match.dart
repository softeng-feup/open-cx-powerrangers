import 'package:cloud_firestore/cloud_firestore.dart';

class Match {
  final String requester,receiver,event;
  final bool accepted;
  //interests?

  Match({
    this.requester,
    this.receiver,
    this.event,
    this.accepted,
    });

  factory Match.fromDoc(DocumentSnapshot doc) {
    return Match(
        requester: doc['requester'],
        receiver: doc['receiver'],
        event: doc['event'],
        accepted: doc['accepted'] ?? ''
    );
  }
}