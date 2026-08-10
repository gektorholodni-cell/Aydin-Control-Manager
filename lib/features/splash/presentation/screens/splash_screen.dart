import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_routes.dart';
import '../../../../core/localization/context_l10n.dart';
import '../../../../shared/presentation/widgets/structra_logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _buildController;
  late final AnimationController _logoController;
  late final AnimationController _blinkController;

  late final Animation<double> _buildProgress;
  late final Animation<double> _logoOpacity;
  late final Animation<double> _logoScale;
  late final Animation<double> _textOpacity;

  @override
  void initState() {
    super.initState();

    _buildController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..forward();

    _buildProgress = CurvedAnimation(
      parent: _buildController,
      curve: Curves.easeOutCubic,
    );

    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _logoOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeOutCubic),
    );

    _logoScale = Tween<double>(begin: 0.8, end: 1).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeOutBack),
    );

    _textOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.4, 1, curve: Curves.easeOutCubic),
      ),
    );

    _blinkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);

    Future<void>.delayed(const Duration(milliseconds: 900), () {
      if (mounted) _logoController.forward();
    });

    Future<void>.delayed(const Duration(milliseconds: 3000), () {
      if (mounted) context.go(AppRoutes.login);
    });
  }

  @override
  void dispose() {
    _buildController.dispose();
    _logoController.dispose();
    _blinkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: const Color(0xFF071520),
      body: Stack(
        children: <Widget>[
          // Animated construction background
          AnimatedBuilder(
            animation: Listenable.merge(<Listenable>[_buildProgress, _blinkController]),
            builder: (context, _) {
              return CustomPaint(
                painter: _ConstructionPainter(
                  buildProgress: _buildProgress.value,
                  blinkProgress: _blinkController.value,
                ),
                child: const SizedBox.expand(),
              );
            },
          ),
          // Center logo + tagline + progress
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                FadeTransition(
                  opacity: _logoOpacity,
                  child: ScaleTransition(
                    scale: _logoScale,
                    child: const StructraLogo(size: 96),
                  ),
                ),
                const SizedBox(height: 36),
                FadeTransition(
                  opacity: _textOpacity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      children: <Widget>[
                        Text(
                          l10n.splashTagline,
                          style: const TextStyle(
                            color: Color(0xFFB0C8E0),
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.8,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 36),
                        AnimatedBuilder(
                          animation: _buildProgress,
                          builder: (context, _) {
                            final pct = (_buildProgress.value * 100).toInt();
                            return Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    const Text(
                                      'РРќРР¦РРђР›РР—РђР¦РРЇ',
                                      style: TextStyle(
                                        color: Color(0xFF4A7FA5),
                                        fontSize: 9,
                                        letterSpacing: 2,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      '$pct%',
                                      style: const TextStyle(
                                        color: Color(0xFFF59E0B),
                                        fontSize: 10,
                                        letterSpacing: 1,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Stack(
                                  children: <Widget>[
                                    Container(
                                      height: 3,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF1A3A56),
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                    ),
                                    FractionallySizedBox(
                                      widthFactor: _buildProgress.value,
                                      child: Container(
                                        height: 3,
                                        decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                            colors: <Color>[Color(0xFF1A6B9A), Color(0xFFF59E0B)],
                                          ),
                                          borderRadius: BorderRadius.circular(2),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ConstructionPainter extends CustomPainter {
  final double buildProgress;
  final double blinkProgress;

  const _ConstructionPainter({
    required this.buildProgress,
    required this.blinkProgress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    _drawGrid(canvas, size);
    _drawBuildings(canvas, size);
    _drawCrane(canvas, size);
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

  void _drawBuildings(Canvas canvas, Size size) {
    // [xFactor, widthFactor, heightFactor]
    const specs = <List<double>>[
      [0.00, 0.11, 0.32],
      [0.09, 0.16, 0.52],
      [0.23, 0.09, 0.38],
      [0.31, 0.07, 0.26],
      [0.63, 0.08, 0.30],
      [0.69, 0.13, 0.44],
      [0.80, 0.13, 0.58],
      [0.91, 0.09, 0.35],
    ];

    for (int i = 0; i < specs.length; i++) {
      final spec = specs[i];
      final bx = size.width * spec[0];
      final bw = size.width * spec[1];
      final fullH = size.height * spec[2];
      final currentH = fullH * buildProgress;
      final by = size.height - currentH;

      canvas.drawRect(
        Rect.fromLTWH(bx, by, bw, currentH),
        Paint()..color = const Color(0xFF0F2336),
      );
      canvas.drawRect(
        Rect.fromLTWH(bx, by, bw, currentH),
        Paint()
          ..color = const Color(0xFF1E4A6E)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 0.8,
      );

      _drawWindows(canvas, bx, by, bw, currentH, i * 97);
    }
  }

  void _drawWindows(
    Canvas canvas,
    double bx,
    double by,
    double bw,
    double bh,
    int seed,
  ) {
    const wW = 4.0;
    const wH = 5.0;
    const hGap = 9.0;
    const vGap = 11.0;
    const pad = 5.0;

    final cols = ((bw - pad * 2) / hGap).floor();
    final rows = ((bh - pad * 2) / vGap).floor();
    if (cols <= 0 || rows <= 0) return;

    final rng = math.Random(seed);

    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < cols; col++) {
        final lit = rng.nextBool();
        final wx = bx + pad + col * hGap;
        final wy = by + pad + row * vGap;
        Color color;
        if (lit) {
          final blinks = rng.nextBool();
          if (blinks) {
            final alpha = 0.5 + 0.4 * blinkProgress;
            color = Color.fromRGBO(245, 158, 11, alpha);
          } else {
            color = const Color(0xFFF59E0B).withValues(alpha: 0.55);
          }
        } else {
          color = const Color(0xFF091A28);
        }
        canvas.drawRect(
          Rect.fromLTWH(wx, wy, wW, wH),
          Paint()..color = color,
        );
      }
    }
  }

  void _drawCrane(Canvas canvas, Size size) {
    if (buildProgress < 0.4) return;
    final opacity = math.min(1.0, (buildProgress - 0.4) * (1 / 0.3));

    final craneX = size.width * 0.83;
    final craneBaseY = size.height - size.height * 0.58 * buildProgress;

    final p = Paint()
      ..color = Color.fromRGBO(245, 158, 11, opacity)
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    // Vertical mast
    canvas.drawLine(Offset(craneX, craneBaseY), Offset(craneX, craneBaseY - 65), p);
    // Main jib (forward)
    canvas.drawLine(Offset(craneX, craneBaseY - 62), Offset(craneX - 80, craneBaseY - 62), p);
    // Counter jib (back)
    canvas.drawLine(Offset(craneX, craneBaseY - 62), Offset(craneX + 28, craneBaseY - 62), p);
    // Tie cables
    final cp = Paint()
      ..color = Color.fromRGBO(245, 158, 11, opacity * 0.5)
      ..strokeWidth = 0.8;
    canvas.drawLine(Offset(craneX, craneBaseY - 65), Offset(craneX - 80, craneBaseY - 62), cp);
    canvas.drawLine(Offset(craneX, craneBaseY - 65), Offset(craneX + 28, craneBaseY - 62), cp);
    // Hoist rope
    final trolleyX = craneX - 50.0;
    canvas.drawLine(
      Offset(trolleyX, craneBaseY - 62),
      Offset(trolleyX, craneBaseY - 38),
      Paint()
        ..color = Color.fromRGBO(245, 158, 11, opacity * 0.7)
        ..strokeWidth = 0.8,
    );
    // Hook
    canvas.drawCircle(
      Offset(trolleyX, craneBaseY - 35),
      2.5,
      Paint()..color = Color.fromRGBO(245, 158, 11, opacity),
    );
    // Base cross
    canvas.drawLine(Offset(craneX - 6, craneBaseY), Offset(craneX + 6, craneBaseY), p);
  }

  @override
  bool shouldRepaint(_ConstructionPainter old) {
    return old.buildProgress != buildProgress || old.blinkProgress != blinkProgress;
  }
}
