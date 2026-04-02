import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:explore_flutter_2/data/types/complete_profile_dto.dart';
import 'package:explore_flutter_2/models/user_model.dart';
import 'package:explore_flutter_2/services/base_service.dart';
import 'package:explore_flutter_2/utils/my_logger.dart';
import 'package:explore_flutter_2/utils/system_response.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserStore extends BaseService {
  Future<void> saveUserToFirestore(User? user) async {
    if (user != null) {
      try {
        UserModel newUser = UserModel(
          uid: user.uid,
          username: user.displayName!,
          email: user.email!,
          photoUrl: user.photoURL!,
          lastSeen: DateTime.now(),
          userTier: UserTier.starter,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        await db.collection('users').doc(user.uid).set(newUser.toFirestore());
      } on FirebaseException catch (e) {
        MyLogger().e("error save user ke firestore:${e.message}");
      }
    }
  }

  Future<UserModel?> getUser() async {
    if (uid == null) {
      MyLogger().e("uid kosong");
      return null;
    }

    try {
      MyLogger().d("proses fetching getUser");
      final doc = await db.collection('users').doc(uid).get();
      if (!doc.exists) {
        return null;
      }
      return UserModel.fromFirestore(doc);
    } on FirebaseException catch (e) {
      MyLogger().e("error getUserBy:", e);
      return null;
    }
  }

  Future<SystemResponse> completeProfile(CompleteProfileDTO data) async {
    try {
      await db.collection('users').doc(uid).update({
        'phoneNum': data.phoneNum ?? '',
        'bio': data.bio ?? '',
        'location': data.location ?? '',
        'updatedAt': FieldValue.serverTimestamp(),
      });

      final user = await getUser();

      // if (user.phoneNum!.isNotEmpty &&
      //     user.bio!.isNotEmpty &&
      //     user.location!.isNotEmpty) {}
      return SystemResponse(
        type: ResponseType.success,
        msg: "Berhasil update profil",
      );
    } on FirebaseException catch (e) {
      MyLogger().e("error complete profile ${e.message}");
      return SystemResponse(
        type: ResponseType.error,
        msg: "Terjadi kesalahan harap coba lagi",
      );
    }
  }
}
