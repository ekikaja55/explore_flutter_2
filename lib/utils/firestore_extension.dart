import 'package:cloud_firestore/cloud_firestore.dart';

extension FirestoreMapParser on Map<String, dynamic> {
  DateTime asDateTime(String key) {
    final value = this[key];
    if (value is Timestamp) {
      return value.toDate();
    }
    return DateTime.now();
  }

  DateTime? asNullableDateTime(String key) {
    final value = this[key];
    if (value is Timestamp) {
      return value.toDate();
    }
    return null;
  }
}
