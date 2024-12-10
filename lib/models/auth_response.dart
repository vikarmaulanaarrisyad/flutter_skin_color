class AuthResponse {
  final String accessToken;
  final String refreshToken;
  final UserData data;
  final String message;

  AuthResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.data,
    required this.message,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      accessToken: json['data']['access_token'],
      refreshToken: json['data']['refresh_token'],
      data: UserData.fromJson(json['data']['data']),
      message: json['message'],
    );
  }
}

class UserData {
  final String email;
  final int id;
  final int level;
  final String name;

  UserData({
    required this.email,
    required this.id,
    required this.level,
    required this.name,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      email: json['email'],
      id: json['id'],
      level: json['level'],
      name: json['name'],
    );
  }
}
