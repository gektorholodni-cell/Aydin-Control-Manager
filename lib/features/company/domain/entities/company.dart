class Company {
  const Company({
    required this.id,
    required this.name,
    required this.logoText,
    required this.address,
    required this.phone,
    required this.email,
    required this.projects,
    required this.employees,
  });

  final String id;
  final String name;
  final String logoText;
  final String address;
  final String phone;
  final String email;
  final List<String> projects;
  final List<String> employees;
}
