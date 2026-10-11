import '../../domain/entities/calendar_event_model.dart';
import '../../domain/entities/chat_model.dart';
import '../../domain/entities/company_model.dart';
import '../../domain/entities/department_model.dart';
import '../../domain/entities/document_model.dart';
import '../../domain/entities/drawing_model.dart';
import '../../domain/entities/equipment_model.dart';
import '../../domain/entities/finance_model.dart';
import '../../domain/entities/message_model.dart';
import '../../domain/entities/notification_model.dart';
import '../../domain/entities/photo_report_model.dart';
import '../../domain/entities/project_model.dart';
import '../../domain/entities/report_model.dart';
import '../../domain/entities/task_model.dart';
import '../../domain/entities/team_model.dart';
import '../../domain/entities/user_model.dart';
import '../../domain/entities/vehicle_model.dart';
import '../../domain/entities/warehouse_item_model.dart';
import '../../domain/repositories/enterprise_repository.dart';

/// Пустой источник данных для разделов, которые ещё не подключены к облаку.
/// Раньше здесь были вымышленные примеры (чертежи, техника, склад);
/// их убрали, чтобы клиенты видели только свои настоящие данные.
class MockEnterpriseRepository implements EnterpriseRepository {
  const MockEnterpriseRepository();

  @override
  List<EnterpriseUser> getUsers() => const <EnterpriseUser>[];

  @override
  List<EnterpriseCompany> getCompanies() => const <EnterpriseCompany>[];

  @override
  List<EnterpriseDepartment> getDepartments() => const <EnterpriseDepartment>[];

  @override
  List<EnterpriseTeam> getTeams() => const <EnterpriseTeam>[];

  @override
  List<EnterpriseProject> getProjects() => const <EnterpriseProject>[];

  @override
  List<EnterpriseTask> getTasks() => const <EnterpriseTask>[];

  @override
  List<EnterpriseChat> getChats() => const <EnterpriseChat>[];

  @override
  List<EnterpriseMessage> getMessages() => const <EnterpriseMessage>[];

  @override
  List<EnterpriseFinanceRecord> getFinanceRecords() => const <EnterpriseFinanceRecord>[];

  @override
  List<EnterpriseDocument> getDocuments() => const <EnterpriseDocument>[];

  @override
  List<EnterpriseNotification> getNotifications() => const <EnterpriseNotification>[];

  @override
  List<EnterpriseReport> getReports() => const <EnterpriseReport>[];

  @override
  List<EnterprisePhotoReport> getPhotoReports() => const <EnterprisePhotoReport>[];

  @override
  List<EnterpriseEquipment> getEquipment() => const <EnterpriseEquipment>[];

  @override
  List<EnterpriseVehicle> getVehicles() => const <EnterpriseVehicle>[];

  @override
  List<EnterpriseDrawing> getDrawings() => const <EnterpriseDrawing>[];

  @override
  List<EnterpriseWarehouseItem> getWarehouseItems() => const <EnterpriseWarehouseItem>[];

  @override
  List<EnterpriseCalendarEvent> getCalendarEvents() => const <EnterpriseCalendarEvent>[];
}
