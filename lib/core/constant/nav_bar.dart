import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// The host scaffold that shows the bottom NavigationBar
class NavScaffold extends StatefulWidget {
  final StatefulNavigationShell shell;
  const NavScaffold({super.key, required this.shell});

  @override
  State<NavScaffold> createState() => _NavScaffoldState();
}

class _NavScaffoldState extends State<NavScaffold> {
  int get _index => widget.shell.currentIndex;

  void _onTap(int i) {
    if (i == _index) {
      // Re-tapping current tab pops to its root
      widget.shell.goBranch(i, initialLocation: true);
    } else {
      widget.shell.goBranch(i);
    }
  }

  String _titleFor(int i) => switch (i) {
    0 => 'Home',
    1 => 'Search',
    _ => 'Profile',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_titleFor(_index)), centerTitle: true),
      body: widget.shell, // <- IndexedStack of branches
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: _onTap,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.search_outlined),
            selectedIcon: Icon(Icons.search),
            label: 'Search',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
