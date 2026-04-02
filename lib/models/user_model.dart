import 'package:explore_flutter_2/models/time_stamp_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:explore_flutter_2/utils/firestore_extension.dart';

enum UserTier { starter, growth, ultimate }

class UserModel extends TimeStampModel {
  final String uid;
  final String username;
  final String email;
  final String photoUrl;
  final String bannerUrl;
  final String bio;
  final String phoneNum;
  final String location;
  final UserTier userTier;
  final bool isProfileComplete;
  final DateTime? birthDate;
  final DateTime? lastPopUpShown;
  final DateTime lastSeen;

  UserModel({
    required this.uid,
    required this.username,
    required this.email,
    required this.photoUrl,
    this.bannerUrl = '',
    this.bio = '',
    this.phoneNum = '',
    this.location = '',
    required this.userTier,
    this.isProfileComplete = false,
    this.birthDate,
    this.lastPopUpShown,
    required this.lastSeen,
    required super.createdAt,
    required super.updatedAt,
  });

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      uid: doc.id,
      username: data['username'] ?? '',
      email: data['email'] ?? '',
      photoUrl: data['photoUrl'] ?? '',
      bannerUrl: data['bannerUrl'] ?? '',
      bio: data['bio'] ?? '',
      phoneNum: data['phoneNum'] ?? '',
      location: data['location'] ?? '',
      userTier: UserTier.values.firstWhere(
        (e) => e.name == data['userTier'],
        orElse: () => UserTier.starter,
      ),
      isProfileComplete: data['isProfileComplete'] ?? false,
      birthDate: data.asNullableDateTime('birthDate'),
      lastPopUpShown: data.asNullableDateTime('lastPopUpShown'),
      lastSeen: data.asDateTime('lastSeen'),
      createdAt: data.asDateTime('createdAt'),
      updatedAt: data.asDateTime('updatedAt'),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'username': username,
      'email': email,
      'photoUrl': photoUrl,
      'bannerUrl': bannerUrl,
      'bio': bio,
      'phoneNumber': phoneNum,
      'location': location,
      'userTier': userTier.name,
      'isProfileComplete': isProfileComplete,
      'birthDate': birthDate,
      'lastPopUpShown': lastPopUpShown,
      'lastSeen': FieldValue.serverTimestamp(),
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
      'deletedAt': null,
    };
  }
}
