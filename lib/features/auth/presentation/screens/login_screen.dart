import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/app_routes.dart';
import '../../../../core/localization/context_l10n.dart';
import '../widgets/login_form_card.dart';
import '../widgets/login_header.dart';
import '../widgets/login_side_panel.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static const _rememberMeKey = 'structra.login.remember_me';
  static const _roleKey = 'structra.login.role';

  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  bool _isRememberMe = true;
  String _selectedRole = 'projectManager';

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _restoreSavedLoginPrefs();
  }

  Future<void> _restoreSavedLoginPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) {
      return;
    }

    setState(() {
      _isRememberMe = prefs.getBool(_rememberMeKey) ?? true;
      _selectedRole = prefs.getString(_roleKey) ?? 'projectManager';
    });
  }

  Future<void> _persistLoginPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_rememberMeKey, _isRememberMe);
    await prefs.setString(_roleKey, _selectedRole);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed() {
    _persistLoginPrefs();
    context.go(AppRoutes.home);
  }

  void _onForgotPassword() {
    final l10n = context.l10n;
    final emailController = TextEditingController(text: _emailController.text);
    showDialog<void>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(l10n.loginForgotPassword),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(l10n.loginForgotPasswordInfo),
              const SizedBox(height: 16),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                autofocus: true,
                decoration: InputDecoration(
                  labelText: l10n.commonEmail,
                  prefixIcon: const Icon(Icons.email_outlined),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                emailController.dispose();
                Navigator.pop(ctx);
              },
              child: Text(l10n.commonCancel),
            ),
            FilledButton(
              onPressed: () {
                final email = emailController.text.trim();
                emailController.dispose();
                Navigator.pop(ctx);
                if (email.isNotEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${l10n.loginForgotPasswordInfo}: $email'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              },
              child: const Text('Отправить'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF071520),
      body: Stack(
        children: <Widget>[
          const Positioned.fill(
            child: IgnorePointer(
              child: CustomPaint(painter: _LoginBgPainter()),
            ),
          ),
          SafeArea(
            child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final bool isTablet = constraints.maxWidth >= 900;
            final double formWidth = isTablet
                ? 430
                : constraints.maxWidth > 600
                    ? 460
                    : constraints.maxWidth;

            final formSection = Align(
              alignment: Alignment.center,
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: formWidth),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const LoginHeader(),
                    const SizedBox(height: 28),
                    LoginFormCard(
                      emailController: _emailController,
                      passwordController: _passwordController,
                      isRememberMe: _isRememberMe,
                      onRememberMeChanged: (bool value) {
                        setState(() {
                          _isRememberMe = value;
                        });
                        _persistLoginPrefs();
                      },
                      selectedRole: _selectedRole,
                      onRoleChanged: (String role) {
                        setState(() {
                          _selectedRole = role;
                        });
                        _persistLoginPrefs();
                      },
                      onForgotPassword: _onForgotPassword,
                      onLoginPressed: _onLoginPressed,
                    ),
                  ],
                ),
              ),
            );

            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 350),
              switchInCurve: Curves.easeOutCubic,
              switchOutCurve: Curves.easeInCubic,
              child: Padding(
                key: ValueKey<bool>(isTablet),
                padding: const EdgeInsets.all(24),
                child: isTablet
                    ? Row(
                        children: <Widget>[
                          const Expanded(child: LoginSidePanel()),
                          const SizedBox(width: 28),
                          Expanded(
                            child: SingleChildScrollView(
                              child: formSection,
                            ),
                          ),
                        ],
                      )
                    : SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: formSection,
                        ),
                      ),
              ),
            );
          },
        ),
          ),
        ],
      ),
    );
  }
}

class _LoginBgPainter extends CustomPainter {
  const _LoginBgPainter();

  @override
  void paint(Canvas canvas, Size size) {
    _drawGrid(canvas, size);
    _drawCitySilhouette(canvas, size);
  }

  void _drawGrid(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF0E2D47)
      ..strokeWidth = 0.5;
    const spacing = 32.0;
    for (double x = 0; x <= size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y <= size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  void _drawCitySilhouette(Canvas canvas, Size size) {
    final fill = Paint()..color = const Color(0xFF0D2438);
    final edge = Paint()
      ..color = const Color(0xFF1A3D5A)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.6;

    // [xFactor, widthFactor, heightFactor]
    const specs = <List<double>>[
      [0.00, 0.10, 0.20],
      [0.08, 0.14, 0.32],
      [0.20, 0.08, 0.24],
      [0.27, 0.06, 0.18],
      [0.60, 0.07, 0.20],
      [0.65, 0.12, 0.28],
      [0.75, 0.13, 0.38],
      [0.87, 0.08, 0.22],
      [0.93, 0.07, 0.18],
    ];

    for (final spec in specs) {
      final bx = size.width * spec[0];
      final bw = size.width * spec[1];
      final bh = size.height * spec[2];
      final rect = Rect.fromLTWH(bx, size.height - bh, bw, bh);
      canvas.drawRect(rect, fill);
      canvas.drawRect(rect, edge);
    }
  }

  @override
  bool shouldRepaint(_LoginBgPainter old) => false;
}
