import 'package:cloud_firestore/cloud_firestore.dart';

class Conference{
  final String eventId;
  final String ownerId;
  final String name;
  final String address;
  final String descr;
  final Timestamp date;
  final String urlName;
  final String urlLink;

  Conference({
    this.eventId,
    this.ownerId,
    this.name,
    this.address,
    this.descr,
    this.date,
    this.urlName,
    this.urlLink
  });

  factory Conference.fromDoc(DocumentSnapshot doc)
  {
    return Conference(
      eventId: doc.documentID,
      ownerId: doc['ownerId'] ?? '',
      name: doc['name'] ?? '',
      address: doc['address'] ?? '',
      descr: doc['descr'] ?? '',
      date: doc['date'] ?? '',
      urlName: doc['urlName'] ?? '',
      urlLink: doc['urlLink'] ?? ''
    );
  }
}