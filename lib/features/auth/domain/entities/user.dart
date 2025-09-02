import 'package:ams_messaging/features/auth/data/models/auth_model.dart';

class UserEntity {
  final String email;
  final String username;
  final String token;
  final String? profileImage;
  final int id;

  UserEntity({
    required this.email,
    required this.username,
    required this.token,
    required this.id, 
    this.profileImage,
  });

    static UserEntity fromUser(User user) {
    return UserEntity(
      email: user.email ?? '',
      username: user.username?.toString() ?? '',
      token: user.verificationToken ?? '',
      id: user.id ?? 0,
      profileImage: user.profileImage?.toString(),
    );
  }
}