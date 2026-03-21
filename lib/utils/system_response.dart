enum ResponseType { success, error, warning }

class SystemResponse<T> {
  final ResponseType type;
  final String msg;
  final T? data;

  SystemResponse({required this.type, required this.msg, this.data});

  // helper get method buat ui
  bool get isSuccess => type == ResponseType.success;
  bool get isError => type == ResponseType.error;
  bool get isWarning => type == ResponseType.warning;
}
