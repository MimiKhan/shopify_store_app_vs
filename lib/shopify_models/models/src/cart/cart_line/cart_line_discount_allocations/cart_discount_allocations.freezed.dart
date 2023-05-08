// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cart_discount_allocations.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CartDiscountAllocations _$CartDiscountAllocationsFromJson(
    Map<String, dynamic> json) {
  return _CartDiscountAllocations.fromJson(json);
}

/// @nodoc
mixin _$CartDiscountAllocations {
  PriceV2 get discountedAmount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CartDiscountAllocationsCopyWith<CartDiscountAllocations> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CartDiscountAllocationsCopyWith<$Res> {
  factory $CartDiscountAllocationsCopyWith(CartDiscountAllocations value,
          $Res Function(CartDiscountAllocations) then) =
      _$CartDiscountAllocationsCopyWithImpl<$Res, CartDiscountAllocations>;
  @useResult
  $Res call({PriceV2 discountedAmount});

  $PriceV2CopyWith<$Res> get discountedAmount;
}

/// @nodoc
class _$CartDiscountAllocationsCopyWithImpl<$Res,
        $Val extends CartDiscountAllocations>
    implements $CartDiscountAllocationsCopyWith<$Res> {
  _$CartDiscountAllocationsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? discountedAmount = null,
  }) {
    return _then(_value.copyWith(
      discountedAmount: null == discountedAmount
          ? _value.discountedAmount
          : discountedAmount // ignore: cast_nullable_to_non_nullable
              as PriceV2,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PriceV2CopyWith<$Res> get discountedAmount {
    return $PriceV2CopyWith<$Res>(_value.discountedAmount, (value) {
      return _then(_value.copyWith(discountedAmount: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_CartDiscountAllocationsCopyWith<$Res>
    implements $CartDiscountAllocationsCopyWith<$Res> {
  factory _$$_CartDiscountAllocationsCopyWith(_$_CartDiscountAllocations value,
          $Res Function(_$_CartDiscountAllocations) then) =
      __$$_CartDiscountAllocationsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({PriceV2 discountedAmount});

  @override
  $PriceV2CopyWith<$Res> get discountedAmount;
}

/// @nodoc
class __$$_CartDiscountAllocationsCopyWithImpl<$Res>
    extends _$CartDiscountAllocationsCopyWithImpl<$Res,
        _$_CartDiscountAllocations>
    implements _$$_CartDiscountAllocationsCopyWith<$Res> {
  __$$_CartDiscountAllocationsCopyWithImpl(_$_CartDiscountAllocations _value,
      $Res Function(_$_CartDiscountAllocations) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? discountedAmount = null,
  }) {
    return _then(_$_CartDiscountAllocations(
      discountedAmount: null == discountedAmount
          ? _value.discountedAmount
          : discountedAmount // ignore: cast_nullable_to_non_nullable
              as PriceV2,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CartDiscountAllocations extends _CartDiscountAllocations {
  _$_CartDiscountAllocations({required this.discountedAmount}) : super._();

  factory _$_CartDiscountAllocations.fromJson(Map<String, dynamic> json) =>
      _$$_CartDiscountAllocationsFromJson(json);

  @override
  final PriceV2 discountedAmount;

  @override
  String toString() {
    return 'CartDiscountAllocations(discountedAmount: $discountedAmount)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CartDiscountAllocations &&
            (identical(other.discountedAmount, discountedAmount) ||
                other.discountedAmount == discountedAmount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, discountedAmount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CartDiscountAllocationsCopyWith<_$_CartDiscountAllocations>
      get copyWith =>
          __$$_CartDiscountAllocationsCopyWithImpl<_$_CartDiscountAllocations>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CartDiscountAllocationsToJson(
      this,
    );
  }
}

abstract class _CartDiscountAllocations extends CartDiscountAllocations {
  factory _CartDiscountAllocations({required final PriceV2 discountedAmount}) =
      _$_CartDiscountAllocations;
  _CartDiscountAllocations._() : super._();

  factory _CartDiscountAllocations.fromJson(Map<String, dynamic> json) =
      _$_CartDiscountAllocations.fromJson;

  @override
  PriceV2 get discountedAmount;
  @override
  @JsonKey(ignore: true)
  _$$_CartDiscountAllocationsCopyWith<_$_CartDiscountAllocations>
      get copyWith => throw _privateConstructorUsedError;
}
