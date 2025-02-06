class Employee {
  final String name;
  final String role;
  final DateTime startDate;
  final DateTime? endDate;
  final bool isFormer;

  Employee({
    required this.name,
    required this.role,
    required this.startDate,
    this.endDate,
    this.isFormer = false,
  });
}
