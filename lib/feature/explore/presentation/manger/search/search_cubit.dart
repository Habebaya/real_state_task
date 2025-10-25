import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nawy_real_state/feature/explore/data/data_source/compound_data_source.dart';
import 'package:nawy_real_state/feature/explore/data/data_source/filter_data_source.dart';
import 'package:nawy_real_state/feature/explore/data/model/property_filter/property_search_model.dart';

import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final PropertyRemoteDataSource _repo;
  final FilterRemoteDataSource _source;

  SearchCubit(this._repo, this._source) : super(const SearchState());

  Future<void> searchByAreaId({PropertySearchModel? p}) async {
    emit(state.copyWith(searchByAreaStatus: RequestStatus.loading));
    final result = await _repo.search();

    result.fold(
      (failure) => emit(
        state.copyWith(
          searchByAreaStatus: RequestStatus.failure,
          message: failure,
        ),
      ),
      (items) {
        final filteredProperty = items.data!.values.where((item) {
          return item.area.id == p!.areaId ||
              item.compound.id == p.compoundId ||
              item.numberOfBedrooms == p.numberOfBedroom;
        }).toList();
        emit(
          state.copyWith(
            searchByAreaStatus: RequestStatus.success,
            searchResult: filteredProperty,
            message: items.message,
          ),
        );
      },
    );
  }

  Future<void> getFilter() async {
    emit(state.copyWith(filterStatus: RequestStatus.loading));
    final result = await _source.getFilterProperties();

    result.fold(
      (failure) => emit(
        state.copyWith(filterStatus: RequestStatus.failure, message: failure),
      ),
      (items) {
        List<int> roomOptions = [];
        for (
          int x = items.data!.minBedrooms!;
          x <= items.data!.maxBedrooms!;
          x++
        ) {
          roomOptions.add(x);
        }
        emit(
          state.copyWith(
            filterStatus: RequestStatus.success,
            propertyFilterModel: items.data,
            message: items.message,
            roomOptions: roomOptions,
          ),
        );
      },
    );
  }
}
