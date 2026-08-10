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

class MockEnterpriseRepository implements EnterpriseRepository {
  const MockEnterpriseRepository();

  @override
  List<EnterpriseUser> getUsers() => const <EnterpriseUser>[
        EnterpriseUser(
          id: 'u1',
          fullName: 'Aruzhan Tolegen',
          position: 'Project Manager',
          departmentId: 'd1',
          teamId: 't1',
          isOnline: true,
        ),
        EnterpriseUser(
          id: 'u2',
          fullName: 'Daniyar Sarsen',
          position: 'Site Engineer',
          departmentId: 'd2',
          teamId: 't2',
          isOnline: false,
        ),
      ];

  @override
  List<EnterpriseCompany> getCompanies() => const <EnterpriseCompany>[
        EnterpriseCompany(
          id: 'c1',
          name: 'Aydin Control Manager Group',
          address: 'Almaty, Satpayev St. 88',
          phone: '+7 777 450 22 11',
          email: 'enterprise@aydin-control.com',
        ),
      ];

  @override
  List<EnterpriseDepartment> getDepartments() => const <EnterpriseDepartment>[
        EnterpriseDepartment(id: 'd1', companyId: 'c1', name: 'Project Office'),
        EnterpriseDepartment(id: 'd2', companyId: 'c1', name: 'Site Operations'),
      ];

  @override
  List<EnterpriseTeam> getTeams() => const <EnterpriseTeam>[
        EnterpriseTeam(id: 't1', departmentId: 'd1', name: 'PM Team'),
        EnterpriseTeam(id: 't2', departmentId: 'd2', name: 'Field Team'),
      ];

  @override
  List<EnterpriseProject> getProjects() => const <EnterpriseProject>[
        EnterpriseProject(id: 'p1', name: 'Skyline Tower A', client: 'Apex Group', progress: 0.72),
        EnterpriseProject(id: 'p2', name: 'Central Mall Extension', client: 'Urban Retail', progress: 0.54),
      ];

  @override
  List<EnterpriseTask> getTasks() => <EnterpriseTask>[
        EnterpriseTask(
          id: 't-1',
          projectId: 'p1',
          title: 'Facade inspection',
          assignee: 'Daniyar Sarsen',
          deadline: DateTime(2026, 7, 28),
          status: 'In Progress',
        ),
        EnterpriseTask(
          id: 't-2',
          projectId: 'p2',
          title: 'Rebar delivery check',
          assignee: 'Aruzhan Tolegen',
          deadline: DateTime(2026, 7, 29),
          status: 'Planned',
        ),
      ];

  @override
  List<EnterpriseChat> getChats() => const <EnterpriseChat>[
        EnterpriseChat(id: 'ch1', title: 'Skyline Site', lastMessage: 'Concrete test attached.'),
        EnterpriseChat(id: 'ch2', title: 'Finance Team', lastMessage: 'Budget variance reviewed.'),
      ];

  @override
  List<EnterpriseMessage> getMessages() => <EnterpriseMessage>[
        EnterpriseMessage(
          id: 'm1',
          chatId: 'ch1',
          author: 'Aruzhan',
          text: 'Please check the inspection checklist.',
          createdAt: DateTime(2026, 7, 26, 10, 20),
        ),
      ];

  @override
  List<EnterpriseFinanceRecord> getFinanceRecords() => <EnterpriseFinanceRecord>[
        EnterpriseFinanceRecord(
          id: 'f1',
          projectId: 'p1',
          type: 'Expense',
          amount: 41230,
          createdAt: DateTime(2026, 7, 25),
        ),
      ];

  @override
  List<EnterpriseDocument> getDocuments() => const <EnterpriseDocument>[
        EnterpriseDocument(
          id: 'doc1',
          projectId: 'p1',
          title: 'Facade specification',
          category: 'Specification',
          version: 'v2.1',
        ),
      ];

  @override
  List<EnterpriseNotification> getNotifications() => const <EnterpriseNotification>[
        EnterpriseNotification(id: 'n1', type: 'Task', title: 'New task assigned', isUnread: true),
        EnterpriseNotification(id: 'n2', type: 'System', title: 'Policy updated', isUnread: false),
      ];

  @override
  List<EnterpriseReport> getReports() => <EnterpriseReport>[
        EnterpriseReport(id: 'r1', type: 'Daily', title: 'Daily site report', createdAt: DateTime(2026, 7, 26)),
        EnterpriseReport(id: 'r2', type: 'Weekly', title: 'Weekly safety report', createdAt: DateTime(2026, 7, 25)),
      ];

  @override
  List<EnterprisePhotoReport> getPhotoReports() => const <EnterprisePhotoReport>[
        EnterprisePhotoReport(id: 'pr1', projectId: 'p1', title: 'Tower A progress', photosCount: 24),
      ];

  @override
  List<EnterpriseEquipment> getEquipment() => <EnterpriseEquipment>[
        EnterpriseEquipment(
          id: 'eq1',
          name: 'Crawler Crane',
          serialNumber: 'CRN-7742',
          status: 'Active',
          assignedProject: 'Skyline Tower A',
          assignedEmployee: 'Daniyar Sarsen',
          maintenanceDate: DateTime(2026, 8, 3),
        ),
      ];

  @override
  List<EnterpriseVehicle> getVehicles() => <EnterpriseVehicle>[
        EnterpriseVehicle(
          id: 'v1',
          vehicle: 'Toyota Hilux',
          driver: 'Nursultan Ermek',
          mileageKm: 128400,
          fuelLevel: '62%',
          status: 'On Route',
          maintenanceDate: DateTime(2026, 8, 11),
        ),
      ];

  @override
  List<EnterpriseDrawing> getDrawings() => <EnterpriseDrawing>[
        EnterpriseDrawing(
          id: 'dr1',
          category: 'DWG',
          title: 'Level 18 reinforcement',
          project: 'Skyline Tower A',
          version: 'R3',
          date: DateTime(2026, 7, 24),
          author: 'Aigerim Bakyt',
          status: 'Approved',
        ),
        EnterpriseDrawing(
          id: 'dr2',
          category: 'PDF',
          title: 'Electrical riser scheme',
          project: 'Central Mall Extension',
          version: 'R1',
          date: DateTime(2026, 7, 23),
          author: 'Daniyar Sarsen',
          status: 'Draft',
        ),
      ];

  @override
  List<EnterpriseWarehouseItem> getWarehouseItems() => const <EnterpriseWarehouseItem>[
        EnterpriseWarehouseItem(
          id: 'w1',
          category: 'Materials',
          name: 'Cement M500',
          currentQuantity: 320,
          minimumQuantity: 120,
          incoming: 80,
          outgoing: 45,
        ),
        EnterpriseWarehouseItem(
          id: 'w2',
          category: 'Tools',
          name: 'Power drill set',
          currentQuantity: 24,
          minimumQuantity: 12,
          incoming: 4,
          outgoing: 2,
        ),
      ];

  @override
  List<EnterpriseCalendarEvent> getCalendarEvents() => <EnterpriseCalendarEvent>[
        EnterpriseCalendarEvent(
          id: 'ce1',
          scope: 'Task Schedule',
          title: 'Facade inspection task',
          date: DateTime(2026, 7, 27, 10, 0),
        ),
        EnterpriseCalendarEvent(
          id: 'ce2',
          scope: 'Meeting',
          title: 'Weekly PM synchronization',
          date: DateTime(2026, 7, 28, 15, 30),
        ),
      ];
}
