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

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'role': role,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
    };
  }

  factory Employee.fromJson(Map<String, dynamic> json) {
    final endDate = json['endDate'] != null 
        ? DateTime.parse(json['endDate']) 
        : null;
    return Employee(
      name: json['name'],
      role: json['role'],
      startDate: DateTime.parse(json['startDate']),
      endDate: endDate,
      isFormer: endDate != null,
    );
  }
}
