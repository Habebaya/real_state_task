import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nawy_real_state/feature/explore/data/model/property_filter/property_search_model.dart';
import 'package:nawy_real_state/feature/explore/presentation/manger/search/search_cubit.dart';
import 'package:nawy_real_state/feature/explore/presentation/widget/property_tile.dart';

import '../../../../config/routes/app_navigator.dart';
import '../../../../config/routes/const/route_paths.dart';
import '../../../../core/constant/widget/empty_list_widget.dart';
import '../../../../core/constant/widget/loading_list_widget.dart';
import '../manger/browse_state.dart';

class TabAllContent extends StatelessWidget {
  const TabAllContent({
    super.key,
    required this.touchedField,
    required this.isTyping,
    required this.showEmptyState,
    required this.state,
  });

  final BrowseState state;
  final bool touchedField;
  final bool isTyping;
  final bool showEmptyState;

  @override
  Widget build(BuildContext context) {
    if (!touchedField) return const SizedBox.shrink();
    if (isTyping) return LoadingList();
    if (showEmptyState) return const EmptyResults();
    if ((state.compoundResult ?? const []).isEmpty) return const EmptyResults();

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: state.compoundResult!.length,
      separatorBuilder: (_, __) => 10.verticalSpace,
      itemBuilder: (_, i) {
        return InkWell(
          onTap: () {
            context
                .read<SearchCubit>()
                .searchByAreaId(
                  p: PropertySearchModel(areaId: state.compoundResult![i].id),
                )
                .then(
                  (value) => AppNavigator.navigateToScreen(
                    RoutePaths.searchResultScreen,
                    NavigateType.pushNamed,
                    context,
                    extra: PropertySearchModel(
                      areaId: state.compoundResult![i].id,
                    ),
                  ),
                );
          },
          child: PropertyTile(
            name: state.compoundResult![i].name,
            image: state.compoundResult![i].imagePath,
          ),
        );
      },
    );
  }
}

class TabLocationContent extends StatelessWidget {
  const TabLocationContent({
    super.key,
    required this.touchedField,
    required this.isTyping,
    required this.showEmptyState,
    required this.state,
  });

  final BrowseState state;
  final bool touchedField;
  final bool isTyping;
  final bool showEmptyState;

  @override
  Widget build(BuildContext context) {
    if (!touchedField) return const SizedBox.shrink();
    if (isTyping) return LoadingList();
    if (showEmptyState) return const EmptyResults();
    if ((state.areaResult ?? const []).isEmpty) return const EmptyResults();

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: state.areaResult!.length,
      separatorBuilder: (_, __) => 10.verticalSpace,
      itemBuilder: (_, i) {
        return InkWell(
          onTap: () {
            context
                .read<SearchCubit>()
                .searchByAreaId(
                  p: PropertySearchModel(areaId: state.areaResult![i].id),
                )
                .then(
                  (value) => AppNavigator.navigateToScreen(
                    RoutePaths.searchResultScreen,
                    NavigateType.pushNamed,
                    context,
                    extra: PropertySearchModel(areaId: state.areaResult![i].id),
                  ),
                );
          },
          child: PropertyTile(
            name: state.areaResult![i].name,
            image: state.areaResult![i].imagePath,
          ),
        );
      },
    );
  }
}

class TabCompoundContent extends StatelessWidget {
  const TabCompoundContent({
    super.key,
    required this.touchedField,
    required this.isTyping,
    required this.showEmptyState,
    required this.state,
  });

  final BrowseState state;
  final bool touchedField;
  final bool isTyping;
  final bool showEmptyState;

  @override
  Widget build(BuildContext context) {
    if (!touchedField) return const SizedBox.shrink();
    if (isTyping) return LoadingList();
    if (showEmptyState) return const EmptyResults();
    if ((state.result ?? const []).isEmpty) return const EmptyResults();

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: state.result!.length,
      separatorBuilder: (_, __) => 10.verticalSpace,
      itemBuilder: (_, i) {
        return PropertyTile(
          name: state.result![i].name,
          image: state.result![i].imagePath,
        );
      },
    );
  }
}
