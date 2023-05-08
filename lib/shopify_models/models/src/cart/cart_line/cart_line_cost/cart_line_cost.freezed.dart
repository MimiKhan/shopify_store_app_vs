// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cart_line_cost.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CartLineCost _$CartLineCostFromJson(Map<String, dynamic> json) {
  return _CartLineCost.fromJson(json);
}

/// @nodoc
mixin _$CartLineCost {
  PriceV2 get originalUnitPrice => throw _privateConstructorUsedError;
  PriceV2? get compareAtAmountPerQuantity => throw _privateConstructorUsedError;
  PriceV2 get subTotalAmount => throw _privateConstructorUsedError;
  PriceV2 get totalAmount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CartLineCostCopyWith<CartLineCost> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CartLineCostCopyWith<$Res> {
  factory $CartLineCostCopyWith(
          CartLineCost value, $Res Function(CartLineCost) then) =
      _$CartLineCostCopyWithImpl<$Res, CartLineCost>;
  @useResult
  $Res call(
      {PriceV2 originalUnitPrice,
      PriceV2? compareAtAmountPerQuantity,
      PriceV2 subTotalAmount,
      PriceV2 totalAmount});

  $PriceV2CopyWith<$Res> get originalUnitPrice;
  $PriceV2CopyWith<$Res>? get compareAtAmountPerQuantity;
  $PriceV2CopyWith<$Res> get subTotalAmount;
  $PriceV2CopyWith<$Res> get totalAmount;
}

/// @nodoc
class _$CartLineCostCopyWithImpl<$Res, $Val extends CartLineCost>
    implements $CartLineCostCopyWith<$Res> {
  _$CartLineCostCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? originalUnitPrice = null,
    Object? compareAtAmountPerQuantity = freezed,
    Object? subTotalAmount = null,
    Object? totalAmount = null,
  }) {
    return _then(_value.copyWith(
      originalUnitPrice: null == originalUnitPrice
          ? _value.originalUnitPrice
          : originalUnitPrice // ignore: cast_nullable_to_non_nullable
              as PriceV2,
      compareAtAmountPerQuantity: freezed == compareAtAmountPerQuantity
          ? _value.compareAtAmountPerQuantity
          : compareAtAmountPerQuantity // ignore: cast_nullable_to_non_nullable
              as PriceV2?,
      subTotalAmount: null == subTotalAmount
          ? _value.subTotalAmount
          : subTotalAmount // ignore: cast_nullable_to_non_nullable
              as PriceV2,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as PriceV2,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PriceV2CopyWith<$Res> get originalUnitPrice {
    return $PriceV2CopyWith<$Res>(_value.originalUnitPrice, (value) {
      return _then(_value.copyWith(originalUnitPrice: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PriceV2CopyWith<$Res>? get compareAtAmountPerQuantity {
    if (_value.compareAtAmountPerQuantity == null) {
      return null;
    }

    return $PriceV2CopyWith<$Res>(_value.compareAtAmountPerQuantity!, (value) {
      return _then(_value.copyWith(compareAtAmountPerQuantity: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PriceV2CopyWith<$Res> get subTotalAmount {
    return $PriceV2CopyWith<$Res>(_value.subTotalAmount, (value) {
      return _then(_value.copyWith(subTotalAmount: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PriceV2CopyWith<$Res> get totalAmount {
    return $PriceV2CopyWith<$Res>(_value.totalAmount, (value) {
      return _then(_value.copyWith(totalAmount: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_CartLineCostCopyWith<$Res>
    implements $CartLineCostCopyWith<$Res> {
  factory _$$_CartLineCostCopyWith(
          _$_CartLineCost value, $Res Function(_$_CartLineCost) then) =
      __$$_CartLineCostCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {PriceV2 originalUnitPrice,
      PriceV2? compareAtAmountPerQuantity,
      PriceV2 subTotalAmount,
      PriceV2 totalAmount});

  @override
  $PriceV2CopyWith<$Res> get originalUnitPrice;
  @override
  $PriceV2CopyWith<$Res>? get compareAtAmountPerQuantity;
  @override
  $PriceV2CopyWith<$Res> get subTotalAmount;
  @override
  $PriceV2CopyWith<$Res> get totalAmount;
}

/// @nodoc
class __$$_CartLineCostCopyWithImpl<$Res>
    extends _$CartLineCostCopyWithImpl<$Res, _$_CartLineCost>
    implements _$$_CartLineCostCopyWith<$Res> {
  __$$_CartLineCostCopyWithImpl(
      _$_CartLineCost _value, $Res Function(_$_CartLineCost) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? originalUnitPrice = null,
    Object? compareAtAmountPerQuantity = freezed,
    Object? subTotalAmount = null,
    Object? totalAmount = null,
  }) {
    return _then(_$_CartLineCost(
      originalUnitPrice: null == originalUnitPrice
          ? _value.originalUnitPrice
          : originalUnitPrice // ignore: cast_nullable_to_non_nullable
              as PriceV2,
      compareAtAmountPerQuantity: freezed == compareAtAmountPerQuantity
          ? _value.compareAtAmountPerQuantity
          : compareAtAmountPerQuantity // ignore: cast_nullable_to_non_nullable
              as PriceV2?,
      subTotalAmount: null == subTotalAmount
          ? _value.subTotalAmount
          : subTotalAmount // ignore: cast_nullable_to_non_nullable
              as PriceV2,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as PriceV2,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CartLineCost extends _CartLineCost {
  _$_CartLineCost(
      {required this.originalUnitPrice,
      this.compareAtAmountPerQuantity,
      required this.subTotalAmount,
      required this.totalAmount})
      : super._();

  factory _$_CartLineCost.fromJson(Map<String, dynamic> json) =>
      _$$_CartLineCostFromJson(json);

  @override
  final PriceV2 originalUnitPrice;
  @override
  final PriceV2? compareAtAmountPerQuantity;
  @override
  final PriceV2 subTotalAmount;
  @override
  final PriceV2 totalAmount;

  @override
  String toString() {
    return 'CartLineCost(originalUnitPrice: $originalUnitPrice, compareAtAmountPerQuantity: $compareAtAmountPerQuantity, subTotalAmount: $subTotalAmount, totalAmount: $totalAmount)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CartLineCost &&
            (identical(other.originalUnitPrice, originalUnitPrice) ||
                other.originalUnitPrice == originalUnitPrice) &&
            (identical(other.compareAtAmountPerQuantity,
                    compareAtAmountPerQuantity) ||
                other.compareAtAmountPerQuantity ==
                    compareAtAmountPerQuantity) &&
            (identical(other.subTotalAmount, subTotalAmount) ||
                other.subTotalAmount == subTotalAmount) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, originalUnitPrice,
      compareAtAmountPerQuantity, subTotalAmount, totalAmount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CartLineCostCopyWith<_$_CartLineCost> get copyWith =>
      __$$_CartLineCostCopyWithImpl<_$_CartLineCost>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CartLineCostToJson(
      this,
    );
  }
}

abstract class _CartLineCost extends CartLineCost {
  factory _CartLineCost(
      {required final PriceV2 originalUnitPrice,
      final PriceV2? compareAtAmountPerQuantity,
      required final PriceV2 subTotalAmount,
      required final PriceV2 totalAmount}) = _$_CartLineCost;
  _CartLineCost._() : super._();

  factory _CartLineCost.fromJson(Map<String, dynamic> json) =
      _$_CartLineCost.fromJson;

  @override
  PriceV2 get originalUnitPrice;
  @override
  PriceV2? get compareAtAmountPerQuantity;
  @override
  PriceV2 get subTotalAmount;
  @override
  PriceV2 get totalAmount;
  @override
  @JsonKey(ignore: true)
  _$$_CartLineCostCopyWith<_$_CartLineCost> get copyWith =>
      throw _privateConstructorUsedError;
}
