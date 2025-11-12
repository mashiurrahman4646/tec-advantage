class ApiConfig {
  static const String baseUrl = 'http://10.10.7.102:3000/api/v1';

  // Endpoints
  static const String login = '/auth/login';
  static const String verifyEmail = '/auth/verify-email';
  static const String user = '/user';

  static get resolvedBaseUrl => null;
}