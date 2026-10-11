import '../../tasks/domain/enums/task_priority.dart';

/// Что пользователь попросил у помощника.
sealed class AssistantIntent {
  const AssistantIntent();
}

/// Поставить одну или несколько задач.
class CreateTasksIntent extends AssistantIntent {
  const CreateTasksIntent({
    required this.assignee,
    required this.titles,
    required this.deadline,
    required this.priority,
    required this.project,
  });

  /// Имя исполнителя (как в списке сотрудников) или `null`, если не указан.
  final String? assignee;
  final List<String> titles;
  final DateTime? deadline;
  final TaskPriority priority;
  final String? project;
}

/// Показать задачи сотрудника (или свои, если [assignee] == `null`).
class ListTasksIntent extends AssistantIntent {
  const ListTasksIntent({required this.assignee, this.onlyOverdue = false});

  final String? assignee;
  final bool onlyOverdue;
}

/// Отметить задачу выполненной.
class CompleteTaskIntent extends AssistantIntent {
  const CompleteTaskIntent(this.query);

  final String query;
}

class ListProjectsIntent extends AssistantIntent {
  const ListProjectsIntent();
}

class ListEmployeesIntent extends AssistantIntent {
  const ListEmployeesIntent();
}

class SupportIntent extends AssistantIntent {
  const SupportIntent();
}

class HelpIntent extends AssistantIntent {
  const HelpIntent();
}

/// Помощник не понял запрос.
class UnknownIntent extends AssistantIntent {
  const UnknownIntent();
}

/// Разбирает русские команды без внешнего ИИ: ищет ключевые слова,
/// сотрудников, проекты и сроки в тексте.
class AssistantParser {
  AssistantParser({
    required this.employees,
    required this.projects,
    DateTime? now,
  }) : now = now ?? DateTime.now();

  /// Полные имена сотрудников компании.
  final List<String> employees;

  /// Названия проектов компании.
  final List<String> projects;

  final DateTime now;

  // В Dart `\b` не понимает кириллицу, поэтому границы слов задаём сами.
  static const _b = r'(?<![а-яёa-z0-9])';
  static const _e = r'(?![а-яёa-z0-9])';

  static final _createTrigger = RegExp(
    r'(постав|выстав|созда|добав|назнач|дай|дать|поруч|запиш|отправ|скин|перешл|прикреп)',
  );
  static final _taskWord = RegExp(r'задач|задани|поручени|список');
  static final _listTrigger = RegExp(
    r'(какие|какая|что|покажи|показать|список|скажи|расскажи|сколько|есть ли)',
  );
  static final _completeTrigger = RegExp(
    r'(выполнил|выполнена|выполнено|сделал|сделано|готово|закрой|заверш|отметь)',
  );

  AssistantIntent parse(String input, {bool hasPhoto = false}) {
    final text = input.trim();
    final lower = _normalize(text);

    if (lower.isEmpty) {
      return hasPhoto ? _createIntent(text, lower, hasPhoto: true) : const HelpIntent();
    }
    if (RegExp(r'^(помощь|помоги|что ты умеешь|команды|help|\?)').hasMatch(lower)) {
      return const HelpIntent();
    }
    if (RegExp(r'поддержк|техподдерж|оператор').hasMatch(lower)) {
      return const SupportIntent();
    }

    final isCreate = _createTrigger.hasMatch(lower) && (_taskWord.hasMatch(lower) || hasPhoto);
    if (isCreate) {
      return _createIntent(text, lower, hasPhoto: hasPhoto);
    }

    if (_completeTrigger.hasMatch(lower) && !_listTrigger.hasMatch(lower)) {
      final query = _stripWords(lower, _completeTrigger).replaceAll(RegExp(r'задач[ауи]?'), '').trim();
      if (query.length >= 3) {
        return CompleteTaskIntent(query);
      }
    }

    if (RegExp(r'проект').hasMatch(lower) && !_taskWord.hasMatch(lower)) {
      return const ListProjectsIntent();
    }
    if (RegExp(r'сотрудник|команд[аы]|работник|кто в компании').hasMatch(lower)) {
      return const ListEmployeesIntent();
    }

    final overdue = RegExp(r'просроч|опазд|горит|горящ').hasMatch(lower);
    final mine = RegExp('$_b(мои|мне|моих|мой|у меня)$_e').hasMatch(lower);
    final assignee = mine ? null : matchEmployee(lower);
    if (_taskWord.hasMatch(lower) || overdue || assignee != null || _listTrigger.hasMatch(lower)) {
      if (assignee != null || mine || overdue || _taskWord.hasMatch(lower)) {
        return ListTasksIntent(assignee: assignee, onlyOverdue: overdue);
      }
    }

    if (hasPhoto) {
      return _createIntent(text, lower, hasPhoto: true);
    }
    return const UnknownIntent();
  }

