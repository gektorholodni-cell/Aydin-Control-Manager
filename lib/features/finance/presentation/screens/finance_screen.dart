import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/localization/context_l10n.dart';

enum _FinanceType { income, expense }

enum _PaymentMethod { cash, card, wallet }

enum _FinanceCurrency { kzt, usd, eur }

enum _ExpenseCategory {
  fuel,
  materials,
  workers,
  equipment,
  transport,
  food,
  accommodation,
  tools,
  other,
}

class _FinanceEntry {
  const _FinanceEntry({
    required this.id,
    required this.type,
    required this.amount,
    required this.category,
    required this.project,
    required this.description,
    required this.date,
    required this.method,
    required this.receipt,
  });

  final String id;
  final _FinanceType type;
  final double amount;
  final _ExpenseCategory category;
  final String project;
  final String description;
  final DateTime date;
  final _PaymentMethod method;
  final String receipt;

  _FinanceEntry copyWith({
    _FinanceType? type,
    double? amount,
    _ExpenseCategory? category,
    String? project,
    String? description,
    DateTime? date,
    _PaymentMethod? method,
    String? receipt,
  }) {
    return _FinanceEntry(
      id: id,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      project: project ?? this.project,
      description: description ?? this.description,
      date: date ?? this.date,
      method: method ?? this.method,
      receipt: receipt ?? this.receipt,
    );
  }
}

class _FinanceUser {
  const _FinanceUser({required this.id, required this.displayName});

  final String id;
  final String displayName;
}

class _FinanceLedger {
  _FinanceLedger({
    required this.cashKzt,
    required this.cardKzt,
    required this.walletKzt,
    required this.entries,
  });

  double cashKzt;
  double cardKzt;
  double walletKzt;
  List<_FinanceEntry> entries;
}

class FinanceScreen extends StatefulWidget {
  const FinanceScreen({super.key});

  @override
  State<FinanceScreen> createState() => _FinanceScreenState();
}

class _FinanceScreenState extends State<FinanceScreen> {
  String _searchQuery = '';
  int _searchFieldRevision = 0;

  static const _usdRate = 470.0;
  static const _eurRate = 510.0;

  final List<_FinanceUser> _users = const <_FinanceUser>[
    _FinanceUser(id: 'u1', displayName: 'Пользователь 1'),
    _FinanceUser(id: 'u2', displayName: 'Пользователь 2'),
    _FinanceUser(id: 'u3', displayName: 'Пользователь 3'),
  ];

  late final Map<String, _FinanceLedger> _ledgers;
  String _activeUserId = 'u1';
  _FinanceCurrency _currency = _FinanceCurrency.kzt;

  _ExpenseCategory? _categoryFilter;
  _PaymentMethod? _methodFilter;
  String? _projectFilter;

  @override
  void initState() {
    super.initState();
    _ledgers = <String, _FinanceLedger>{
      'u1': _FinanceLedger(
        cashKzt: 0,
        cardKzt: 0,
        walletKzt: 0,
        entries: <_FinanceEntry>[],
      ),
      'u2': _FinanceLedger(
        cashKzt: 0,
        cardKzt: 0,
        walletKzt: 0,
        entries: <_FinanceEntry>[],
      ),
      'u3': _FinanceLedger(
        cashKzt: 0,
        cardKzt: 0,
        walletKzt: 0,
        entries: <_FinanceEntry>[],
      ),
    };
  }

  _FinanceLedger get _activeLedger => _ledgers[_activeUserId]!;

  double _currencyRate(_FinanceCurrency currency) {
    switch (currency) {
      case _FinanceCurrency.kzt:
        return 1;
      case _FinanceCurrency.usd:
        return _usdRate;
      case _FinanceCurrency.eur:
        return _eurRate;
    }
  }

  String _currencySymbol(_FinanceCurrency currency) {
    switch (currency) {
      case _FinanceCurrency.kzt:
        return '₸';
      case _FinanceCurrency.usd:
        return r'$';
      case _FinanceCurrency.eur:
        return 'EUR';
    }
  }

  String _currencyLabel(BuildContext context, _FinanceCurrency currency) {
    final l10n = context.l10n;
    switch (currency) {
      case _FinanceCurrency.kzt:
        return l10n.financeCurrencyKzt;
      case _FinanceCurrency.usd:
        return l10n.financeCurrencyUsd;
      case _FinanceCurrency.eur:
        return l10n.financeCurrencyEur;
    }
  }

  double _fromKzt(double kztAmount) => kztAmount / _currencyRate(_currency);

