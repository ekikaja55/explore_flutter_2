import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:explore_flutter_2/models/time_stamp_model.dart';
import 'package:explore_flutter_2/utils/firestore_extension.dart';

class TodoListModel extends TimeStampModel {
  final String id;
  final String task;
  final bool isDone;

  TodoListModel({
    required this.id,
    required this.task,
    required this.isDone,
    required super.createdAt,
    required super.updatedAt,
    super.deletedAt,
  });

  // dari firebase ke flutter (serialization) sifatnya asinkron makanya pake factory karena bakalan dipanggil via future
  factory TodoListModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return TodoListModel(
      id: doc.id,
      task: data['task'] ?? '',
      isDone: data['isDone'] ?? false,
      createdAt: data.asDateTime('createdAt'),
      updatedAt: data.asDateTime('updatedAt'),
      deletedAt: data.asNullableDateTime('deletedAt'),
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