  CreateTasksIntent _createIntent(String text, String lower, {required bool hasPhoto}) {
    final assignee = matchEmployee(lower) ?? _fallbackAssignee(text);
    final deadline = parseDeadline(lower);
    final priority = RegExp(r'срочн|немедленн|сейчас же|критич').hasMatch(lower)
        ? TaskPriority.critical
        : RegExp(r'важн|приоритет').hasMatch(lower)
            ? TaskPriority.high
            : TaskPriority.medium;
    final project = _matchProject(lower);

    var titles = _extractTitles(text, assignee: assignee, project: project);
    if (titles.isEmpty && hasPhoto) {
      titles = <String>['Фото с объекта'];
    }
    return CreateTasksIntent(
      assignee: assignee,
      titles: titles,
      deadline: deadline,
      priority: priority,
      project: project,
    );
  }

  /// Находит сотрудника, упомянутого в тексте в любом падеже
  /// («Сулейманову Айдыну» → «Сулейманов Айдын»).
  String? matchEmployee(String lowerText) {
    final words = _words(lowerText);
    String? best;
    var bestScore = 0;
    for (final employee in employees) {
      var score = 0;
      for (final part in _words(_normalize(employee))) {
        if (part.length < 3) {
          continue;
        }
        if (words.any((String word) => _sameRoot(word, part))) {
          score++;
        }
      }
      if (score > bestScore) {
        bestScore = score;
        best = employee;
      }
    }
    return best;
  }

  String? _matchProject(String lowerText) {
    for (final project in projects) {
      final name = _normalize(project);
      if (name.length >= 3 && lowerText.contains(name)) {
        return project;
      }
    }
    final words = _words(lowerText);
    for (final project in projects) {
      final parts = _words(_normalize(project)).where((String p) => p.length >= 4).toList();
      if (parts.isNotEmpty && parts.every((String p) => words.any((String w) => _sameRoot(w, p)))) {
        return project;
      }
    }
    return null;
  }

  /// Если сотрудников ещё нет в базе, берём имя после «для/кому».
  String? _fallbackAssignee(String text) {
    final match = RegExp(
      r'(?:для|кому|сотруднику|рабочему)\s+([А-ЯЁA-Z][а-яёa-z-]+(?:\s+[А-ЯЁA-Z][а-яёa-z-]+)?)',
    ).firstMatch(text);
    return match?.group(1);
  }

  /// Срок задачи: «сегодня», «завтра», «в пятницу», «через 3 дня», «до 15.10».
  DateTime? parseDeadline(String lower) {
    final today = DateTime(now.year, now.month, now.day, 18);
    if (lower.contains('послезавтра')) {
      return today.add(const Duration(days: 2));
    }
    if (lower.contains('завтра')) {
      return today.add(const Duration(days: 1));
    }
    if (lower.contains('сегодня')) {
      return today;
    }
    final inDays = RegExp(r'через\s+(\d+)\s*(дн|день|дня)').firstMatch(lower);
    if (inDays != null) {
      return today.add(Duration(days: int.parse(inDays.group(1)!)));
    }
    if (RegExp(r'через\s+неделю|за неделю').hasMatch(lower)) {
      return today.add(const Duration(days: 7));
    }
    final date = RegExp(r'\b(\d{1,2})[./](\d{1,2})(?:[./](\d{2,4}))?\b').firstMatch(lower);
    if (date != null) {
      final day = int.parse(date.group(1)!);
      final month = int.parse(date.group(2)!);
      var year = date.group(3) == null ? now.year : int.parse(date.group(3)!);
      if (year < 100) {
        year += 2000;
      }
      if (day >= 1 && day <= 31 && month >= 1 && month <= 12) {
        var result = DateTime(year, month, day, 18);
        if (date.group(3) == null && result.isBefore(today)) {
          result = DateTime(year + 1, month, day, 18);
        }
        return result;
      }
    }
    const weekdays = <String, int>{
      'понедельник': DateTime.monday,
      'вторник': DateTime.tuesday,
      'сред': DateTime.wednesday,
      'четверг': DateTime.thursday,
      'пятниц': DateTime.friday,
      'суббот': DateTime.saturday,
      'воскресень': DateTime.sunday,
    };
    for (final entry in weekdays.entries) {
      if (lower.contains(entry.key)) {
        var diff = entry.value - today.weekday;
        if (diff <= 0) {
          diff += 7;
        }
        return today.add(Duration(days: diff));
      }
    }
    if (lower.contains('конца недели')) {
      return today.add(Duration(days: DateTime.friday - today.weekday < 0 ? 0 : DateTime.friday - today.weekday));
    }
    return null;
  }