  double _toKzt(double amountInSelectedCurrency) => amountInSelectedCurrency * _currencyRate(_currency);

  String _money(double amountKzt) {
    final displayValue = _fromKzt(amountKzt);
    final formatted = NumberFormat('#,##0.00').format(displayValue);
    return '${_currencySymbol(_currency)} $formatted';
  }

  List<_FinanceEntry> _filteredEntries() {
    final entries = _activeLedger.entries;
    final query = _searchQuery.trim().toLowerCase();

    return entries.where((entry) {
      if (_categoryFilter != null && entry.category != _categoryFilter) {
        return false;
      }
      if (_methodFilter != null && entry.method != _methodFilter) {
        return false;
      }
      if (_projectFilter != null && entry.project != _projectFilter) {
        return false;
      }
      if (query.isNotEmpty) {
        final haystack = '${entry.description} ${entry.project} ${_categoryLabel(context, entry.category)}'
            .toLowerCase();
        if (!haystack.contains(query)) {
          return false;
        }
      }
      return true;
    }).toList(growable: false)
      ..sort((a, b) => b.date.compareTo(a.date));
  }

  double _totalBy(_FinanceType type) {
    return _activeLedger.entries
        .where((entry) => entry.type == type)
        .fold<double>(0, (sum, entry) => sum + entry.amount);
  }

  double _weeklyExpenses() {
    final now = DateTime.now();
    final weekAgo = now.subtract(const Duration(days: 7));
    return _activeLedger.entries
        .where((entry) => entry.type == _FinanceType.expense && entry.date.isAfter(weekAgo))
        .fold<double>(0, (sum, entry) => sum + entry.amount);
  }

  double _monthlyExpenses() {
    final now = DateTime.now();
    return _activeLedger.entries
        .where(
          (entry) =>
              entry.type == _FinanceType.expense &&
              entry.date.year == now.year &&
              entry.date.month == now.month,
        )
        .fold<double>(0, (sum, entry) => sum + entry.amount);
  }

