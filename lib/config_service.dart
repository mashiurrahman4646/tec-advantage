class ApiConfig {
  static const String baseUrl =
      'https://grass-proxy-possible-depends.trycloudflare.com/api/v1';

  // Endpoints
  static const String login = '/auth/login';
  static const String verifyEmail = '/auth/verify-email';
  static const String changePassword = '/auth/change-password';
  static const String forgetPassword = '/auth/forget-password';
  static const String resetPassword = '/auth/reset-password';
  static const String user = '/user';
  static const String userProfile = '/user/profile';
  static const String groups = '/groups';
  static const String notifications = '/notification';
  static String markNotificationRead(String id) => '/notification/read/$id';
  static String groupPosts(String groupId) => '/groups/$groupId/posts';
  static String getComments(String postId) => '/groups/$postId/comments';
  static String createComment(String groupId, String postId) =>
      '/groups/$groupId/post/$postId/comments';

  static get resolvedBaseUrl => null;
}
