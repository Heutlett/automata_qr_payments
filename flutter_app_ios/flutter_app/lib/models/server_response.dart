
class ServerResponse<T> {
  T? data;
  bool success;
  String message;

  ServerResponse({
    required this.data,
    required this.success,
    required this.message,
  });
}
