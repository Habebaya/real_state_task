// feature/explore/logic/compounds_cubit/compounds_state.dart
import 'package:equatable/equatable.dart';
import 'package:nawy_real_state/feature/explore/data/model/location_data_model.dart';
import 'package:nawy_real_state/feature/explore/presentation/manger/search/search_state.dart';

import '../../data/model/compound_data_model.dart';

class BrowseState extends Equatable {
  final List<CompoundDataModel>? compounds;
  final List<LocationModel>? areas;
  final RequestStatus? status;
  final RequestStatus? getAreaStatus;
  final String? message;
  final RequestStatus? searchStatus;

  final List<LocationModel>? areaResult;
  final List<CompoundDataModel>? compoundResult;

  final List<dynamic>? result;
  final RequestStatus? searchByAreaStatus;

  const BrowseState({
    this.status = RequestStatus.initial,
    this.searchStatus = RequestStatus.initial,
    this.getAreaStatus = RequestStatus.initial,
    this.searchByAreaStatus = RequestStatus.initial,

    this.areaResult,

    this.compoundResult,

    this.areas,
    this.result,

    this.compounds,
    this.message,
  });

  BrowseState copyWith({
    RequestStatus? status,
    RequestStatus? searchStatus,
    List<LocationModel>? areas,
    List<dynamic>? result,
    RequestStatus? searchByAreaStatus,

    RequestStatus? getAreaStatus,

    List<CompoundDataModel>? compounds,
    List<LocationModel>? areaResult,
    List<CompoundDataModel>? compoundResult,

    String? error, // pass null explicitly to clear
  }) {
    return BrowseState(
      searchStatus: searchStatus ?? this.searchStatus,
      status: status ?? this.status,
      compounds: compounds ?? this.compounds,
      searchByAreaStatus: searchByAreaStatus ?? this.searchByAreaStatus,
      message: message ?? message,
      areaResult: areaResult ?? this.areaResult,
      compoundResult: compoundResult ?? this.compoundResult,
      getAreaStatus: getAreaStatus ?? this.getAreaStatus,
      areas: areas ?? this.areas,
      result: result ?? this.result,
    );
  }

  @override
  List<Object?> get props => [
    status,
    compounds,
    message,
    searchStatus,
    areas,
    getAreaStatus,
    compoundResult,
    result,
  ];
}