  List<String> _extractTitles(String text, {String? assignee, String? project}) {
    var body = text;
    final colon = body.indexOf(':');
    if (colon != -1 && colon < body.length - 1) {
      body = body.substring(colon + 1);
    } else {
      final chtoby = RegExp(r'чтобы\s+(?:он|она|они)?\s*', caseSensitive: false).firstMatch(body);
      if (chtoby != null) {
        body = body.substring(chtoby.end);
      } else {
        body = _stripCommand(body, assignee: assignee, project: project);
      }
    }

    body = _stripDeadline(body);
    final parts = body
        .split(RegExp(r'\n|;|\s\d+[.)]\s|,\s*(?:а также|ещё|еще)?\s*'))
        .map((String part) => _cleanTitle(part))
        .where((String part) => part.length >= 3)
        .toList(growable: false);

    // Запятые делят на отдельные задачи только короткие перечисления.
    if (parts.length > 1 && parts.any((String p) => _words(p).length > 8)) {
      final single = _cleanTitle(body);
      return single.length >= 3 ? <String>[single] : const <String>[];
    }
    return parts;
  }

  static final _commandWord = RegExp(
    r'^(пожалуйста|помощник|бот|выстав|постав|созда|добав|назнач|поруч|запиш|отправ|скин|перешл|прикреп|дай$|дать$|эт[уоиа]$|этот$|фото|снимок|снимк|картинк|задач|задани|для$|кому$|сотрудник|срочн|немедленн|важн|нужно$|надо$|ему$|ей$|им$|мне$)',
  );

  String _stripCommand(String text, {String? assignee, String? project}) {
    final result = text.replaceAll(
      RegExp(r'в\s+список\s+задач[а-яё]*|в\s+задачи|по\s+проекту|на\s+проект[а-яё]*', caseSensitive: false),
      ' ',
    );
    final names = <String>[
      if (assignee != null) ..._words(_normalize(assignee)),
      if (project != null) ..._words(_normalize(project)),
    ];
    final kept = _wordsKeepCase(result).where((String word) {
      final lower = _normalize(word).replaceAll(RegExp(r'[^а-яa-z0-9-]'), '');
      if (lower.isEmpty || _commandWord.hasMatch(lower)) {
        return false;
      }
      return !names.any((String part) => part.length >= 3 && _sameRoot(lower, part));
    });
    return kept.join(' ');
  }

  String _stripDeadline(String text) {
    return text.replaceAll(
      RegExp(
        '$_b(?:(?:до|к|на|в|во)\\s+)?(?:сегодня|завтра|послезавтра|понедельник[а-яё]*|вторник[а-яё]*|сред[уы]|четверг[а-яё]*|пятниц[а-яё]*|суббот[а-яё]*|воскресень[а-яё]*|конца недели)$_e'
        '|через\\s+\\d+\\s*[а-я]+|через\\s+неделю'
        '|$_b(?:до|к)\\s+\\d{1,2}[./]\\d{1,2}(?:[./]\\d{2,4})?',
        caseSensitive: false,
      ),
      ' ',
    );
  }

  String _cleanTitle(String text) {
    var result = text.replaceAll(RegExp(r'\s+'), ' ').trim();
    result = result.replaceAll(RegExp(r'^[-–—,.:;\d)]+\s*'), '').replaceAll(RegExp(r'[,.;:\s]+$'), '');
    result = result.replaceAll(RegExp(r'^(и|а|то есть|что|чтобы)\s+', caseSensitive: false), '');
    if (result.isEmpty) {
      return result;
    }
    return result[0].toUpperCase() + result.substring(1);
  }

  static String _normalize(String text) => text.toLowerCase().replaceAll('ё', 'е');

  static List<String> _words(String lower) => lower
      .split(RegExp(r'[^a-zа-я0-9-]+'))
      .where((String word) => word.isNotEmpty)
      .toList(growable: false);

  static List<String> _wordsKeepCase(String text) => text
      .split(RegExp(r'\s+'))
      .where((String word) => word.isNotEmpty)
      .toList(growable: false);

  static String _stripWords(String lower, RegExp pattern) =>
      _words(lower).where((String w) => !pattern.hasMatch(w)).join(' ');

  /// Слова одного корня с учётом падежных окончаний.
  static bool _sameRoot(String word, String namePart) {
    if (word == namePart) {
      return true;
    }
    final stemLength = namePart.length <= 4 ? namePart.length - 1 : namePart.length - 2;
    if (stemLength < 3 || word.length < stemLength) {
      return false;
    }
    return word.startsWith(namePart.substring(0, stemLength)) &&
        (word.length - stemLength) <= 4;
  }
}
