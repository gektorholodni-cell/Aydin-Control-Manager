import 'package:flutter/material.dart';

import '../../../../core/localization/context_l10n.dart';
import '../../../../shared/presentation/widgets/structra_logo.dart';

class LoginSidePanel extends StatelessWidget {
  const LoginSidePanel({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            colorScheme.primaryContainer,
            colorScheme.secondaryContainer,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(32),
      ),
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const StructraLogo(alignment: CrossAxisAlignment.start),
          const SizedBox(height: 24),
          Text(
            l10n.loginSideTitle,
            style: textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            l10n.loginSideSubtitle,
            style: textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
