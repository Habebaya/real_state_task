// feature/explore/logic/browse_cubit/browse_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nawy_real_state/feature/explore/data/data_source/compound_data_source.dart';
import 'package:nawy_real_state/feature/explore/presentation/manger/search/search_state.dart';

import 'browse_state.dart';

class BrowseCubit extends Cubit<BrowseState> {
  final PropertyRemoteDataSource _repo;

  BrowseCubit(this._repo) : super(const BrowseState());

  Future<void> fetchCompounds() async {
    emit(state.copyWith(status: RequestStatus.loading, error: null));

    final result = await _repo.getCompounds();

    result.fold(
      (failure) =>
          emit(state.copyWith(status: RequestStatus.failure, error: failure)),
      (items) => emit(
        state.copyWith(
          status: RequestStatus.success,
          compounds: items.dataList,
          error: null,
        ),
      ),
    );
  }

  Future<void> fetchAreas() async {
    emit(state.copyWith(getAreaStatus: RequestStatus.loading, error: null));

    final result = await _repo.getAreas();

    result.fold(
      (failure) => emit(
        state.copyWith(getAreaStatus: RequestStatus.failure, error: failure),
      ),
      (items) => emit(
        state.copyWith(
          getAreaStatus: RequestStatus.success,
          areas: items.dataList,
        ),
      ),
    );
  }

  Future<void> searchByCategory(String q, int tabIndex) async {
    final query = q.trim().toUpperCase();
    emit(state.copyWith(searchStatus: RequestStatus.loading));

    await Future.delayed(const Duration(milliseconds: 200));

    if (query.isEmpty) {
      emit(
        state.copyWith(searchStatus: RequestStatus.initial, compoundResult: []),
      );
      return;
    } else {
      if (tabIndex == 0) {
        final filteredArea = state.compounds!.where((item) {
          return item.name.trim().toUpperCase().contains(query);
        }).toList();
        final filteredCompound = state.areas!.where((item) {
          return item.name!.trim().toUpperCase().contains(query);
        }).toList();

        final combinedResults = [...filteredArea, ...filteredCompound];

        emit(
          state.copyWith(
            searchStatus: RequestStatus.success,
            result: combinedResults,
          ),
        );
      } else if (tabIndex == 1) {
        final filtered = state.compounds!.where((item) {
          return item.name.trim().toUpperCase().contains(query);
        }).toList();

        emit(
          state.copyWith(
            searchStatus: RequestStatus.success,
            compoundResult: filtered,
          ),
        );
      } else {
        final filtered = state.areas!.where((item) {
          return item.name!.trim().toUpperCase().contains(query);
        }).toList();

        emit(
          state.copyWith(
            searchStatus: RequestStatus.success,
            areaResult: filtered,
          ),
        );
      }
    }
  }
}
