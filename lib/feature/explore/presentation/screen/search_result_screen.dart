import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nawy_real_state/core/constant/widget/loading_list_widget.dart';
import 'package:nawy_real_state/core/service_locator.dart';
import 'package:nawy_real_state/feature/explore/data/model/property_data_model.dart';
import 'package:nawy_real_state/feature/explore/presentation/manger/search/search_cubit.dart';
import 'package:nawy_real_state/feature/explore/presentation/manger/search/search_state.dart';

import '../../../../core/constant/widget/empty_list_widget.dart';
import '../../../../filter_bottom_sheet.dart';
import '../../data/model/property_filter/property_search_model.dart';
import '../widget/search_result_tile.dart';

class SearchResultScreen extends StatelessWidget {
  final PropertySearchModel? propertySearchModel;

  const SearchResultScreen({super.key, required this.propertySearchModel});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SearchCubit(getIt(), getIt())..searchByAreaId(p: propertySearchModel),
      child: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          if (state.searchByAreaStatus == RequestStatus.loading) {
            return LoadingList();
          } else if (state.searchByAreaStatus == RequestStatus.success) {
            if (state.searchResult!.isEmpty) {
              return EmptyResults();
            } else {
              return Scaffold(
                appBar: AppBar(
                  title: Text("Results"),
                  centerTitle: false,
                  actions: [
                    IconButton(
                      tooltip: 'Filter',
                      onPressed: () async {
                        showModalBottomSheet<PropertyItem>(
                          context: context,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(16),
                            ),
                          ),
                          builder: (_) =>
                              FilterSheet(initial: state.searchResult!),
                        );
                      },

                      icon: const Icon(Icons.filter_list_alt),
                    ),
                  ],
                ),
                body: ListView.separated(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                  itemCount: state.searchResult!.length,
                  separatorBuilder: (_, __) => 10.verticalSpace,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      child: SearchResultTile(
                        property: state.searchResult![index],
                      ),
                    );
                  },
                ),
              );
            }
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }
}
