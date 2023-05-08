// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cart_delivery_option.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CartDeliveryOption _$CartDeliveryOptionFromJson(Map<String, dynamic> json) {
  return _CartDeliveryOption.fromJson(json);
}

/// @nodoc
mixin _$CartDeliveryOption {
  String? get code => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String get handle => throw _privateConstructorUsedError;
  PriceV2 get estimatedCost => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  DeliveryMethodType? get deliveryMethodType =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CartDeliveryOptionCopyWith<CartDeliveryOption> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CartDeliveryOptionCopyWith<$Res> {
  factory $CartDeliveryOptionCopyWith(
          CartDeliveryOption value, $Res Function(CartDeliveryOption) then) =
      _$CartDeliveryOptionCopyWithImpl<$Res, CartDeliveryOption>;
  @useResult
  $Res call(
      {String? code,
      String? title,
      String handle,
      PriceV2 estimatedCost,
      String? description,
      DeliveryMethodType? deliveryMethodType});

  $PriceV2CopyWith<$Res> get estimatedCost;
}

/// @nodoc
class _$CartDeliveryOptionCopyWithImpl<$Res, $Val extends CartDeliveryOption>
    implements $CartDeliveryOptionCopyWith<$Res> {
  _$CartDeliveryOptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? title = freezed,
    Object? handle = null,
    Object? estimatedCost = null,
    Object? description = freezed,
    Object? deliveryMethodType = freezed,
  }) {
    return _then(_value.copyWith(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      handle: null == handle
          ? _value.handle
          : handle // ignore: cast_nullable_to_non_nullable
              as String,
      estimatedCost: null == estimatedCost
          ? _value.estimatedCost
          : estimatedCost // ignore: cast_nullable_to_non_nullable
              as PriceV2,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      deliveryMethodType: freezed == deliveryMethodType
          ? _value.deliveryMethodType
          : deliveryMethodType // ignore: cast_nullable_to_non_nullable
              as DeliveryMethodType?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PriceV2CopyWith<$Res> get estimatedCost {
    return $PriceV2CopyWith<$Res>(_value.estimatedCost, (value) {
      return _then(_value.copyWith(estimatedCost: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_CartDeliveryOptionCopyWith<$Res>
    implements $CartDeliveryOptionCopyWith<$Res> {
  factory _$$_CartDeliveryOptionCopyWith(_$_CartDeliveryOption value,
          $Res Function(_$_CartDeliveryOption) then) =
      __$$_CartDeliveryOptionCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? code,
      String? title,
      String handle,
      PriceV2 estimatedCost,
      String? description,
      DeliveryMethodType? deliveryMethodType});

  @override
  $PriceV2CopyWith<$Res> get estimatedCost;
}

/// @nodoc
class __$$_CartDeliveryOptionCopyWithImpl<$Res>
    extends _$CartDeliveryOptionCopyWithImpl<$Res, _$_CartDeliveryOption>
    implements _$$_CartDeliveryOptionCopyWith<$Res> {
  __$$_CartDeliveryOptionCopyWithImpl(
      _$_CartDeliveryOption _value, $Res Function(_$_CartDeliveryOption) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? title = freezed,
    Object? handle = null,
    Object? estimatedCost = null,
    Object? description = freezed,
    Object? deliveryMethodType = freezed,
  }) {
    return _then(_$_CartDeliveryOption(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      handle: null == handle
          ? _value.handle
          : handle // ignore: cast_nullable_to_non_nullable
              as String,
      estimatedCost: null == estimatedCost
          ? _value.estimatedCost
          : estimatedCost // ignore: cast_nullable_to_non_nullable
              as PriceV2,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      deliveryMethodType: freezed == deliveryMethodType
          ? _value.deliveryMethodType
          : deliveryMethodType // ignore: cast_nullable_to_non_nullable
              as DeliveryMethodType?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CartDeliveryOption extends _CartDeliveryOption {
  _$_CartDeliveryOption(
      {this.code,
      this.title,
      required this.handle,
      required this.estimatedCost,
      this.description,
      this.deliveryMethodType})
      : super._();

  factory _$_CartDeliveryOption.fromJson(Map<String, dynamic> json) =>
      _$$_CartDeliveryOptionFromJson(json);

  @override
  final String? code;
  @override
  final String? title;
  @override
  final String handle;
  @override
  final PriceV2 estimatedCost;
  @override
  final String? description;
  @override
  final DeliveryMethodType? deliveryMethodType;

  @override
  String toString() {
    return 'CartDeliveryOption(code: $code, title: $title, handle: $handle, estimatedCost: $estimatedCost, description: $description, deliveryMethodType: $deliveryMethodType)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CartDeliveryOption &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.handle, handle) || other.handle == handle) &&
            (identical(other.estimatedCost, estimatedCost) ||
                other.estimatedCost == estimatedCost) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.deliveryMethodType, deliveryMethodType) ||
                other.deliveryMethodType == deliveryMethodType));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, code, title, handle,
      estimatedCost, description, deliveryMethodType);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CartDeliveryOptionCopyWith<_$_CartDeliveryOption> get copyWith =>
      __$$_CartDeliveryOptionCopyWithImpl<_$_CartDeliveryOption>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CartDeliveryOptionToJson(
      this,
    );
  }
}

abstract class _CartDeliveryOption extends CartDeliveryOption {
  factory _CartDeliveryOption(
      {final String? code,
      final String? title,
      required final String handle,
      required final PriceV2 estimatedCost,
      final String? description,
      final DeliveryMethodType? deliveryMethodType}) = _$_CartDeliveryOption;
  _CartDeliveryOption._() : super._();

  factory _CartDeliveryOption.fromJson(Map<String, dynamic> json) =
      _$_CartDeliveryOption.fromJson;

  @override
  String? get code;
  @override
  String? get title;
  @override
  String get handle;
  @override
  PriceV2 get estimatedCost;
  @override
  String? get description;
  @override
  DeliveryMethodType? get deliveryMethodType;
  @override
  @JsonKey(ignore: true)
  _$$_CartDeliveryOptionCopyWith<_$_CartDeliveryOption> get copyWith =>
      throw _privateConstructorUsedError;
}
