import 'package:cloud_firestore/cloud_firestore.dart';

class TodoListModel {
  final String id;
  final String task;
  final bool isDone;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  TodoListModel({
    required this.id,
    required this.task,
    required this.isDone,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  // dari firebase ke flutter (serialization) sifatnya asinkron makanya pake factory karena bakalan dipanggil via future
  factory TodoListModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    Timestamp? createdDate = data['createdAt'] as Timestamp?;
    Timestamp? updatedDate = data['updatedAt'] as Timestamp?;
    Timestamp? deletedDate = data['deletedAt'] as Timestamp?;

    return TodoListModel(
      id: doc.id,
      task: data['task'] ?? '',
      isDone: data['isDone'] ?? false,
      createdAt: createdDate?.toDate() ?? DateTime.now(),
      updatedAt: updatedDate?.toDate() ?? DateTime.now(),
      deletedAt: deletedDate?.toDate(),
    );
  }

  // dari flutter ke firebase (deserialization) ini dipanggil setelah kita buat instance model sifatnya sinkron karena cuma buat "bungkus" ini dipakai buat proses create aja
  Map<String, dynamic> toFirestore() {
    return {
      'task': task,
      'isDone': isDone,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
      'deletedAt': null,
    };
  }
}
