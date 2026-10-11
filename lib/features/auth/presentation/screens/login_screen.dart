import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/app_routes.dart';
import '../../../../core/localization/context_l10n.dart';
import '../../../../core/theme/app_theme.dart';
import '../../data/user_profile_store.dart';
import '../widgets/login_form_card.dart';
import '../widgets/login_header.dart';
import '../widgets/login_side_panel.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  static const _rememberMeKey = 'structra.login.remember_me';

  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _firstNameController;
  late final TextEditingController _middleNameController;
  late final TextEditingController _positionController;
  late final AnimationController _backgroundController;
  late final AnimationController _exitController;
  bool _isRememberMe = true;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _lastNameController = TextEditingController();
    _firstNameController = TextEditingController();
    _middleNameController = TextEditingController();
    _positionController = TextEditingController();
    _backgroundController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 14),
    )..repeat();
    _exitController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 420),
    );
    _restoreSavedLoginPrefs();
  }

  Future<void> _restoreSavedLoginPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final isRememberMe = prefs.getBool(_rememberMeKey) ?? true;
    final profile =
        isRememberMe ? await UserProfileStore.load() : UserProfile.empty;
    if (!mounted) {
      return;
    }

    setState(() {
      _isRememberMe = isRememberMe;
      _emailController.text = profile.email;
      _lastNameController.text = profile.lastName;
      _firstNameController.text = profile.firstName;
      _middleNameController.text = profile.middleName;
      _positionController.text = profile.position;
    });
  }

  Future<void> _persistRememberMe() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_rememberMeKey, _isRememberMe);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _lastNameController.dispose();
    _firstNameController.dispose();
    _middleNameController.dispose();
    _positionController.dispose();
    _backgroundController.dispose();
    _exitController.dispose();
    super.dispose();
  }

  Future<void> _onLoginPressed() async {
    if (_isSubmitting) return;
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    setState(() => _isSubmitting = true);
    await Future.wait(<Future<void>>[
      _persistRememberMe(),
      UserProfileStore.save(
        UserProfile(
          email: _emailController.text.trim(),
          lastName: _lastNameController.text.trim(),
          firstName: _firstNameController.text.trim(),
          middleName: _middleNameController.text.trim(),
          position: _positionController.text.trim(),
        ),
      ),
      Future<void>.delayed(const Duration(milliseconds: 650)),
    ]);
    if (!mounted) return;

    await _exitController.forward();
    if (!mounted) return;
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
    final exit = CurvedAnimation(parent: _exitController, curve: Curves.easeInCubic);

    return Theme(
      data: AppTheme.dark,
      child: Scaffold(
        backgroundColor: const Color(0xFF071520),
        body: Stack(
          children: <Widget>[
            Positioned.fill(
              child: IgnorePointer(
                child: CustomPaint(
                  painter: _LoginBgPainter(animation: _backgroundController),
                ),
              ),
            ),
            SafeArea(
              child: AnimatedBuilder(
                animation: exit,
                builder: (BuildContext context, Widget? child) {
                  return Opacity(
                    opacity: 1 - exit.value,
                    child: Transform.scale(
                      scale: 1 - exit.value * 0.06,
                      child: child,
                    ),
                  );
                },
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    final bool isTablet = constraints.maxWidth >= 900;
                    final double formWidth = isTablet ? 440 : 460;

                    final formSection = Align(
                      alignment: Alignment.center,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: formWidth),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            const LoginHeader(),
                            const SizedBox(height: 28),
                            LoginFormCard(
                              formKey: _formKey,
                              emailController: _emailController,
                              passwordController: _passwordController,
                              lastNameController: _lastNameController,
                              firstNameController: _firstNameController,
                              middleNameController: _middleNameController,
                              positionController: _positionController,
                              isRememberMe: _isRememberMe,
                              onRememberMeChanged: (bool value) {
                                setState(() {
                                  _isRememberMe = value;
                                });
                                _persistRememberMe();
                              },
                              isSubmitting: _isSubmitting,
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
                        padding: EdgeInsets.symmetric(
                          horizontal: isTablet ? 24 : 16,
                          vertical: 16,
                        ),
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
            ),
          ],
        ),
      ),
    );
  }
}

class _LoginBgPainter extends CustomPainter {
  _LoginBgPainter({required this.animation}) : super(repaint: animation);

  final Animation<double> animation;

  @override
  void paint(Canvas canvas, Size size) {
    _drawGlows(canvas, size);
    _drawGrid(canvas, size);
    _drawCitySilhouette(canvas, size);
  }

  // Два мягких световых пятна медленно плавают по фону.
  void _drawGlows(Canvas canvas, Size size) {
    final t = animation.value * 2 * math.pi;
    final glows = <(Offset, double, Color)>[
      (
        Offset(
          size.width * (0.2 + 0.12 * math.sin(t)),
          size.height * (0.18 + 0.06 * math.cos(t)),
        ),
        size.shortestSide * 0.9,
        const Color(0xFF1E6FB0),
      ),
      (
        Offset(
          size.width * (0.85 + 0.1 * math.cos(t)),
          size.height * (0.7 + 0.08 * math.sin(t)),
        ),
        size.shortestSide * 0.8,
        const Color(0xFF0F9D8E),
      ),
    ];

    for (final (center, radius, color) in glows) {
      final paint = Paint()
        ..shader = RadialGradient(
          colors: <Color>[
            color.withValues(alpha: 0.28),
            color.withValues(alpha: 0),
          ],
        ).createShader(Rect.fromCircle(center: center, radius: radius));
      canvas.drawCircle(center, radius, paint);
    }
  }

  void _drawGrid(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF0E2D47).withValues(alpha: 0.6)
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
    final fill = Paint()..color = const Color(0xFF0D2438).withValues(alpha: 0.8);
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
  bool shouldRepaint(_LoginBgPainter old) => old.animation != animation;
}
