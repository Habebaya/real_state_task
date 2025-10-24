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
        showSelectedLabels: true,
        iconSize: 18,
        unselectedItemColor: AppColors.mediumBlackColor,
        showUnselectedLabels: true,
        selectedLabelStyle: TextStyles.light12MediumBlack(
          context,
        ).copyWith(color: AppColors.primaryColor),
        unselectedLabelStyle: TextStyles.light12MediumBlack(context),

        currentIndex: _index,
        onTap: _onTap,
        items: [
          BottomNavigationBarItem(
            icon: Assets.icons.explore.svg(),
            activeIcon: Assets.icons.explore.svg(
              colorFilter: ColorFilter.mode(
                AppColors.primaryColor,
                BlendMode.srcIn,
              ),
            ),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Assets.icons.updates.svg(),
            activeIcon: Assets.icons.updates.svg(
              colorFilter: ColorFilter.mode(
                AppColors.primaryColor,
                BlendMode.srcIn,
              ),
            ),

            label: 'Updates',
          ),
          BottomNavigationBarItem(
            activeIcon: Assets.icons.favorite.svg(
              colorFilter: ColorFilter.mode(
                AppColors.primaryColor,
                BlendMode.srcIn,
              ),
            ),
            icon: Assets.icons.favorite.svg(),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Assets.icons.more.svg(),
            activeIcon: Assets.icons.more.svg(
              colorFilter: ColorFilter.mode(
                AppColors.primaryColor,
                BlendMode.srcIn,
              ),
            ),
            label: 'More',
          ),
        ],
      ),
    );
  }
}
