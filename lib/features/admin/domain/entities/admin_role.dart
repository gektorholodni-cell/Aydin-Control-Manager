import 'admin_permission.dart';

class AdminRole {
  const AdminRole({
    required this.id,
    required this.title,
    required this.permissions,
  });

  final String id;
  final String title;
  final Set<AdminPermission> permissions;

  AdminRole copyWith({
    String? id,
    String? title,
    Set<AdminPermission>? permissions,
  }) {
    return AdminRole(
      id: id ?? this.id,
      title: title ?? this.title,
      permissions: permissions ?? this.permissions,
    );
  }
}
