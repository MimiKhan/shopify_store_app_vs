// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cart_line.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CartLine _$CartLineFromJson(Map<String, dynamic> json) {
  return _CartLine.fromJson(json);
}

/// @nodoc
mixin _$CartLine {
  String? get id => throw _privateConstructorUsedError;
  ProductVariant get merchandise => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  CartDiscountAllocations? get cartDiscountAllocations =>
      throw _privateConstructorUsedError;
  CartLineCost? get cost => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CartLineCopyWith<CartLine> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CartLineCopyWith<$Res> {
  factory $CartLineCopyWith(CartLine value, $Res Function(CartLine) then) =
      _$CartLineCopyWithImpl<$Res, CartLine>;
  @useResult
  $Res call(
      {String? id,
      ProductVariant merchandise,
      int quantity,
      CartDiscountAllocations? cartDiscountAllocations,
      CartLineCost? cost});

  $ProductVariantCopyWith<$Res> get merchandise;
  $CartDiscountAllocationsCopyWith<$Res>? get cartDiscountAllocations;
  $CartLineCostCopyWith<$Res>? get cost;
}

/// @nodoc
class _$CartLineCopyWithImpl<$Res, $Val extends CartLine>
    implements $CartLineCopyWith<$Res> {
  _$CartLineCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? merchandise = null,
    Object? quantity = null,
    Object? cartDiscountAllocations = freezed,
    Object? cost = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      merchandise: null == merchandise
          ? _value.merchandise
          : merchandise // ignore: cast_nullable_to_non_nullable
              as ProductVariant,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      cartDiscountAllocations: freezed == cartDiscountAllocations
          ? _value.cartDiscountAllocations
          : cartDiscountAllocations // ignore: cast_nullable_to_non_nullable
              as CartDiscountAllocations?,
      cost: freezed == cost
          ? _value.cost
          : cost // ignore: cast_nullable_to_non_nullable
              as CartLineCost?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ProductVariantCopyWith<$Res> get merchandise {
    return $ProductVariantCopyWith<$Res>(_value.merchandise, (value) {
      return _then(_value.copyWith(merchandise: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CartDiscountAllocationsCopyWith<$Res>? get cartDiscountAllocations {
    if (_value.cartDiscountAllocations == null) {
      return null;
    }

    return $CartDiscountAllocationsCopyWith<$Res>(
        _value.cartDiscountAllocations!, (value) {
      return _then(_value.copyWith(cartDiscountAllocations: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CartLineCostCopyWith<$Res>? get cost {
    if (_value.cost == null) {
      return null;
    }

    return $CartLineCostCopyWith<$Res>(_value.cost!, (value) {
      return _then(_value.copyWith(cost: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_CartLineCopyWith<$Res> implements $CartLineCopyWith<$Res> {
  factory _$$_CartLineCopyWith(
          _$_CartLine value, $Res Function(_$_CartLine) then) =
      __$$_CartLineCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      ProductVariant merchandise,
      int quantity,
      CartDiscountAllocations? cartDiscountAllocations,
      CartLineCost? cost});

  @override
  $ProductVariantCopyWith<$Res> get merchandise;
  @override
  $CartDiscountAllocationsCopyWith<$Res>? get cartDiscountAllocations;
  @override
  $CartLineCostCopyWith<$Res>? get cost;
}

/// @nodoc
class __$$_CartLineCopyWithImpl<$Res>
    extends _$CartLineCopyWithImpl<$Res, _$_CartLine>
    implements _$$_CartLineCopyWith<$Res> {
  __$$_CartLineCopyWithImpl(
      _$_CartLine _value, $Res Function(_$_CartLine) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? merchandise = null,
    Object? quantity = null,
    Object? cartDiscountAllocations = freezed,
    Object? cost = freezed,
  }) {
    return _then(_$_CartLine(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      merchandise: null == merchandise
          ? _value.merchandise
          : merchandise // ignore: cast_nullable_to_non_nullable
              as ProductVariant,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      cartDiscountAllocations: freezed == cartDiscountAllocations
          ? _value.cartDiscountAllocations
          : cartDiscountAllocations // ignore: cast_nullable_to_non_nullable
              as CartDiscountAllocations?,
      cost: freezed == cost
          ? _value.cost
          : cost // ignore: cast_nullable_to_non_nullable
              as CartLineCost?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CartLine extends _CartLine {
  _$_CartLine(
      {this.id,
      required this.merchandise,
      required this.quantity,
      this.cartDiscountAllocations,
      this.cost})
      : super._();

  factory _$_CartLine.fromJson(Map<String, dynamic> json) =>
      _$$_CartLineFromJson(json);

  @override
  final String? id;
  @override
  final ProductVariant merchandise;
  @override
  final int quantity;
  @override
  final CartDiscountAllocations? cartDiscountAllocations;
  @override
  final CartLineCost? cost;

  @override
  String toString() {
    return 'CartLine(id: $id, merchandise: $merchandise, quantity: $quantity, cartDiscountAllocations: $cartDiscountAllocations, cost: $cost)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CartLine &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.merchandise, merchandise) ||
                other.merchandise == merchandise) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(
                    other.cartDiscountAllocations, cartDiscountAllocations) ||
                other.cartDiscountAllocations == cartDiscountAllocations) &&
            (identical(other.cost, cost) || other.cost == cost));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, merchandise, quantity, cartDiscountAllocations, cost);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CartLineCopyWith<_$_CartLine> get copyWith =>
      __$$_CartLineCopyWithImpl<_$_CartLine>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CartLineToJson(
      this,
    );
  }
}

abstract class _CartLine extends CartLine {
  factory _CartLine(
      {final String? id,
      required final ProductVariant merchandise,
      required final int quantity,
      final CartDiscountAllocations? cartDiscountAllocations,
      final CartLineCost? cost}) = _$_CartLine;
  _CartLine._() : super._();

  factory _CartLine.fromJson(Map<String, dynamic> json) = _$_CartLine.fromJson;

  @override
  String? get id;
  @override
  ProductVariant get merchandise;
  @override
  int get quantity;
  @override
  CartDiscountAllocations? get cartDiscountAllocations;
  @override
  CartLineCost? get cost;
  @override
  @JsonKey(ignore: true)
  _$$_CartLineCopyWith<_$_CartLine> get copyWith =>
      throw _privateConstructorUsedError;
}
