import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:nawy_real_state/core/constant/urls.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'api_result_model.dart';

enum HttpMethod { get, post, put, delete }

class ApiService {
  static final Dio _dio =
      Dio(
          BaseOptions(
            baseUrl: Urls.baseUrl,
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
          ),
        )
        ..interceptors.add(
          PrettyDioLogger(
            requestHeader: true,
            requestBody: true,
            responseBody: true,
            responseHeader: false,
            error: true,
            compact: true,
            maxWidth: 90,
          ),
        );

  static Future<Either<String, ApiResult<T>>> callObject<T>(
    HttpMethod method,
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    required T Function(dynamic json) fromJson,
  }) async {
    try {
      final response = await _dio.request(
        url,
        queryParameters: queryParameters,
        data: data,
        options: Options(method: method.name.toUpperCase()),
      );

      final decoded = fromJson(response.data);
      return Right(ApiResult.success(decoded));
    } on DioException catch (e) {
      return Left('Unexpected response format: }');
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, ApiResult<T>>> callList<T>(
    HttpMethod method,
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    required T Function(Map<String, dynamic> json) fromJsonItem,
  }) async {
    try {
      final response = await _dio.request(
        url,
        queryParameters: queryParameters,
        data: data,
        options: Options(method: method.name.toUpperCase()),
      );

      final body = response.data;

      // Case 1: body is a JSON array -> list of T
      if (body is List) {
        final list = body
            .map((e) => fromJsonItem((e as Map).cast<String, dynamic>()))
            .toList();
        return Right(ApiResult.successList(list));
      }

      // Case 2: body is a single JSON object -> single T
      if (body is Map) {
        // If your API sometimes wraps list under "data", optionally unwrap:
        final mapBody = body.cast<String, dynamic>();
        final maybeInner = mapBody['data'];

        if (maybeInner is List) {
          final list = maybeInner
              .map((e) => fromJsonItem((e as Map).cast<String, dynamic>()))
              .toList();
          return Right(ApiResult.successList(list));
        }

        if (maybeInner is Map) {
          final item = fromJsonItem(maybeInner.cast<String, dynamic>());
          return Right(ApiResult.success(item));
        }

        // Otherwise treat the whole body as the single item
        final item = fromJsonItem(mapBody);
        return Right(ApiResult.success(item));
      }

      // Case 3: empty / null
      if (body == null || (body is String && body.trim().isEmpty)) {
        // choose the semantics you want; here we return an empty list success
        return Right(ApiResult.successList(<T>[]));
      }

      // Fallback: unexpected shape
      return Left('Unexpected response format: ${body.runtimeType}');
    } on DioException catch (e) {
      final msg = e.response?.data is Map
          ? (e.response!.data['message']?.toString() ??
                e.message ??
                'Unknown error')
          : (e.message ?? 'Unknown error');
      return Left(msg);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
