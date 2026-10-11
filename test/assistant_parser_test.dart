import 'package:flutter_test/flutter_test.dart';

import 'package:structra/features/assistant/domain/assistant_parser.dart';
import 'package:structra/features/tasks/domain/enums/task_priority.dart';

void main() {
  // Суббота, 10 октября 2026.
  final now = DateTime(2026, 10, 10, 9);
  AssistantParser parser() => AssistantParser(
        employees: const <String>['Сулейманов Айдын', 'Иванов Пётр', 'Ахметова Дана'],
        projects: const <String>['ЖК Нурлы', 'Склад Алатау'],
        now: now,
      );

  test('creates a task for an employee named in any case', () {
    final intent = parser().parse(
      'Выставь задачу для Сулейманова Айдына: проверить вентиляцию до пятницы',
    ) as CreateTasksIntent;

    expect(intent.assignee, 'Сулейманов Айдын');
    expect(intent.titles, <String>['Проверить вентиляцию']);
    expect(intent.deadline, DateTime(2026, 10, 16, 18));
  });

  test('splits a list into several tasks', () {
    final intent = parser().parse(
      'Поставь задачи Сулейманову Айдыну: замерить трубы; заказать материалы; сделать фото фасада',
    ) as CreateTasksIntent;

    expect(intent.assignee, 'Сулейманов Айдын');
    expect(intent.titles, <String>['Замерить трубы', 'Заказать материалы', 'Сделать фото фасада']);
  });

  test('task without colon keeps the action as the title', () {
    final intent = parser().parse('поставь Иванову срочно задачу залить бетон завтра')
        as CreateTasksIntent;

    expect(intent.assignee, 'Иванов Пётр');
    expect(intent.titles, <String>['Залить бетон']);
    expect(intent.priority, TaskPriority.critical);
    expect(intent.deadline, DateTime(2026, 10, 11, 18));
  });

  test('photo sent to someone becomes a task', () {
    final intent = parser().parse(
      'отправь эту фотографию в список задач для Ахметовой Даны',
      hasPhoto: true,
    ) as CreateTasksIntent;

    expect(intent.assignee, 'Ахметова Дана');
    expect(intent.titles, <String>['Фото с объекта']);
  });

  test('project is recognised in a task', () {
    final intent = parser().parse('добавь задачу Иванову по проекту ЖК Нурлы: проверить кровлю')
        as CreateTasksIntent;

    expect(intent.project, 'ЖК Нурлы');
    expect(intent.titles, <String>['Проверить кровлю']);
  });

  test('asks for an employee tasks', () {
    final intent = parser().parse('Скажи по Сулейманову Айдыну, какие сейчас задачи');

    expect(intent, isA<ListTasksIntent>());
    expect((intent as ListTasksIntent).assignee, 'Сулейманов Айдын');
  });

  test('my tasks and overdue tasks', () {
    final mine = parser().parse('мои задачи') as ListTasksIntent;
    expect(mine.assignee, isNull);

    final overdue = parser().parse('покажи просроченные') as ListTasksIntent;
    expect(overdue.onlyOverdue, isTrue);
  });

  test('other commands', () {
    expect(parser().parse('покажи проекты'), isA<ListProjectsIntent>());
    expect(parser().parse('сотрудники'), isA<ListEmployeesIntent>());
    expect(parser().parse('помощь'), isA<HelpIntent>());
    expect(parser().parse('техподдержка'), isA<SupportIntent>());
    expect(parser().parse('выполнил замер труб'), isA<CompleteTaskIntent>());
    expect(parser().parse('привет как дела'), isA<UnknownIntent>());
  });

  test('deadline formats', () {
    final p = parser();
    expect(p.parseDeadline('через 3 дня'), DateTime(2026, 10, 13, 18));
    expect(p.parseDeadline('до 15.10'), DateTime(2026, 10, 15, 18));
    expect(p.parseDeadline('послезавтра'), DateTime(2026, 10, 12, 18));
  });
}
