class TokenManager {
  static String generateToken() {
    final DateTime now = DateTime.now();
    final String token = now.add(const Duration(minutes: 4)).toIso8601String();
    return token;
  }

  static bool isTokenValid(String token) {
    final DateTime now = DateTime.now();
    try {
      final DateTime tokenTime = DateTime.parse(token);
      return tokenTime.isAfter(now);
    } catch (e) {
      return false;
    }
  }
}
