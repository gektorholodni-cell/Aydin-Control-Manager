import '../entities/calendar_event_model.dart';
import '../entities/drawing_model.dart';
import '../entities/equipment_model.dart';
import '../entities/project_model.dart';
import '../entities/report_model.dart';
import '../entities/user_model.dart';
import '../entities/vehicle_model.dart';
import '../entities/warehouse_item_model.dart';
import '../repositories/enterprise_repository.dart';

class EnterpriseService {
  const EnterpriseService(this._repository);

  final EnterpriseRepository _repository;

  List<EnterpriseProject> getProjects() => _repository.getProjects();

  List<EnterpriseUser> getUsers() => _repository.getUsers();

  List<EnterpriseDrawing> getDrawings() => _repository.getDrawings();

  List<EnterpriseEquipment> getEquipment() => _repository.getEquipment();

  List<EnterpriseVehicle> getVehicles() => _repository.getVehicles();

  List<EnterpriseWarehouseItem> getWarehouseItems() => _repository.getWarehouseItems();

  List<EnterpriseCalendarEvent> getCalendarEvents() => _repository.getCalendarEvents();

  List<EnterpriseReport> getReports() => _repository.getReports();
}
