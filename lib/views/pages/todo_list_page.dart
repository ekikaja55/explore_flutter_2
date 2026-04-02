import 'package:explore_flutter_2/models/todo_list_model.dart';
import 'package:explore_flutter_2/services/store/todo_list_store.dart';
import 'package:explore_flutter_2/utils/system_response.dart';
import 'package:explore_flutter_2/views/widgets/snackbar_widget.dart';
import 'package:flutter/material.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final _todoStore = TodoListStore();
  final _todoController = TextEditingController();
  bool _isEditMode = false;
  String? _selectedDocId;

  void _onEditTap(TodoListModel item) {
    setState(() {
      _isEditMode = true;
      _selectedDocId = item.id;
      _todoController.text = item.task;
    });
  }

  void _clearSec() {
    setState(() {
      _isEditMode = false;
      _selectedDocId = null;
      _todoController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10.0,
        children: [
          const Text(
            "My Todo List",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _todoController,
                  decoration: InputDecoration(
                    hintText: _isEditMode
                        ? "Edit Data..."
                        : "Tambah tugas baru...",
                    suffixIcon: _isEditMode
                        ? IconButton(
                            onPressed: () => _clearSec(),
                            icon: Icon(Icons.close),
                          )
                        : null,
                  ),
                ),
              ),
              IconButton(
                onPressed: () async {
                  SystemResponse res;
                  if (_isEditMode) {
                    res = await _todoStore.updateTaskTodo(
                      _selectedDocId!,
                      _todoController.text,
                    );
                  } else {
                    res = await _todoStore.addTodo(_todoController.text);
                  }
                  if (context.mounted) {
                    SnackbarWidget.show(context, res);
                    _clearSec();
                  }
                },
                icon: _isEditMode ? Icon(Icons.check) : Icon(Icons.add),
              ),
            ],
          ),
          Expanded(
            child: StreamBuilder(
              stream: _todoStore.getTodos,
              builder: (context, snapshot) {
                final dataTodo = snapshot.data ?? [];

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Terjadi kesalahan: ${snapshot.error}"),
                  );
                }
                if (dataTodo.isEmpty) {
                  return Center(child: Text("Tidak ada data"));
                }

                return ListView.builder(
                  itemCount: dataTodo.length,
                  itemBuilder: (context, index) {
                    final item = dataTodo[index];
                    return ListTile(
                      title: Text(
                        item.task,
                        style: TextStyle(
                          decoration: item.isDone
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      leading: Checkbox(
                        value: item.isDone,
                        onChanged: (value) async {
                          final res = await _todoStore.updateStatusTodo(
                            item.id,
                            item.isDone,
                          );
                          if (context.mounted) {
                            SnackbarWidget.show(context, res);
                          }
                        },
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () async {
                              final res = await _todoStore.deleteTodo(item.id);
                              if (context.mounted) {
                                SnackbarWidget.show(context, res);
                              }
                            },
                            icon: Icon(Icons.delete),
                          ),
                          IconButton(
                            onPressed: () => _onEditTap(item),
                            icon: Icon(Icons.edit),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
