import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/backend/cloud_backend.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../core/localization/context_l10n.dart';

/// Первый вход: создать свою компанию или присоединиться к существующей
/// по коду приглашения от руководителя.
class CompanySetupScreen extends StatefulWidget {
  const CompanySetupScreen({super.key});

  @override
  State<CompanySetupScreen> createState() => _CompanySetupScreenState();
}

enum _SetupMode { create, join }

class _CompanySetupScreenState extends State<CompanySetupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _companyNameController = TextEditingController();
  final _inviteCodeController = TextEditingController();

  _SetupMode _mode = _SetupMode.create;
  String _role = 'director';
  bool _isSaving = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _companyNameController.dispose();
    _inviteCodeController.dispose();
    super.dispose();
  }

  void _setMode(_SetupMode mode) {
    setState(() {
      _mode = mode;
      _role = mode == _SetupMode.create ? 'director' : 'siteEngineer';
    });
  }

  Future<void> _submit() async {
    if (_isSaving || !_formKey.currentState!.validate()) {
      return;
    }
    setState(() => _isSaving = true);

    final backend = CloudBackend.instance;
    try {
      final fullName = _fullNameController.text.trim();
      final membership = _mode == _SetupMode.create
          ? await backend.createCompany(
              companyName: _companyNameController.text.trim(),
              fullName: fullName,
              role: _role,
            )
          : await backend.joinCompany(
              inviteCode: _inviteCodeController.text.trim(),
              fullName: fullName,
              role: _role,
            );
      if (membership == null) {
        throw StateError('Профиль не создан');
      }
      await backend.syncAll();
      if (!mounted) {
        return;
      }
      if (_mode == _SetupMode.create) {
        await _showInviteCode(membership);
      }
      if (mounted) {
        context.go(AppRoutes.home);
      }
    } catch (error) {
      if (!mounted) {
        return;
      }
      final text = '$error'.contains('Invalid invite code')
          ? 'Код приглашения не найден. Проверьте код у руководителя.'
          : 'Не удалось сохранить: $error';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(text), behavior: SnackBarBehavior.floating),
      );
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  Future<void> _showInviteCode(CompanyMembership membership) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Компания «${membership.companyName}» создана'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text('Код приглашения для сотрудников:'),
              const SizedBox(height: 8),
              SelectableText(
                membership.inviteCode,
                style: Theme.of(dialogContext).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                      letterSpacing: 2,
                    ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Сотрудник регистрируется в приложении, выбирает '
                '«Присоединиться» и вводит этот код. Код всегда виден '
                'в разделе «Компания».',
              ),
            ],
          ),
          actions: <Widget>[
            FilledButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Понятно'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final isCreate = _mode == _SetupMode.create;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ваша компания'),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              await CloudBackend.instance.signOut();
              if (context.mounted) {
                context.go(AppRoutes.login);
              }
            },
            child: const Text('Выйти'),
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
              children: <Widget>[
                Text(
                  'Все проекты, задачи и фотоотчёты хранятся внутри компании '
                  'и видны только её сотрудникам.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 20),
                SegmentedButton<_SetupMode>(
                  segments: const <ButtonSegment<_SetupMode>>[
                    ButtonSegment<_SetupMode>(
                      value: _SetupMode.create,
                      icon: Icon(Icons.add_business_outlined),
                      label: Text('Создать'),
                    ),
                    ButtonSegment<_SetupMode>(
                      value: _SetupMode.join,
                      icon: Icon(Icons.group_add_outlined),
                      label: Text('Присоединиться'),
                    ),
                  ],
                  selected: <_SetupMode>{_mode},
                  onSelectionChanged: (Set<_SetupMode> value) => _setMode(value.first),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _fullNameController,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    labelText: 'Ваше имя и фамилия',
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                  validator: _required,
                ),
                const SizedBox(height: 16),
                if (isCreate)
                  TextFormField(
                    key: const ValueKey<String>('companyName'),
                    controller: _companyNameController,
                    decoration: const InputDecoration(
                      labelText: 'Название компании',
                      prefixIcon: Icon(Icons.apartment_outlined),
                    ),
                    validator: _required,
                  )
                else
                  TextFormField(
                    key: const ValueKey<String>('inviteCode'),
                    controller: _inviteCodeController,
                    textCapitalization: TextCapitalization.characters,
                    decoration: const InputDecoration(
                      labelText: 'Код приглашения',
                      prefixIcon: Icon(Icons.vpn_key_outlined),
                    ),
                    validator: _required,
                  ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  key: ValueKey<_SetupMode>(_mode),
                  initialValue: _role,
                  isExpanded: true,
                  decoration: InputDecoration(
                    labelText: l10n.loginRoleLabel,
                    prefixIcon: const Icon(Icons.badge_outlined),
                  ),
                  items: <DropdownMenuItem<String>>[
                    DropdownMenuItem<String>(value: 'director', child: Text(l10n.roleDirector)),
                    DropdownMenuItem<String>(
                      value: 'projectManager',
                      child: Text(l10n.roleProjectManager),
                    ),
                    DropdownMenuItem<String>(
                      value: 'siteEngineer',
                      child: Text(l10n.roleSiteEngineer),
                    ),
                    DropdownMenuItem<String>(value: 'accountant', child: Text(l10n.roleAccountant)),
                  ],
                  onChanged: (String? value) {
                    if (value != null) {
                      setState(() => _role = value);
                    }
                  },
                ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _isSaving ? null : _submit,
                  icon: _isSaving
                      ? const SizedBox.square(
                          dimension: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Icon(isCreate ? Icons.check : Icons.login),
                  label: Text(isCreate ? 'Создать компанию' : 'Присоединиться'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? _required(String? value) {
    return (value == null || value.trim().isEmpty) ? context.l10n.validationRequired : null;
  }
}
