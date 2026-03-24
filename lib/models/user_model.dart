import 'package:explore_flutter_2/models/time_stamp_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:explore_flutter_2/utils/firestore_extension.dart';

enum UserTier { starter, growth, ultimate }

class UserModel extends TimeStampModel {
  final String uid;
  final String username;
  final String email;
  final String photoUrl;
  final UserTier userTier;
  final String phoneNum;
  final bool isRegistered;
  final DateTime lastSeen;

  UserModel({
    required this.uid,
    required this.username,
    required this.email,
    required this.photoUrl,
    required this.lastSeen,
    required this.userTier,
    required this.phoneNum,
    required this.isRegistered,
    required super.createdAt,
    required super.updatedAt,
    super.deletedAt,
  });

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return UserModel(
      uid: doc.id,
      username: data['username'] ?? '',
      email: data['email'] ?? '',
      photoUrl: data['photoUrl'],
      userTier: UserTier.values.firstWhere(
        (e) => e.name == data['userTier'],
        orElse: () => UserTier.starter,
      ),
      phoneNum: data['phoneNum'] ?? '',
      isRegistered: data['isRegistered'] ?? false,
      lastSeen: data.asDateTime('lastSeen'),
      createdAt: data.asDateTime('createdAt'),
      updatedAt: data.asDateTime('updatedAt'),
      deletedAt: data.asNullableDateTime('deletedAt'),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'username': username,
      'email': email,
      'photoUrl': photoUrl,
      'userTier': userTier.name,
      'phoneNumber': phoneNum,
      'isRegistered': isRegistered,
      'lastSeen': FieldValue.serverTimestamp(),
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
      'deletedAt': null,
    };
  }
}
