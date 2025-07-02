// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$HomeEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() getPrayDayWork,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? getPrayDayWork,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? getPrayDayWork,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GetPrayDayWork value) getPrayDayWork,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GetPrayDayWork value)? getPrayDayWork,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GetPrayDayWork value)? getPrayDayWork,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeEventCopyWith<$Res> {
  factory $HomeEventCopyWith(HomeEvent value, $Res Function(HomeEvent) then) =
      _$HomeEventCopyWithImpl<$Res, HomeEvent>;
}

/// @nodoc
class _$HomeEventCopyWithImpl<$Res, $Val extends HomeEvent>
    implements $HomeEventCopyWith<$Res> {
  _$HomeEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$GetPrayDayWorkImplCopyWith<$Res> {
  factory _$$GetPrayDayWorkImplCopyWith(_$GetPrayDayWorkImpl value,
          $Res Function(_$GetPrayDayWorkImpl) then) =
      __$$GetPrayDayWorkImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$GetPrayDayWorkImplCopyWithImpl<$Res>
    extends _$HomeEventCopyWithImpl<$Res, _$GetPrayDayWorkImpl>
    implements _$$GetPrayDayWorkImplCopyWith<$Res> {
  __$$GetPrayDayWorkImplCopyWithImpl(
      _$GetPrayDayWorkImpl _value, $Res Function(_$GetPrayDayWorkImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$GetPrayDayWorkImpl implements GetPrayDayWork {
  const _$GetPrayDayWorkImpl();

  @override
  String toString() {
    return 'HomeEvent.getPrayDayWork()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$GetPrayDayWorkImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() getPrayDayWork,
  }) {
    return getPrayDayWork();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? getPrayDayWork,
  }) {
    return getPrayDayWork?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? getPrayDayWork,
    required TResult orElse(),
  }) {
    if (getPrayDayWork != null) {
      return getPrayDayWork();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GetPrayDayWork value) getPrayDayWork,
  }) {
    return getPrayDayWork(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GetPrayDayWork value)? getPrayDayWork,
  }) {
    return getPrayDayWork?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GetPrayDayWork value)? getPrayDayWork,
    required TResult orElse(),
  }) {
    if (getPrayDayWork != null) {
      return getPrayDayWork(this);
    }
    return orElse();
  }
}

abstract class GetPrayDayWork implements HomeEvent {
  const factory GetPrayDayWork() = _$GetPrayDayWorkImpl;
}
