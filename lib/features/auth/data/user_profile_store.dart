import 'package:shared_preferences/shared_preferences.dart';

/// Данные пользователя, которые он вводит при входе.
class UserProfile {
  const UserProfile({
    required this.email,
    required this.lastName,
    required this.firstName,
    required this.middleName,
    required this.position,
  });

  static const empty = UserProfile(
    email: '',
    lastName: '',
    firstName: '',
    middleName: '',
    position: '',
  );

  final String email;
  final String lastName;
  final String firstName;
  final String middleName;
  final String position;

  bool get isEmpty => firstName.isEmpty && lastName.isEmpty;

  /// «Фамилия Имя Отчество» без пустых частей.
  String get fullName => <String>[lastName, firstName, middleName]
      .where((String part) => part.isNotEmpty)
      .join(' ');

  /// Имя для приветствия: «Имя Отчество» или просто «Имя».
  String get greetingName => <String>[firstName, middleName]
      .where((String part) => part.isNotEmpty)
      .join(' ');

  String get initials {
    final letters = <String>[firstName, lastName]
        .where((String part) => part.isNotEmpty)
        .map((String part) => part.substring(0, 1).toUpperCase());
    return letters.join();
  }
}

class UserProfileStore {
  const UserProfileStore._();

  static const _emailKey = 'structra.user.email';
  static const _lastNameKey = 'structra.user.last_name';
  static const _firstNameKey = 'structra.user.first_name';
  static const _middleNameKey = 'structra.user.middle_name';
  static const _positionKey = 'structra.user.position';

  static Future<UserProfile> load() async {
    final prefs = await SharedPreferences.getInstance();
    return UserProfile(
      email: prefs.getString(_emailKey) ?? '',
      lastName: prefs.getString(_lastNameKey) ?? '',
      firstName: prefs.getString(_firstNameKey) ?? '',
      middleName: prefs.getString(_middleNameKey) ?? '',
      position: prefs.getString(_positionKey) ?? '',
    );
  }

  static Future<void> save(UserProfile profile) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_emailKey, profile.email);
    await prefs.setString(_lastNameKey, profile.lastName);
    await prefs.setString(_firstNameKey, profile.firstName);
    await prefs.setString(_middleNameKey, profile.middleName);
    await prefs.setString(_positionKey, profile.position);
  }
}
