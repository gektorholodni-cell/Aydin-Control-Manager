import 'package:flutter/material.dart';

import '../../../../core/localization/context_l10n.dart';

class LoginFormCard extends StatefulWidget {
  const LoginFormCard({
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.lastNameController,
    required this.firstNameController,
    required this.middleNameController,
    required this.positionController,
    required this.isRememberMe,
    required this.onRememberMeChanged,
    required this.isSubmitting,
    required this.onForgotPassword,
    required this.onLoginPressed,
    super.key,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController lastNameController;
  final TextEditingController firstNameController;
  final TextEditingController middleNameController;
  final TextEditingController positionController;
  final bool isRememberMe;
  final ValueChanged<bool> onRememberMeChanged;
  final bool isSubmitting;
  final VoidCallback onForgotPassword;
  final VoidCallback onLoginPressed;

  @override
  State<LoginFormCard> createState() => _LoginFormCardState();
}

class _LoginFormCardState extends State<LoginFormCard>
    with SingleTickerProviderStateMixin {
  static final _emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  late final AnimationController _revealController;
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _revealController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    );
    // Карточка появляется после логотипа и заголовка.
    Future<void>.delayed(const Duration(milliseconds: 450), () {
      if (mounted) _revealController.forward();
    });
  }

  @override
  void dispose() {
    _revealController.dispose();
    super.dispose();
  }

  String? _required(String? value) {
    if (value == null || value.trim().isEmpty) {
      return context.l10n.validationRequired;
    }
    return null;
  }

