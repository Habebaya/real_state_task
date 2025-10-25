// feature/explore/logic/compounds_cubit/compounds_state.dart
import 'package:equatable/equatable.dart';
import 'package:nawy_real_state/feature/explore/data/model/property_data_model.dart';
import 'package:nawy_real_state/feature/explore/data/model/property_filter/property_filter_model.dart';
import 'package:nawy_real_state/feature/explore/data/model/search_model.dart';

enum RequestStatus { initial, loading, success, failure }

class SearchState extends Equatable {
  final SearchResponse? searchResponse;
  final String? message;
  final List<PropertyItem>? searchResult;
  final RequestStatus? searchByAreaStatus;

  ///Filter
  ///
  final RequestStatus? filterStatus;
  final PropertyFilterModel? propertyFilterModel;
  final List<int>? roomOptions;

  const SearchState({
    this.searchByAreaStatus = RequestStatus.initial,

    this.searchResponse,

    this.searchResult,

    this.message,
    this.filterStatus = RequestStatus.initial,
    this.propertyFilterModel,
    this.roomOptions,
  });

  SearchState copyWith({
    List<PropertyItem>? searchResult,
    RequestStatus? searchByAreaStatus,
    SearchResponse? searchResponse,
    String? message,
    RequestStatus? filterStatus,
    PropertyFilterModel? propertyFilterModel,
    List<int>? roomOptions,
  }) {
    return SearchState(
      searchByAreaStatus: searchByAreaStatus ?? this.searchByAreaStatus,
      message: message ?? this.message,
      searchResult: searchResult ?? this.searchResult,
      searchResponse: searchResponse ?? this.searchResponse,
      filterStatus: filterStatus ?? this.filterStatus,
      propertyFilterModel: propertyFilterModel ?? this.propertyFilterModel,
      roomOptions: roomOptions ?? this.roomOptions,
    );
  }

  @override
  List<Object?> get props => [
    message,
    searchResult,
    searchResponse,
    searchByAreaStatus,
    propertyFilterModel,
    filterStatus,
    roomOptions,
  ];
}
