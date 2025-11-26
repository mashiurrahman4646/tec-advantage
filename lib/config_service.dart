class ApiConfig {
  static const String baseUrl = 'http://10.10.7.102:3000/api/v1';

  // Endpoints
  static const String login = '/auth/login';
  static const String verifyEmail = '/auth/verify-email';
  static const String user = '/user';
  static const String groups = '/groups';
  static String groupPosts(String groupId) => '/groups/$groupId/posts';
  static String getComments(String postId) => '/groups/$postId/comments';
  static String createComment(String groupId, String postId) => '/groups/$groupId/post/$postId/comments';

  static get resolvedBaseUrl => null;
}
