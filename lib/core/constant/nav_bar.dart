import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nawy_real_state/config/theme/app_color.dart';

import '../../config/theme/app_text_style.dart';
import '../../generated_files/assets.gen.dart';

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
      widget.shell.goBranch(i, initialLocation: true);
    } else {
      widget.shell.goBranch(i);
    }
  }

  String _titleFor(int i) => switch (i) {
    0 => 'Explore',
    1 => 'Updates',
    3 => 'Favorites',
    _ => 'More',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_titleFor(_index)), centerTitle: true),
      body: widget.shell, // <- IndexedStack of branches
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: AppColors.mediumBlackColor,
        showSelectedLabels: true,
        selectedLabelStyle: TextStyles.light12MediumBlack(
          context,
        ).copyWith(color: AppColors.primaryColor),
        unselectedLabelStyle: TextStyles.light12MediumBlack(context),

        currentIndex: _index,
        onTap: _onTap,
        items: [
          BottomNavigationBarItem(
            icon: Assets.icons.explore.svg(),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Assets.icons.updates.svg(),
            label: 'Updates',
          ),
          BottomNavigationBarItem(
            icon: Assets.icons.favorite.svg(),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(icon: Assets.icons.more.svg(), label: 'More'),
        ],
      ),
    );
  }
}
