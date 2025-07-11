// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quran_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$QuranEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() getQuranSurahs,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? getQuranSurahs,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? getQuranSurahs,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GetQuranSurahsEvent value) getQuranSurahs,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GetQuranSurahsEvent value)? getQuranSurahs,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GetQuranSurahsEvent value)? getQuranSurahs,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuranEventCopyWith<$Res> {
  factory $QuranEventCopyWith(
          QuranEvent value, $Res Function(QuranEvent) then) =
      _$QuranEventCopyWithImpl<$Res, QuranEvent>;
}

/// @nodoc
class _$QuranEventCopyWithImpl<$Res, $Val extends QuranEvent>
    implements $QuranEventCopyWith<$Res> {
  _$QuranEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$GetQuranSurahsEventImplCopyWith<$Res> {
  factory _$$GetQuranSurahsEventImplCopyWith(_$GetQuranSurahsEventImpl value,
          $Res Function(_$GetQuranSurahsEventImpl) then) =
      __$$GetQuranSurahsEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$GetQuranSurahsEventImplCopyWithImpl<$Res>
    extends _$QuranEventCopyWithImpl<$Res, _$GetQuranSurahsEventImpl>
    implements _$$GetQuranSurahsEventImplCopyWith<$Res> {
  __$$GetQuranSurahsEventImplCopyWithImpl(_$GetQuranSurahsEventImpl _value,
      $Res Function(_$GetQuranSurahsEventImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$GetQuranSurahsEventImpl implements GetQuranSurahsEvent {
  const _$GetQuranSurahsEventImpl();

  @override
  String toString() {
    return 'QuranEvent.getQuranSurahs()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetQuranSurahsEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() getQuranSurahs,
  }) {
    return getQuranSurahs();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? getQuranSurahs,
  }) {
    return getQuranSurahs?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? getQuranSurahs,
    required TResult orElse(),
  }) {
    if (getQuranSurahs != null) {
      return getQuranSurahs();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GetQuranSurahsEvent value) getQuranSurahs,
  }) {
    return getQuranSurahs(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GetQuranSurahsEvent value)? getQuranSurahs,
  }) {
    return getQuranSurahs?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GetQuranSurahsEvent value)? getQuranSurahs,
    required TResult orElse(),
  }) {
    if (getQuranSurahs != null) {
      return getQuranSurahs(this);
    }
    return orElse();
  }
}

abstract class GetQuranSurahsEvent implements QuranEvent {
  const factory GetQuranSurahsEvent() = _$GetQuranSurahsEventImpl;
}
