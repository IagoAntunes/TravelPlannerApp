abstract class HttpExceptions {
  String? message;
  String error;
  HttpExceptions({
    this.message,
    required this.error,
  });

  toMap() {
    return {
      "error": error,
      "message": message,
    };
  }
}
