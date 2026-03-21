import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class BaseService {
  FirebaseFirestore get db => FirebaseFirestore.instance;
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;
  GoogleSignIn get googleSignIn => GoogleSignIn.instance;

  String? get uid => firebaseAuth.currentUser?.uid;
}
