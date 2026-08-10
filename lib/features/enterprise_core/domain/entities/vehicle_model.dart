class EnterpriseVehicle {
  const EnterpriseVehicle({
    required this.id,
    required this.vehicle,
    required this.driver,
    required this.mileageKm,
    required this.fuelLevel,
    required this.status,
    required this.maintenanceDate,
  });

  final String id;
  final String vehicle;
  final String driver;
  final int mileageKm;
  final String fuelLevel;
  final String status;
  final DateTime maintenanceDate;
}
