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
  final String imageUrl;
  final Map<dynamic, dynamic> topics;

  Conference({
    this.eventId,
    this.ownerId,
    this.name,
    this.address,
    this.descr,
    this.date,
    this.urlName,
    this.urlLink,
    this.imageUrl,
    this.topics
  });

  factory Conference.fromDoc(DocumentSnapshot doc)
  {
    return Conference(
      eventId: doc.documentID,
      ownerId: doc['ownerId'] ?? '',
      name: doc['name'] ?? '',
      address: doc['address'] ?? '',
      descr: doc['descr'] ?? '',
      date: doc['date'],
      urlName: doc['urlName'] ?? '',
      urlLink: doc['urlLink'] ?? '',
      imageUrl: doc['imageUrl'],
      topics: doc['topics'],
    );
  }

  DateTime get getDate
  {
    DateTime localDate = date.toDate();
    return localDate;
  }

  String get getMonth
  {
    DateTime localDate = date.toDate();

    switch(localDate.month)
    {
      case 1: return 'Jan';
      case 2: return 'Feb';
      case 3: return 'Mar';
      case 4: return 'Apr';
      case 5: return 'May';
      case 6: return 'Jun';
      case 7: return 'Jul';
      case 8: return 'Aug';
      case 9: return 'Sep';
      case 10: return 'Oct';
      case 11: return 'Nov';
      case 12: return 'Dec';
    }
  }

  String get getCalendarDate
  {
    DateTime localDate = date.toDate();

    return '${localDate.day}-${localDate.month}-${localDate.year}';
  }
}