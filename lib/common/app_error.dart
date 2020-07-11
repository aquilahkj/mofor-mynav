class AppError implements Exception {
  AppError(this.message);
  final String message;
  @override
  String toString() {
    return 'AppError $message';
  }
}
