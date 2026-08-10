import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_routes.dart';
import '../../../../core/localization/context_l10n.dart';

class HomeShellScreen extends StatefulWidget {
  const HomeShellScreen({
    required this.child,
    required this.currentLocation,
    super.key,
  });

  final Widget child;
  final String currentLocation;

  @override
  State<HomeShellScreen> createState() => _HomeShellScreenState();
}

class _HomeShellScreenState extends State<HomeShellScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pageController;
  late final Animation<double> _pageOpacity;
  late final Animation<Offset> _pageSlide;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _pageController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    )..forward();

    _pageOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _pageController, curve: Curves.easeOutCubic),
    );

    _pageSlide = Tween<Offset>(
      begin: const Offset(0.05, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _pageController, curve: Curves.easeOutCubic),
    );
  }

  @override
  void didUpdateWidget(HomeShellScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentLocation != widget.currentLocation) {
      _pageController.reset();
      _pageController.forward();
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  int _selectedIndex(List<_NavDestination> destinations) {
    final index = destinations.lastIndexWhere((_NavDestination destination) {
      final route = destination.route;
      return widget.currentLocation == route || widget.currentLocation.startsWith('$route/');
    });

    return index == -1 ? 0 : index;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final destinations = <_NavDestination>[
      _NavDestination(
        route: AppRoutes.home,
        label: l10n.navHome,
        icon: Icons.home_outlined,
        activeIcon: Icons.home,
      ),
      _NavDestination(
        route: AppRoutes.chats,
        label: l10n.navChats,
        icon: Icons.chat_bubble_outline,
        activeIcon: Icons.chat_bubble,
      ),
      _NavDestination(
        route: AppRoutes.tasks,
        label: l10n.navTasks,
        icon: Icons.task_outlined,
        activeIcon: Icons.task,
      ),
      _NavDestination(
        route: AppRoutes.finance,
        label: l10n.navFinance,
        icon: Icons.account_balance_wallet_outlined,
        activeIcon: Icons.account_balance_wallet,
      ),
      _NavDestination(
        route: AppRoutes.profile,
        label: l10n.navProfile,
        icon: Icons.person_outline,
        activeIcon: Icons.person,
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: SlideTransition(
          position: _pageSlide,
          child: FadeTransition(
            opacity: _pageOpacity,
            child: widget.child,
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex(destinations),
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        destinations: destinations
            .map(
              (_NavDestination destination) => NavigationDestination(
                icon: Icon(destination.icon),
                selectedIcon: Icon(destination.activeIcon),
                label: destination.label,
              ),
            )
            .toList(growable: false),
        onDestinationSelected: (int index) {
          Feedback.forTap(context);
          context.go(destinations[index].route);
        },
      ),
    );
  }
}

class _NavDestination {
  const _NavDestination({
    required this.route,
    required this.label,
    required this.icon,
    required this.activeIcon,
  });

  final String route;
  final String label;
  final IconData icon;
  final IconData activeIcon;
}
