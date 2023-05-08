// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cart_cost.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CartCost _$CartCostFromJson(Map<String, dynamic> json) {
  return _CartCost.fromJson(json);
}

/// @nodoc
mixin _$CartCost {
  PriceV2? get subtotal => throw _privateConstructorUsedError;
  bool? get subTotalAmountEstimated => throw _privateConstructorUsedError;
  PriceV2? get totalTax => throw _privateConstructorUsedError;
  bool? get totalTaxAmountEstimated => throw _privateConstructorUsedError;
  PriceV2? get totalPrice => throw _privateConstructorUsedError;
  bool? get totalAmountEstimated => throw _privateConstructorUsedError;
  PriceV2? get totalDuty => throw _privateConstructorUsedError;
  bool? get totalDutyAmountEstimated => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CartCostCopyWith<CartCost> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CartCostCopyWith<$Res> {
  factory $CartCostCopyWith(CartCost value, $Res Function(CartCost) then) =
      _$CartCostCopyWithImpl<$Res, CartCost>;
  @useResult
  $Res call(
      {PriceV2? subtotal,
      bool? subTotalAmountEstimated,
      PriceV2? totalTax,
      bool? totalTaxAmountEstimated,
      PriceV2? totalPrice,
      bool? totalAmountEstimated,
      PriceV2? totalDuty,
      bool? totalDutyAmountEstimated});

  $PriceV2CopyWith<$Res>? get subtotal;
  $PriceV2CopyWith<$Res>? get totalTax;
  $PriceV2CopyWith<$Res>? get totalPrice;
  $PriceV2CopyWith<$Res>? get totalDuty;
}

/// @nodoc
class _$CartCostCopyWithImpl<$Res, $Val extends CartCost>
    implements $CartCostCopyWith<$Res> {
  _$CartCostCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? subtotal = freezed,
    Object? subTotalAmountEstimated = freezed,
    Object? totalTax = freezed,
    Object? totalTaxAmountEstimated = freezed,
    Object? totalPrice = freezed,
    Object? totalAmountEstimated = freezed,
    Object? totalDuty = freezed,
    Object? totalDutyAmountEstimated = freezed,
  }) {
    return _then(_value.copyWith(
      subtotal: freezed == subtotal
          ? _value.subtotal
          : subtotal // ignore: cast_nullable_to_non_nullable
              as PriceV2?,
      subTotalAmountEstimated: freezed == subTotalAmountEstimated
          ? _value.subTotalAmountEstimated
          : subTotalAmountEstimated // ignore: cast_nullable_to_non_nullable
              as bool?,
      totalTax: freezed == totalTax
          ? _value.totalTax
          : totalTax // ignore: cast_nullable_to_non_nullable
              as PriceV2?,
      totalTaxAmountEstimated: freezed == totalTaxAmountEstimated
          ? _value.totalTaxAmountEstimated
          : totalTaxAmountEstimated // ignore: cast_nullable_to_non_nullable
              as bool?,
      totalPrice: freezed == totalPrice
          ? _value.totalPrice
          : totalPrice // ignore: cast_nullable_to_non_nullable
              as PriceV2?,
      totalAmountEstimated: freezed == totalAmountEstimated
          ? _value.totalAmountEstimated
          : totalAmountEstimated // ignore: cast_nullable_to_non_nullable
              as bool?,
      totalDuty: freezed == totalDuty
          ? _value.totalDuty
          : totalDuty // ignore: cast_nullable_to_non_nullable
              as PriceV2?,
      totalDutyAmountEstimated: freezed == totalDutyAmountEstimated
          ? _value.totalDutyAmountEstimated
          : totalDutyAmountEstimated // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PriceV2CopyWith<$Res>? get subtotal {
    if (_value.subtotal == null) {
      return null;
    }

    return $PriceV2CopyWith<$Res>(_value.subtotal!, (value) {
      return _then(_value.copyWith(subtotal: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PriceV2CopyWith<$Res>? get totalTax {
    if (_value.totalTax == null) {
      return null;
    }

    return $PriceV2CopyWith<$Res>(_value.totalTax!, (value) {
      return _then(_value.copyWith(totalTax: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PriceV2CopyWith<$Res>? get totalPrice {
    if (_value.totalPrice == null) {
      return null;
    }

    return $PriceV2CopyWith<$Res>(_value.totalPrice!, (value) {
      return _then(_value.copyWith(totalPrice: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PriceV2CopyWith<$Res>? get totalDuty {
    if (_value.totalDuty == null) {
      return null;
    }

    return $PriceV2CopyWith<$Res>(_value.totalDuty!, (value) {
      return _then(_value.copyWith(totalDuty: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_CartCostCopyWith<$Res> implements $CartCostCopyWith<$Res> {
  factory _$$_CartCostCopyWith(
          _$_CartCost value, $Res Function(_$_CartCost) then) =
      __$$_CartCostCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {PriceV2? subtotal,
      bool? subTotalAmountEstimated,
      PriceV2? totalTax,
      bool? totalTaxAmountEstimated,
      PriceV2? totalPrice,
      bool? totalAmountEstimated,
      PriceV2? totalDuty,
      bool? totalDutyAmountEstimated});

  @override
  $PriceV2CopyWith<$Res>? get subtotal;
  @override
  $PriceV2CopyWith<$Res>? get totalTax;
  @override
  $PriceV2CopyWith<$Res>? get totalPrice;
  @override
  $PriceV2CopyWith<$Res>? get totalDuty;
}

/// @nodoc
class __$$_CartCostCopyWithImpl<$Res>
    extends _$CartCostCopyWithImpl<$Res, _$_CartCost>
    implements _$$_CartCostCopyWith<$Res> {
  __$$_CartCostCopyWithImpl(
      _$_CartCost _value, $Res Function(_$_CartCost) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? subtotal = freezed,
    Object? subTotalAmountEstimated = freezed,
    Object? totalTax = freezed,
    Object? totalTaxAmountEstimated = freezed,
    Object? totalPrice = freezed,
    Object? totalAmountEstimated = freezed,
    Object? totalDuty = freezed,
    Object? totalDutyAmountEstimated = freezed,
  }) {
    return _then(_$_CartCost(
      subtotal: freezed == subtotal
          ? _value.subtotal
          : subtotal // ignore: cast_nullable_to_non_nullable
              as PriceV2?,
      subTotalAmountEstimated: freezed == subTotalAmountEstimated
          ? _value.subTotalAmountEstimated
          : subTotalAmountEstimated // ignore: cast_nullable_to_non_nullable
              as bool?,
      totalTax: freezed == totalTax
          ? _value.totalTax
          : totalTax // ignore: cast_nullable_to_non_nullable
              as PriceV2?,
      totalTaxAmountEstimated: freezed == totalTaxAmountEstimated
          ? _value.totalTaxAmountEstimated
          : totalTaxAmountEstimated // ignore: cast_nullable_to_non_nullable
              as bool?,
      totalPrice: freezed == totalPrice
          ? _value.totalPrice
          : totalPrice // ignore: cast_nullable_to_non_nullable
              as PriceV2?,
      totalAmountEstimated: freezed == totalAmountEstimated
          ? _value.totalAmountEstimated
          : totalAmountEstimated // ignore: cast_nullable_to_non_nullable
              as bool?,
      totalDuty: freezed == totalDuty
          ? _value.totalDuty
          : totalDuty // ignore: cast_nullable_to_non_nullable
              as PriceV2?,
      totalDutyAmountEstimated: freezed == totalDutyAmountEstimated
          ? _value.totalDutyAmountEstimated
          : totalDutyAmountEstimated // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CartCost extends _CartCost {
  _$_CartCost(
      {this.subtotal,
      this.subTotalAmountEstimated,
      this.totalTax,
      this.totalTaxAmountEstimated,
      this.totalPrice,
      this.totalAmountEstimated,
      this.totalDuty,
      this.totalDutyAmountEstimated})
      : super._();

  factory _$_CartCost.fromJson(Map<String, dynamic> json) =>
      _$$_CartCostFromJson(json);

  @override
  final PriceV2? subtotal;
  @override
  final bool? subTotalAmountEstimated;
  @override
  final PriceV2? totalTax;
  @override
  final bool? totalTaxAmountEstimated;
  @override
  final PriceV2? totalPrice;
  @override
  final bool? totalAmountEstimated;
  @override
  final PriceV2? totalDuty;
  @override
  final bool? totalDutyAmountEstimated;

  @override
  String toString() {
    return 'CartCost(subtotal: $subtotal, subTotalAmountEstimated: $subTotalAmountEstimated, totalTax: $totalTax, totalTaxAmountEstimated: $totalTaxAmountEstimated, totalPrice: $totalPrice, totalAmountEstimated: $totalAmountEstimated, totalDuty: $totalDuty, totalDutyAmountEstimated: $totalDutyAmountEstimated)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CartCost &&
            (identical(other.subtotal, subtotal) ||
                other.subtotal == subtotal) &&
            (identical(
                    other.subTotalAmountEstimated, subTotalAmountEstimated) ||
                other.subTotalAmountEstimated == subTotalAmountEstimated) &&
            (identical(other.totalTax, totalTax) ||
                other.totalTax == totalTax) &&
            (identical(
                    other.totalTaxAmountEstimated, totalTaxAmountEstimated) ||
                other.totalTaxAmountEstimated == totalTaxAmountEstimated) &&
            (identical(other.totalPrice, totalPrice) ||
                other.totalPrice == totalPrice) &&
            (identical(other.totalAmountEstimated, totalAmountEstimated) ||
                other.totalAmountEstimated == totalAmountEstimated) &&
            (identical(other.totalDuty, totalDuty) ||
                other.totalDuty == totalDuty) &&
            (identical(
                    other.totalDutyAmountEstimated, totalDutyAmountEstimated) ||
                other.totalDutyAmountEstimated == totalDutyAmountEstimated));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      subtotal,
      subTotalAmountEstimated,
      totalTax,
      totalTaxAmountEstimated,
      totalPrice,
      totalAmountEstimated,
      totalDuty,
      totalDutyAmountEstimated);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CartCostCopyWith<_$_CartCost> get copyWith =>
      __$$_CartCostCopyWithImpl<_$_CartCost>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CartCostToJson(
      this,
    );
  }
}

abstract class _CartCost extends CartCost {
  factory _CartCost(
      {final PriceV2? subtotal,
      final bool? subTotalAmountEstimated,
      final PriceV2? totalTax,
      final bool? totalTaxAmountEstimated,
      final PriceV2? totalPrice,
      final bool? totalAmountEstimated,
      final PriceV2? totalDuty,
      final bool? totalDutyAmountEstimated}) = _$_CartCost;
  _CartCost._() : super._();

  factory _CartCost.fromJson(Map<String, dynamic> json) = _$_CartCost.fromJson;

  @override
  PriceV2? get subtotal;
  @override
  bool? get subTotalAmountEstimated;
  @override
  PriceV2? get totalTax;
  @override
  bool? get totalTaxAmountEstimated;
  @override
  PriceV2? get totalPrice;
  @override
  bool? get totalAmountEstimated;
  @override
  PriceV2? get totalDuty;
  @override
  bool? get totalDutyAmountEstimated;
  @override
  @JsonKey(ignore: true)
  _$$_CartCostCopyWith<_$_CartCost> get copyWith =>
      throw _privateConstructorUsedError;
}
