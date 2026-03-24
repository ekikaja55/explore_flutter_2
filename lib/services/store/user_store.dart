import 'package:explore_flutter_2/models/user_model.dart';
import 'package:explore_flutter_2/services/base_service.dart';
import 'package:explore_flutter_2/utils/my_logger.dart';
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
          phoneNum: '',
          isRegistered: false,
          lastSeen: DateTime.now(),
          userTier: UserTier.starter,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        await db.collection('users').doc(user.uid).set(newUser.toFirestore());
      } on FirebaseException catch (e) {
        MyLogger().e("error save user to firestore:${e.message}");
      }
    }
  }
}
