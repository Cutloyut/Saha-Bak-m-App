enum UserRole { technician, teamlead }

class AppUser {
  final int id;
  final String name;
  final UserRole role;

  AppUser({required this.id, required this.name, required this.role});
}
