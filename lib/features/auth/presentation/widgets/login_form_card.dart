import 'package:flutter/material.dart';

import '../../../../core/localization/context_l10n.dart';

class LoginFormCard extends StatefulWidget {
  const LoginFormCard({
    required this.emailController,
    required this.passwordController,
    required this.isRememberMe,
    required this.onRememberMeChanged,
    required this.selectedRole,
    required this.onRoleChanged,
    required this.onForgotPassword,
    required this.onLoginPressed,
    super.key,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isRememberMe;
  final ValueChanged<bool> onRememberMeChanged;
  final String selectedRole;
  final ValueChanged<String> onRoleChanged;
  final VoidCallback onForgotPassword;
  final VoidCallback onLoginPressed;

  @override
  State<LoginFormCard> createState() => _LoginFormCardState();
}

class _LoginFormCardState extends State<LoginFormCard>
    with TickerProviderStateMixin {
  late final AnimationController _cardController;
  late final Animation<double> _cardOpacity;
  late final Animation<Offset> _cardSlide;

  @override
  void initState() {
    super.initState();

    _cardController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();

    _cardOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _cardController, curve: Curves.easeOutCubic),
    );

    _cardSlide = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _cardController, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    _cardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colorScheme = Theme.of(context).colorScheme;

    return SlideTransition(
      position: _cardSlide,
      child: FadeTransition(
        opacity: _cardOpacity,
        child: Card(
          elevation: 0,
          color: colorScheme.surfaceContainerLow,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: <Widget>[
                TextField(
                  controller: widget.emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: l10n.commonEmail,
                    prefixIcon: const Icon(Icons.alternate_email),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: widget.passwordController,
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    labelText: l10n.commonPassword,
                    prefixIcon: const Icon(Icons.lock_outline),
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  initialValue: widget.selectedRole,
                  isExpanded: true,
                  decoration: InputDecoration(
                    labelText: l10n.loginRoleLabel,
                    prefixIcon: const Icon(Icons.badge_outlined),
                  ),
                  items: <DropdownMenuItem<String>>[
                    DropdownMenuItem<String>(
                      value: 'director',
                      child: Text(l10n.roleDirector),
                    ),
                    DropdownMenuItem<String>(
                      value: 'projectManager',
                      child: Text(l10n.roleProjectManager),
                    ),
                    DropdownMenuItem<String>(
                      value: 'siteEngineer',
                      child: Text(l10n.roleSiteEngineer),
                    ),
                    DropdownMenuItem<String>(
                      value: 'accountant',
                      child: Text(l10n.roleAccountant),
                    ),
                  ],
                  onChanged: (String? value) {
                    if (value != null) {
                      widget.onRoleChanged(value);
                    }
                  },
                ),
                const SizedBox(height: 12),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
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
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: widget.onForgotPassword,
                        child: Text(l10n.loginForgotPassword),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: widget.onLoginPressed,
                    icon: const Icon(Icons.login),
                    label: Text(l10n.loginButton),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