  String? _validateEmail(String? value) {
    final requiredError = _required(value);
    if (requiredError != null) return requiredError;
    if (!_emailPattern.hasMatch(value!.trim())) {
      return context.l10n.loginInvalidEmail;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colorScheme = Theme.of(context).colorScheme;

    final items = <Widget>[
      _SectionLabel(text: l10n.loginAccountSection),
      TextFormField(
        controller: widget.emailController,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        autofillHints: const <String>[AutofillHints.email],
        validator: _validateEmail,
        decoration: InputDecoration(
          labelText: l10n.commonEmail,
          prefixIcon: const Icon(Icons.alternate_email_rounded),
        ),
      ),
      TextFormField(
        controller: widget.passwordController,
        obscureText: !_isPasswordVisible,
        textInputAction: TextInputAction.next,
        autofillHints: const <String>[AutofillHints.password],
        validator: _required,
        decoration: InputDecoration(
          labelText: l10n.commonPassword,
          prefixIcon: const Icon(Icons.lock_outline_rounded),
          suffixIcon: IconButton(
            onPressed: () =>
                setState(() => _isPasswordVisible = !_isPasswordVisible),
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Icon(
                _isPasswordVisible
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                key: ValueKey<bool>(_isPasswordVisible),
              ),
            ),
          ),
        ),
      ),
      _SectionLabel(text: l10n.loginAboutSection),
      TextFormField(
        controller: widget.lastNameController,
        textCapitalization: TextCapitalization.words,
        textInputAction: TextInputAction.next,
        autofillHints: const <String>[AutofillHints.familyName],
        validator: _required,
        decoration: InputDecoration(
          labelText: l10n.loginLastName,
          prefixIcon: const Icon(Icons.person_outline_rounded),
        ),
      ),
      TextFormField(
        controller: widget.firstNameController,
        textCapitalization: TextCapitalization.words,
        textInputAction: TextInputAction.next,
        autofillHints: const <String>[AutofillHints.givenName],
        validator: _required,
        decoration: InputDecoration(
          labelText: l10n.loginFirstName,
          prefixIcon: const Icon(Icons.badge_outlined),
        ),
      ),
      TextFormField(
        controller: widget.middleNameController,
        textCapitalization: TextCapitalization.words,
        textInputAction: TextInputAction.next,
        autofillHints: const <String>[AutofillHints.middleName],
        decoration: InputDecoration(
          labelText: l10n.loginMiddleName,
          prefixIcon: const Icon(Icons.short_text_rounded),
        ),
      ),
      TextFormField(
        controller: widget.positionController,
        textCapitalization: TextCapitalization.sentences,
        textInputAction: TextInputAction.done,
        autofillHints: const <String>[AutofillHints.jobTitle],
        validator: _required,
        onFieldSubmitted: (_) => widget.onLoginPressed(),
        decoration: InputDecoration(
          labelText: l10n.loginPosition,
          hintText: l10n.loginPositionHint,
          prefixIcon: const Icon(Icons.work_outline_rounded),
        ),
      ),
      Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[
          InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () => widget.onRememberMeChanged(!widget.isRememberMe),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Checkbox(
                  value: widget.isRememberMe,
                  onChanged: (bool? value) {
                    widget.onRememberMeChanged(value ?? false);
                  },
                ),
                Text(l10n.loginRememberMe),
                const SizedBox(width: 8),
              ],
            ),
          ),
          TextButton(
            onPressed: widget.onForgotPassword,
            child: Text(l10n.loginForgotPassword),
          ),
        ],
      ),
      _LoginButton(
        label: l10n.loginButton,
        isLoading: widget.isSubmitting,
        onPressed: widget.onLoginPressed,
      ),
    ];

    return _Reveal(
      animation: CurvedAnimation(
        parent: _revealController,
        curve: const Interval(0, 0.45, curve: Curves.easeOutCubic),
      ),
      offset: 40,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: const Color(0xFF0F2333).withValues(alpha: 0.86),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.35),
              blurRadius: 40,
              offset: const Offset(0, 20),
            ),
            BoxShadow(
              color: colorScheme.primary.withValues(alpha: 0.10),
              blurRadius: 60,
              spreadRadius: -10,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 22),
          child: Form(
            key: widget.formKey,
            child: AutofillGroup(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  for (int i = 0; i < items.length; i++)
                    Padding(
                      padding: EdgeInsets.only(
                        top: i == 0 ? 0 : (items[i] is _SectionLabel ? 20 : 12),
                      ),
                      child: _Reveal(
                        animation: CurvedAnimation(
                          parent: _revealController,
                          curve: Interval(
                            0.12 + i * 0.06,
                            (0.12 + i * 0.06 + 0.4).clamp(0.0, 1.0).toDouble(),
                            curve: Curves.easeOutCubic,
                          ),
                        ),
                        offset: 16,
                        child: items[i],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Плавное появление: прозрачность + небольшой сдвиг снизу вверх.
class _Reveal extends StatelessWidget {
  const _Reveal({
    required this.animation,
    required this.offset,
    required this.child,
  });

  final Animation<double> animation;
  final double offset;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      child: child,
      builder: (BuildContext context, Widget? child) {
        final t = animation.value;
        return Opacity(
          opacity: t,
          child: Transform.translate(
            offset: Offset(0, (1 - t) * offset),
            child: child,
          ),
        );
      },
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: <Widget>[
        Container(
          width: 4,
          height: 14,
          decoration: BoxDecoration(
            color: colorScheme.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          text.toUpperCase(),
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
                letterSpacing: 1.2,
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({
    required this.label,
    required this.isLoading,
    required this.onPressed,
  });

  final String label;
  final bool isLoading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: SizedBox(
        height: 54,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: const LinearGradient(
              colors: <Color>[Color(0xFF2F7FC1), Color(0xFF15A6A0)],
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: const Color(0xFF2F7FC1).withValues(alpha: 0.35),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: isLoading ? null : onPressed,
              child: Center(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  transitionBuilder: (Widget child, Animation<double> anim) {
                    return FadeTransition(
                      opacity: anim,
                      child: ScaleTransition(scale: anim, child: child),
                    );
                  },
                  child: isLoading
                      ? const SizedBox(
                          key: ValueKey<String>('loading'),
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.6,
                            color: Colors.white,
                          ),
                        )
                      : Row(
                          key: const ValueKey<String>('label'),
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              label,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                            const SizedBox(width: 10),
                            const Icon(
                              Icons.arrow_forward_rounded,
                              color: Colors.white,
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
