// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cart_discount_code.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CartDiscountCode _$CartDiscountCodeFromJson(Map<String, dynamic> json) {
  return _CartDiscountCode.fromJson(json);
}

/// @nodoc
mixin _$CartDiscountCode {
  String get code => throw _privateConstructorUsedError;
  bool get applicable => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CartDiscountCodeCopyWith<CartDiscountCode> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CartDiscountCodeCopyWith<$Res> {
  factory $CartDiscountCodeCopyWith(
          CartDiscountCode value, $Res Function(CartDiscountCode) then) =
      _$CartDiscountCodeCopyWithImpl<$Res, CartDiscountCode>;
  @useResult
  $Res call({String code, bool applicable});
}

/// @nodoc
class _$CartDiscountCodeCopyWithImpl<$Res, $Val extends CartDiscountCode>
    implements $CartDiscountCodeCopyWith<$Res> {
  _$CartDiscountCodeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? applicable = null,
  }) {
    return _then(_value.copyWith(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      applicable: null == applicable
          ? _value.applicable
          : applicable // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CartDiscountCodeCopyWith<$Res>
    implements $CartDiscountCodeCopyWith<$Res> {
  factory _$$_CartDiscountCodeCopyWith(
          _$_CartDiscountCode value, $Res Function(_$_CartDiscountCode) then) =
      __$$_CartDiscountCodeCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String code, bool applicable});
}

/// @nodoc
class __$$_CartDiscountCodeCopyWithImpl<$Res>
    extends _$CartDiscountCodeCopyWithImpl<$Res, _$_CartDiscountCode>
    implements _$$_CartDiscountCodeCopyWith<$Res> {
  __$$_CartDiscountCodeCopyWithImpl(
      _$_CartDiscountCode _value, $Res Function(_$_CartDiscountCode) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? applicable = null,
  }) {
    return _then(_$_CartDiscountCode(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      applicable: null == applicable
          ? _value.applicable
          : applicable // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CartDiscountCode extends _CartDiscountCode {
  _$_CartDiscountCode({required this.code, required this.applicable})
      : super._();

  factory _$_CartDiscountCode.fromJson(Map<String, dynamic> json) =>
      _$$_CartDiscountCodeFromJson(json);

  @override
  final String code;
  @override
  final bool applicable;

  @override
  String toString() {
    return 'CartDiscountCode(code: $code, applicable: $applicable)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CartDiscountCode &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.applicable, applicable) ||
                other.applicable == applicable));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, code, applicable);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CartDiscountCodeCopyWith<_$_CartDiscountCode> get copyWith =>
      __$$_CartDiscountCodeCopyWithImpl<_$_CartDiscountCode>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CartDiscountCodeToJson(
      this,
    );
  }
}

abstract class _CartDiscountCode extends CartDiscountCode {
  factory _CartDiscountCode(
      {required final String code,
      required final bool applicable}) = _$_CartDiscountCode;
  _CartDiscountCode._() : super._();

  factory _CartDiscountCode.fromJson(Map<String, dynamic> json) =
      _$_CartDiscountCode.fromJson;

  @override
  String get code;
  @override
  bool get applicable;
  @override
  @JsonKey(ignore: true)
  _$$_CartDiscountCodeCopyWith<_$_CartDiscountCode> get copyWith =>
      throw _privateConstructorUsedError;
}
