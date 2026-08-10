class EnterpriseEquipment {
  const EnterpriseEquipment({
    required this.id,
    required this.name,
    required this.serialNumber,
    required this.status,
    required this.assignedProject,
    required this.assignedEmployee,
    required this.maintenanceDate,
  });

  final String id;
  final String name;
  final String serialNumber;
  final String status;
  final String assignedProject;
  final String assignedEmployee;
  final DateTime maintenanceDate;
}