  Future<void> _openEntryDialog({_FinanceEntry? existing}) async {
    final l10n = context.l10n;
    String amountText = existing == null ? '' : _fromKzt(existing.amount).toStringAsFixed(2);
    String projectText = existing?.project ?? '';
    String descriptionText = existing?.description ?? '';
    String receiptText = existing?.receipt ?? l10n.financeReceiptDefaultValue;

    _FinanceType selectedType = existing?.type ?? _FinanceType.expense;
    _ExpenseCategory selectedCategory = existing?.category ?? _ExpenseCategory.materials;
    _PaymentMethod selectedMethod = existing?.method ?? _PaymentMethod.cash;
    DateTime selectedDate = existing?.date ?? DateTime.now();

    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setLocalState) {
            return AlertDialog(
              title: Text(existing == null ? l10n.financeDialogAddTitle : l10n.financeDialogEditTitle),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SegmentedButton<_FinanceType>(
                      segments: <ButtonSegment<_FinanceType>>[
                        ButtonSegment<_FinanceType>(
                          value: _FinanceType.expense,
                          label: Text(l10n.financeTypeExpense),
                        ),
                        ButtonSegment<_FinanceType>(
                          value: _FinanceType.income,
                          label: Text(l10n.financeTypeIncome),
                        ),
                      ],
                      selected: <_FinanceType>{selectedType},
                      onSelectionChanged: (value) {
                        setLocalState(() {
                          selectedType = value.first;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      initialValue: amountText,
                      onChanged: (value) => amountText = value,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(labelText: l10n.financeFieldAmount),
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<_ExpenseCategory>(
                      initialValue: selectedCategory,
                      decoration: InputDecoration(labelText: l10n.financeFieldCategory),
                      items: _ExpenseCategory.values
                          .map(
                            (value) => DropdownMenuItem<_ExpenseCategory>(
                              value: value,
                              child: Text(_categoryLabel(context, value)),
                            ),
                          )
                          .toList(growable: false),
                      onChanged: (value) {
                        if (value != null) {
                          setLocalState(() {
                            selectedCategory = value;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      initialValue: projectText,
                      onChanged: (value) => projectText = value,
                      decoration: InputDecoration(labelText: l10n.commonProject),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      initialValue: descriptionText,
                      onChanged: (value) => descriptionText = value,
                      decoration: InputDecoration(labelText: l10n.commonDescription),
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<_PaymentMethod>(
                      initialValue: selectedMethod,
                      decoration: InputDecoration(labelText: l10n.financeFieldPaymentMethod),
                      items: _PaymentMethod.values
                          .map(
                            (value) => DropdownMenuItem<_PaymentMethod>(
                              value: value,
                              child: Text(_paymentLabel(value)),
                            ),
                          )
                          .toList(growable: false),
                      onChanged: (value) {
                        if (value != null) {
                          setLocalState(() {
                            selectedMethod = value;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      initialValue: receiptText,
                      onChanged: (value) => receiptText = value,
                      decoration: InputDecoration(labelText: l10n.financeFieldReceipt),
                    ),
                    const SizedBox(height: 10),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.calendar_today_outlined),
                      title: Text(DateFormat.yMMMd().format(selectedDate)),
                      onTap: () async {
                        final result = await showDatePicker(
                          context: context,
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2030),
                          initialDate: selectedDate,
                        );
                        if (result != null) {
                          setLocalState(() {
                            selectedDate = result;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(l10n.commonCancel),
                ),
                FilledButton(
                  onPressed: () {
                    final amount = double.tryParse(amountText.trim().replaceAll(',', '.'));
                    if (amount == null || amount <= 0 || projectText.trim().isEmpty) {
                      ScaffoldMessenger.of(this.context).showSnackBar(
                        SnackBar(content: Text(this.context.l10n.validationRequired)),
                      );
                      return;
                    }

                    final newEntry = _FinanceEntry(
                      id: existing?.id ?? 'f${DateTime.now().microsecondsSinceEpoch}',
                      type: selectedType,
                      amount: _toKzt(amount),
                      category: selectedCategory,
                      project: projectText.trim(),
                      description: descriptionText.trim(),
                      date: selectedDate,
                      method: selectedMethod,
                      receipt: receiptText.trim(),
                    );

                    setState(() {
                      final ledger = _activeLedger;
                      if (existing == null) {
                        ledger.entries = <_FinanceEntry>[newEntry, ...ledger.entries];
                      } else {
                        ledger.entries = ledger.entries
                            .map((entry) => entry.id == existing.id ? newEntry : entry)
                            .toList(growable: false);
                      }
                    });

                    Navigator.pop(context);
                  },
                  child: Text(existing == null ? l10n.commonAdd : l10n.commonSave),
                ),
              ],
            );
          },
        );
      },
    );

  }

  Future<void> _editBalances() async {
    final l10n = context.l10n;
    final ledger = _activeLedger;
    String cashText = _fromKzt(ledger.cashKzt).toStringAsFixed(2);
    String cardText = _fromKzt(ledger.cardKzt).toStringAsFixed(2);
    String walletText = _fromKzt(ledger.walletKzt).toStringAsFixed(2);

    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.financeAccountEditTitle),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
              initialValue: cashText,
              onChanged: (value) => cashText = value,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(labelText: l10n.financeMetricCash),
            ),
            const SizedBox(height: 8),
            TextFormField(
              initialValue: cardText,
              onChanged: (value) => cardText = value,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(labelText: l10n.financeMetricCard),
            ),
            const SizedBox(height: 8),
            TextFormField(
              initialValue: walletText,
              onChanged: (value) => walletText = value,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(labelText: l10n.financeMetricWallet),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(onPressed: () => Navigator.pop(context), child: Text(l10n.commonCancel)),
          FilledButton(
            onPressed: () {
              final cash = double.tryParse(cashText.trim().replaceAll(',', '.'));
              final card = double.tryParse(cardText.trim().replaceAll(',', '.'));
              final wallet = double.tryParse(walletText.trim().replaceAll(',', '.'));
              if (cash == null || card == null || wallet == null) {
                return;
              }
              setState(() {
                ledger
                  ..cashKzt = _toKzt(cash)
                  ..cardKzt = _toKzt(card)
                  ..walletKzt = _toKzt(wallet);
              });
              Navigator.pop(context);
            },
            child: Text(l10n.commonSave),
          ),
        ],
      ),
    );

  }

  String _paymentLabel(_PaymentMethod method) {
    switch (method) {
      case _PaymentMethod.cash:
        return context.l10n.financePaymentCash;
      case _PaymentMethod.card:
        return context.l10n.financePaymentCard;
      case _PaymentMethod.wallet:
        return context.l10n.financePaymentWallet;
    }
  }

  static String _categoryLabel(BuildContext context, _ExpenseCategory category) {
    final l10n = context.l10n;
    switch (category) {
      case _ExpenseCategory.fuel:
        return l10n.financeFuelLabel;
      case _ExpenseCategory.materials:
        return l10n.financeMaterialsLabel;
      case _ExpenseCategory.workers:
        return l10n.financeWorkersLabel;
      case _ExpenseCategory.equipment:
        return l10n.financeEquipmentLabel;
      case _ExpenseCategory.transport:
        return l10n.financeTransportLabel;
      case _ExpenseCategory.food:
        return l10n.financeFoodLabel;
      case _ExpenseCategory.accommodation:
        return l10n.financeAccommodationLabel;
      case _ExpenseCategory.tools:
        return l10n.financeToolsLabel;
      case _ExpenseCategory.other:
        return l10n.financeOtherLabel;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final ledger = _activeLedger;
    final entries = _filteredEntries();
    final income = _totalBy(_FinanceType.income);
    final expenses = _totalBy(_FinanceType.expense);
    final personalBalance = ledger.cashKzt + ledger.cardKzt + ledger.walletKzt;
    final remaining = income - expenses;
    final projects = ledger.entries.map((e) => e.project).toSet().toList(growable: false)..sort();
    final selectedProjectFilter = projects.contains(_projectFilter) ? _projectFilter : null;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.financeTitle),
        actions: <Widget>[
          PopupMenuButton<_FinanceCurrency>(
            initialValue: _currency,
            onSelected: (value) {
              setState(() {
                _currency = value;
              });
            },
            tooltip: l10n.financeCurrencyLabel,
            itemBuilder: (BuildContext context) {
              return _FinanceCurrency.values
                  .map(
                    (value) => PopupMenuItem<_FinanceCurrency>(
                      value: value,
                      child: Text(_currencyLabel(context, value)),
                    ),
                  )
                  .toList(growable: false);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Center(
                child: Text(
                  _currencyLabel(context, _currency),
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: _editBalances,
            icon: const Icon(Icons.edit_outlined),
            tooltip: l10n.financeAccountEditTitle,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openEntryDialog(),
        icon: const Icon(Icons.add),
        label: Text(l10n.financeAddEntryButton),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final content = ListView(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 96),
            children: <Widget>[
          _SectionCard(
            title: l10n.financeSectionAccessControl,
            child: Column(
              children: <Widget>[
                DropdownButtonFormField<String>(
                  key: ValueKey<String>(_activeUserId),
                  isExpanded: true,
                  initialValue: _activeUserId,
                  decoration: InputDecoration(labelText: l10n.financeActiveUserLabel),
                  items: _users
                      .map(
                        (user) => DropdownMenuItem<String>(
                          value: user.id,
                          child: Text(user.displayName),
                        ),
                      )
                      .toList(growable: false),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      _activeUserId = value;
                      _searchQuery = '';
                      _searchFieldRevision++;
                      _projectFilter = null;
                      _methodFilter = null;
                      _categoryFilter = null;
                    });
                  },
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<_FinanceCurrency>(
                  isExpanded: true,
                  initialValue: _currency,
                  decoration: InputDecoration(labelText: l10n.financeCurrencyLabel),
                  items: _FinanceCurrency.values
                      .map(
                        (value) => DropdownMenuItem<_FinanceCurrency>(
                          value: value,
                          child: Text(_currencyLabel(context, value)),
                        ),
                      )
                      .toList(growable: false),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      _currency = value;
                    });
                  },
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    l10n.financePrivacyNote,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          _SectionCard(
            title: l10n.financeSectionPersonalAccount,
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                _MetricChip(label: l10n.financeMetricPersonalBalance, value: _money(personalBalance)),
                _MetricChip(label: l10n.financeMetricCash, value: _money(ledger.cashKzt)),
                _MetricChip(label: l10n.financeMetricCard, value: _money(ledger.cardKzt)),
                _MetricChip(label: l10n.financeMetricWallet, value: _money(ledger.walletKzt)),
                _MetricChip(label: l10n.financeIncome, value: _money(income)),
                _MetricChip(label: l10n.financeExpensesLabel, value: _money(expenses)),
                _MetricChip(label: l10n.financeMetricRemainingBalance, value: _money(remaining)),
              ],
            ),
          ),
          const SizedBox(height: 10),
          _SectionCard(
            title: l10n.financeSectionStatistics,
            child: Column(
              children: <Widget>[
                _SimpleStatRow(label: l10n.financeStatTotalIncome, value: _money(income)),
                _SimpleStatRow(label: l10n.financeStatTotalExpenses, value: _money(expenses)),
                _SimpleStatRow(label: l10n.financeMetricRemainingBalance, value: _money(remaining)),
                _SimpleStatRow(label: l10n.financeStatMonthlyExpenses, value: _money(_monthlyExpenses())),
                _SimpleStatRow(label: l10n.financeStatWeeklyExpenses, value: _money(_weeklyExpenses())),
              ],
            ),
          ),
          const SizedBox(height: 10),
          _SectionCard(
            title: l10n.financeSectionSearchFilters,
            child: Column(
              children: <Widget>[
                TextField(
                  key: ValueKey<int>(_searchFieldRevision),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: l10n.financeSearchHint,
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<_ExpenseCategory?>(
                  isExpanded: true,
                  initialValue: _categoryFilter,
                  decoration: InputDecoration(labelText: l10n.financeFilterCategory),
                  items: <DropdownMenuItem<_ExpenseCategory?>>[
                    DropdownMenuItem<_ExpenseCategory?>(value: null, child: Text(l10n.financeAllCategories)),
                    ..._ExpenseCategory.values.map(
                      (category) => DropdownMenuItem<_ExpenseCategory?>(
                        value: category,
                        child: Text(_categoryLabel(context, category)),
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _categoryFilter = value;
                    });
                  },
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<_PaymentMethod?>(
                  isExpanded: true,
                  initialValue: _methodFilter,
                  decoration: InputDecoration(labelText: l10n.financeFilterPaymentMethod),
                  items: <DropdownMenuItem<_PaymentMethod?>>[
                    DropdownMenuItem<_PaymentMethod?>(value: null, child: Text(l10n.financeAllMethods)),
                    ..._PaymentMethod.values.map(
                      (method) => DropdownMenuItem<_PaymentMethod?>(
                        value: method,
                        child: Text(_paymentLabel(method)),
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _methodFilter = value;
                    });
                  },
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String?>(
                  isExpanded: true,
                  initialValue: selectedProjectFilter,
                  decoration: InputDecoration(labelText: l10n.financeFilterProject),
                  selectedItemBuilder: (BuildContext context) => <Widget>[
                    Text(l10n.financeAllProjects, overflow: TextOverflow.ellipsis),
                    ...projects.map((project) => Text(project, overflow: TextOverflow.ellipsis)),
                  ],
                  items: <DropdownMenuItem<String?>>[
                    DropdownMenuItem<String?>(value: null, child: Text(l10n.financeAllProjects)),
                    ...projects.map(
                      (project) => DropdownMenuItem<String?>(
                        value: project,
                        child: Text(project),
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _projectFilter = value;
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            l10n.financeExpenseHistory,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          if (entries.isEmpty)
            Card(
              child: ListTile(
                leading: const Icon(Icons.info_outline),
                title: Text(l10n.financeNoEntries),
              ),
            )
          else
            ...entries.map(
              (entry) => Card(
                child: ListTile(
                  title: Text(entry.description.isEmpty ? entry.project : entry.description),
                  subtitle: Text(
                    '${entry.project} • ${_categoryLabel(context, entry.category)} • ${DateFormat.yMMMd().format(entry.date)}\n'
                    '${_paymentLabel(entry.method)} • ${entry.receipt}',
                  ),
                  isThreeLine: true,
                  trailing: PopupMenuButton<String>(
                    onSelected: (action) {
                      if (action == 'edit') {
                        _openEntryDialog(existing: entry);
                      } else if (action == 'delete') {
                        setState(() {
                          ledger.entries =
                              ledger.entries.where((item) => item.id != entry.id).toList(growable: false);
                        });
                      }
                    },
                    itemBuilder: (context) => <PopupMenuEntry<String>>[
                      PopupMenuItem<String>(value: 'edit', child: Text(l10n.commonEdit)),
                      PopupMenuItem<String>(value: 'delete', child: Text(l10n.commonDelete)),
                    ],
                  ),
                  leading: CircleAvatar(
                    child: Icon(
                      entry.type == _FinanceType.income
                          ? Icons.trending_up_outlined
                          : Icons.trending_down_outlined,
                    ),
                  ),
                ),
              ),
            ),
            ],
          );

          if (constraints.maxWidth < 900) {
            return content;
          }

          return Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 980),
              child: content,
            ),
          );
        },
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),
            child,
          ],
        ),
      ),
    );
  }
}

class _MetricChip extends StatelessWidget {
  const _MetricChip({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 150),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Theme.of(context).colorScheme.surfaceContainerLow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(value, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
          Text(label, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}

class _SimpleStatRow extends StatelessWidget {
  const _SimpleStatRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: <Widget>[
          Expanded(child: Text(label)),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
        ],
      ),
    );
  }
}
