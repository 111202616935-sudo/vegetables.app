import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:retrofit/dio.dart';

import '../../utility/resource/data_state.dart';

abstract class BaseRepository {
  /// Membungkus request API Retrofit dan mengembalikan DataStateSuccess atau DataStateError
  @protected
  Future<DataState<T>> getStateOf<T>({
    required Future<HttpResponse<T>> Function() request,
  }) async {
    try {
      final httpResponse = await request();
      if (httpResponse.response.statusCode == HttpStatus.ok ||
          httpResponse.response.statusCode == HttpStatus.created) {
        return DataStateSuccess(httpResponse.data);
      } else {
        throw DioException(
          response: httpResponse.response,
          requestOptions: httpResponse.response.requestOptions,
          message: httpResponse.response.statusMessage,
        );
      }
    } on DioException catch (error, stackTrace) {
      if (kDebugMode) {
        debugPrint(error.toString());
      }
      try {
        FirebaseCrashlytics.instance.recordError(error, stackTrace);
      } catch (_) {}
      return DataStateError(error);
    } catch (error, stackTrace) {
      if (kDebugMode) {
        debugPrint(error.toString());
      }
      try {
        FirebaseCrashlytics.instance.recordError(error, stackTrace);
      } catch (_) {}
      final dioError = DioException(
        response: null,
        requestOptions: RequestOptions(),
        message: error.toString(),
      );
      return DataStateError(dioError);
    }
  }
}
