class ApiResult<T> {
  final T? data;
  final List<T>? dataList;
  final String? message;
  final bool success;

  const ApiResult({
    required this.success,
    this.data,
    this.dataList,
    this.message,
  });

  factory ApiResult.success(T data) {
    return ApiResult(success: true, data: data);
  }

  factory ApiResult.successList(List<T> data) {
    return ApiResult(success: true, dataList: data);
  }

  // Failure
  factory ApiResult.failure(String failure) {
    return ApiResult(success: false, message: failure);
  }

  bool get hasList => dataList != null;

  bool get hasSingle => data != null;

  List<T> get asList {
    if (dataList != null) return dataList!;
    if (data != null) return [data!];
    return [];
  }

  T? get singleOrNull => data;

  @override
  String toString() {
    return 'ApiResult(success: $success, message: $message, '
        'data: $data, dataList: $dataList)';
  }
}
