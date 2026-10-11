import 'package:flutter/material.dart';

import '../../../../core/localization/context_l10n.dart';
import '../../../../shared/presentation/widgets/structra_logo.dart';

class LoginHeader extends StatefulWidget {
  const LoginHeader({super.key});

  @override
  State<LoginHeader> createState() => _LoginHeaderState();
}

class _LoginHeaderState extends State<LoginHeader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _logoOpacity;
  late final Animation<double> _logoScale;
  late final Animation<double> _brandOpacity;
  late final Animation<double> _titleOpacity;
  late final Animation<double> _subtitleOpacity;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..forward();

    Animation<double> interval(double begin, double end, [Curve curve = Curves.easeOutCubic]) {
      return CurvedAnimation(
        parent: _controller,
        curve: Interval(begin, end, curve: curve),
      );
    }

    _logoOpacity = interval(0, 0.45);
    _logoScale = Tween<double>(begin: 0.7, end: 1)
        .animate(interval(0, 0.6, Curves.easeOutBack));
    _brandOpacity = interval(0.2, 0.6);
    _titleOpacity = interval(0.35, 0.8);
    _subtitleOpacity = interval(0.5, 1);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _slideIn(Animation<double> animation, Widget child) {
    return AnimatedBuilder(
      animation: animation,
      child: child,
      builder: (BuildContext context, Widget? child) {
        return Opacity(
          opacity: animation.value,
          child: Transform.translate(
            offset: Offset(0, (1 - animation.value) * 14),
            child: child,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        FadeTransition(
          opacity: _logoOpacity,
          child: ScaleTransition(
            scale: _logoScale,
            child: const StructraLogo(size: 68, showWordmark: false),
          ),
        ),
        const SizedBox(height: 14),
        _slideIn(
          _brandOpacity,
          Text(
            l10n.appTitle.toUpperCase(),
            style: textTheme.labelMedium?.copyWith(
              color: const Color(0xFF7FB8E6),
              letterSpacing: 2.4,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 18),
        _slideIn(
          _titleOpacity,
          Text(
            l10n.loginTitle,
            textAlign: TextAlign.center,
            style: textTheme.headlineMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 8),
        _slideIn(
          _subtitleOpacity,
          Text(
            l10n.loginSubtitle,
            textAlign: TextAlign.center,
            style: textTheme.bodyLarge?.copyWith(
              color: Colors.white.withValues(alpha: 0.65),
            ),
          ),
        ),
      ],
    );
  }
}
