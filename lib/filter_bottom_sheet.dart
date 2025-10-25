import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nawy_real_state/config/theme/app_text_style.dart';
import 'package:nawy_real_state/core/service_locator.dart';
import 'package:nawy_real_state/feature/explore/data/model/property_data_model.dart';
import 'package:nawy_real_state/feature/explore/data/model/property_filter/property_search_model.dart';
import 'package:nawy_real_state/feature/explore/presentation/manger/browse_cubit.dart';
import 'package:nawy_real_state/feature/explore/presentation/manger/browse_state.dart';
import 'package:nawy_real_state/feature/explore/presentation/manger/search/search_cubit.dart';
import 'package:nawy_real_state/feature/explore/presentation/manger/search/search_state.dart';

import 'config/routes/app_navigator.dart';
import 'config/routes/const/route_paths.dart';
import 'config/theme/app_color.dart';
import 'feature/explore/data/model/location_data_model.dart';

class FilterSheet extends StatefulWidget {
  final List<PropertyItem>? initial;

  const FilterSheet({super.key, required this.initial});

  @override
  State<FilterSheet> createState() => FilterSheetState();
}

class FilterSheetState extends State<FilterSheet> {
  int? selectedCompoundId;
  LocationModel? selectedArea;
  int? selectBedRoom;
  @override
  void initState() {
    super.initState();
    selectedArea = LocationModel(
      id: widget.initial!.first.area.id,
      name: widget.initial!.first.area.name,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(getIt(), getIt())..getFilter(),
      child: DraggableScrollableSheet(
        expand: false,
        initialChildSize: .9,
        maxChildSize: .95,
        minChildSize: .5,
        builder: (_, controller) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: BlocConsumer<SearchCubit, SearchState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state.filterStatus == RequestStatus.loading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state.filterStatus == RequestStatus.success) {
                  return ListView(
                    controller: controller,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back_ios),
                            onPressed: () => Navigator.pop(context),
                          ),

                          const Text(
                            'Search',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      Text(
                        "Area",
                        style: TextStyles.normal14MediumBlack(
                          context,
                        ).copyWith(color: AppColors.darkNavyColor),
                      ),
                      BlocBuilder<BrowseCubit, BrowseState>(
                        builder: (context, state) {
                          return Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: state.areas!.map((a) {
                              return ChoiceChip(
                                label: Text(a.name!),
                                selected: a.name! == selectedArea!.name!,
                                onSelected: (_) {
                                  setState(() => selectedArea = a);
                                },

                                selectedColor: AppColors.secondaryColor
                                    .withOpacity(.15),
                                labelStyle: TextStyle(
                                  color: a.name! == selectedArea!.name!
                                      ? AppColors.secondaryColor
                                      : AppColors.darkGray,
                                  fontWeight: FontWeight.w600,
                                ),
                              );
                            }).toList(),
                          );
                        },
                      ),

                      const SizedBox(height: 16),

                      Text(
                        "Compound",
                        style: TextStyles.normal14MediumBlack(
                          context,
                        ).copyWith(color: AppColors.darkNavyColor),
                      ),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: widget.initial!
                            .asMap()
                            .entries
                            .map(
                              (a) => ChoiceChip(
                                label: Text(
                                  widget.initial![a.key].compound.name!,
                                ),
                                selected:
                                    widget.initial![a.key].compound.id! ==
                                    selectedCompoundId,
                                onSelected: (_) => setState(
                                  () =>
                                      selectedCompoundId = a.value.compound.id,
                                ),

                                selectedColor: AppColors.secondaryColor
                                    .withOpacity(.15),
                                labelStyle: TextStyle(
                                  color:
                                      selectedCompoundId == a.value.compound.id
                                      ? AppColors.secondaryColor
                                      : AppColors.darkGray,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      const SizedBox(height: 16),

                      Text(
                        "Bedroom",
                        style: TextStyles.normal14MediumBlack(
                          context,
                        ).copyWith(color: AppColors.darkNavyColor),
                      ),

                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: state.roomOptions!
                            .map(
                              (r) => ChoiceChip(
                                label: Text(r.toString()),
                                selected: selectBedRoom == r,
                                onSelected: (_) => setState(
                                  () => selectBedRoom = selectBedRoom == r
                                      ? null
                                      : r,
                                ),
                                selectedColor: AppColors.secondaryColor
                                    .withOpacity(.15),
                                labelStyle: TextStyle(
                                  color: selectBedRoom == r
                                      ? AppColors.secondaryColor
                                      : AppColors.darkGray,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      const SizedBox(height: 24),

                      SizedBox(
                        height: 48,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.secondaryColor,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            context
                                .read<SearchCubit>()
                                .searchByAreaId(
                                  p: PropertySearchModel(
                                    areaId: selectedArea!.id!,
                                    compoundId: selectedCompoundId,
                                  ),
                                  // selectedCompoundId,
                                  // selectBedRoom,
                                )
                                .then(
                                  (value) => AppNavigator.navigateToScreen(
                                    RoutePaths.searchResultScreen,
                                    NavigateType.pushReplacementNamed,
                                    context,
                                    extra: PropertySearchModel(
                                      areaId: selectedArea!.id,
                                      compoundId: selectedCompoundId,
                                    ),
                                  ),
                                );
                          },
                          child: const Text(
                            'SHOW RESULTS',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Text(state.message!);
                }
              },
            ),
          );
        },
      ),
    );
  }
}
