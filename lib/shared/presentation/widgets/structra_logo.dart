import 'package:flutter/material.dart';

import '../../../core/localization/context_l10n.dart';

class StructraLogo extends StatelessWidget {
  const StructraLogo({
    this.size = 84,
    this.showWordmark = true,
    this.alignment = CrossAxisAlignment.center,
    super.key,
  });

  final double size;
  final bool showWordmark;
  final CrossAxisAlignment alignment;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: alignment,
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                colorScheme.primary,
                colorScheme.secondary,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(size * 0.24),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: colorScheme.primary.withValues(alpha: 0.25),
                blurRadius: 24,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Icon(
            Icons.foundation,
            color: colorScheme.onPrimary,
            size: size * 0.5,
          ),
        ),
        if (showWordmark) ...<Widget>[
          const SizedBox(height: 14),
          Text(
            context.l10n.appTitle,
            style: textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ],
    );
  }
}
