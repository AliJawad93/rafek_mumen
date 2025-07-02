import 'package:freezed_annotation/freezed_annotation.dart';

import 'data_state.dart';

part 'bloc_state.freezed.dart';

@freezed
class BlocState<T> with _$BlocState<T> {
  const factory BlocState.initial() = Initial;
  const factory BlocState.loading() = Loading;
  const factory BlocState.data(T results) = Data;
  const factory BlocState.failure(ApiError error) = Failure;
}
