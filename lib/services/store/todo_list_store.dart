import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:explore_flutter_2/models/todo_list_model.dart';
import 'package:explore_flutter_2/services/base_service.dart';
import 'package:explore_flutter_2/utils/my_logger.dart';
import 'package:explore_flutter_2/utils/system_response.dart';

class TodoListStore extends BaseService {
  // get data stream
  Stream<List<TodoListModel>> get getTodos {
    return db
        .collection('users')
        .doc(uid)
        .collection('todos')
        .where('deletedAt', isNull: true)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
          final items = snapshot.docs
              .map((doc) => TodoListModel.fromFirestore(doc))
              .toList();
          MyLogger().i("update data diterima isi items : ${items.length}");
          return items;
        })
        .handleError((error) {
          MyLogger().e("error saat get todos : $error");
        });
  }

  // Create Todo
  Future<SystemResponse> addTodo(String taskName) async {
    final trimmed = taskName.trim();
    if (trimmed.isEmpty) {
      return SystemResponse(
        type: ResponseType.error,
        msg: "Inputan tidak boleh kosong",
      );
    }
    try {
      final newData = TodoListModel(
        id: '',
        task: trimmed,
        isDone: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      final createData = await db
          .collection('users')
          .doc(uid)
          .collection('todos')
          .add(newData.toFirestore());

      MyLogger().i("isi created data: $createData");

      return SystemResponse(
        type: ResponseType.success,
        msg: "Berhasil menambahkan data TodoList",
      );
    } on FirebaseException catch (e) {
      MyLogger().e("error simpan todo : ${e.message}");
      return SystemResponse(
        type: ResponseType.error,
        msg: e.message ?? "Terjadi Kesalahan",
      );
    }
  }

  // Update Status Todo
  Future<SystemResponse> updateStatusTodo(
    String docId,
    bool currentStatus,
  ) async {
    try {
      await db
          .collection('users')
          .doc(uid)
          .collection('todos')
          .doc(docId)
          .update({
            'isDone': !currentStatus,
            'updatedAt': FieldValue.serverTimestamp(),
          });

      return SystemResponse(
        type: ResponseType.success,
        msg: "Berhasil update status TodoList",
      );
    } on FirebaseException catch (e) {
      MyLogger().e("error update status todo : ${e.message}");
      return SystemResponse(
        type: ResponseType.error,
        msg: e.message ?? "Terjadi Kesalahan",
      );
    }
  }

  Future<SystemResponse> updateTaskTodo(String docId, String task) async {
    if (task.trim().isEmpty) {
      return SystemResponse(
        type: ResponseType.error,
        msg: "Inputan tidak boleh kosong",
      );
    }
    try {
      await db
          .collection('users')
          .doc(uid)
          .collection('todos')
          .doc(docId)
          .update({'task': task, 'updatedAt': FieldValue.serverTimestamp()});

      return SystemResponse(
        type: ResponseType.success,
        msg: "Berhasil update task TodoList",
      );
    } on FirebaseException catch (e) {
      MyLogger().e("error update task todo : ${e.message}");
      return SystemResponse(
        type: ResponseType.error,
        msg: e.message ?? "Terjadi Kesalahan",
      );
    }
  }

  // delete todo
  Future<SystemResponse> deleteTodo(String docId) async {
    try {
      await db
          .collection('users')
          .doc(uid)
          .collection('todos')
          .doc(docId)
          .update({'deletedAt': FieldValue.serverTimestamp()});
      return SystemResponse(
        type: ResponseType.success,
        msg: "Berhasil menghapus TodoList",
      );
    } on FirebaseException catch (e) {
      MyLogger().e("error delete todo : ${e.message}");
      return SystemResponse(
        type: ResponseType.error,
        msg: e.message ?? "Terjadi Kesalahan",
      );
    }
  }
}
