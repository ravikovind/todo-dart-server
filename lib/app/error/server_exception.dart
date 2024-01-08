/// [ServerException] is a custom exception class that is thrown when an Server error occurs.
class ServerException implements Exception {
  final String message;
  ServerException(this.message);
  @override
  String toString() {
    return message;
  }
}
