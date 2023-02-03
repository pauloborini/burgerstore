class UnauthorizedException implements Exception {
  final String message;

  const UnauthorizedException({
    required this.message,
  });
}
