import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/backend/cloud_backend.dart';
import 'post_sign_in.dart';

/// Вход по почте и паролю через Supabase.
///
/// Если такого аккаунта нет, предлагает зарегистрироваться. После входа
/// открывает настройку компании или главный экран.
Future<void> runCloudSignIn(
  BuildContext context, {
  required String email,
  required String password,
}) async {
  final messenger = ScaffoldMessenger.of(context);
  void showMessage(String text) {
    messenger.showSnackBar(
      SnackBar(content: Text(text), behavior: SnackBarBehavior.floating),
    );
  }

  if (email.isEmpty || !email.contains('@')) {
    showMessage('Введите корректный email');
    return;
  }
  if (password.length < 6) {
    showMessage('Пароль должен быть не короче 6 символов');
    return;
  }

  final backend = CloudBackend.instance;
  try {
    final result = await backend.signIn(email, password);
    if (!context.mounted) {
      return;
    }

    switch (result) {
      case SignInResult.emailNotConfirmed:
        showMessage('Подтвердите email: откройте письмо от Supabase и нажмите ссылку');
        return;
      case SignInResult.invalidCredentials:
        final register = await _askToRegister(context, email);
        if (!register || !context.mounted) {
          return;
        }
        final signUp = await backend.signUp(email, password);
        if (signUp == SignUpResult.confirmationEmailSent) {
          showMessage('Аккаунт создан. Подтвердите email по ссылке из письма и войдите снова');
          return;
        }
      case SignInResult.signedIn:
        break;
    }

    final route = await resolvePostSignInRoute();
    if (context.mounted) {
      context.go(route);
    }
  } catch (error) {
    showMessage('Не удалось войти: $error');
  }
}

Future<bool> _askToRegister(BuildContext context, String email) async {
  final answer = await showDialog<bool>(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: const Text('Аккаунт не найден'),
        content: Text(
          'Неверный пароль или аккаунта $email ещё нет.\n\n'
          'Создать новый аккаунт с этим email и паролем?',
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Отмена'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Создать аккаунт'),
          ),
        ],
      );
    },
  );
  return answer ?? false;
}
