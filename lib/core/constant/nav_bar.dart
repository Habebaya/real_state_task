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
  void _onTap(int index) {
    widget.shell.goBranch(
      index,
      initialLocation: index == widget.shell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      body: widget.shell, // <- IndexedStack of branches
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primaryColor,
        showSelectedLabels: true,

        iconSize: 18,
        backgroundColor: AppColors.whiteColor,
        unselectedItemColor: AppColors.mediumBlackColor,
        showUnselectedLabels: true,

        selectedLabelStyle: TextStyles.light12MediumBlack(
          context,
        ).copyWith(color: AppColors.primaryColor),
        unselectedLabelStyle: TextStyles.light12MediumBlack(context),

        currentIndex: widget.shell.currentIndex,
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
