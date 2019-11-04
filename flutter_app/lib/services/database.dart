import 'package:flutter_app/models/User.dart';
import 'package:flutter_app/utils/constants.dart';

class Database{

  static void updateUser(User user)
  {
    usersRef.document(user.uid).updateData({
      'name': user.name,
      'bio': user.bio,
      'profileImageUrl': user.profileImageUrl
    });
  }

}