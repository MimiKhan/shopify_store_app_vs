// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cart.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Cart _$CartFromJson(Map<String, dynamic> json) {
  return _Cart.fromJson(json);
}

/// @nodoc
mixin _$Cart {
  String get checkoutUrl => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  String get currencyCode => throw _privateConstructorUsedError;
  CartCost get cost => throw _privateConstructorUsedError;
  bool get requiresShipping => throw _privateConstructorUsedError;
  CartBuyerIdentity? get buyerIdentity => throw _privateConstructorUsedError;
  String? get createdAt => throw _privateConstructorUsedError;
  CartDiscountAllocations? get discountAllocations =>
      throw _privateConstructorUsedError;
  CartDiscountCode? get discountCodes => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;
  int get totalQuantity => throw _privateConstructorUsedError;
  String? get updatedAt => throw _privateConstructorUsedError;
  CartDeliveryGroup? get deliveryGroups => throw _privateConstructorUsedError;
  List<CartLine> get lines => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CartCopyWith<Cart> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CartCopyWith<$Res> {
  factory $CartCopyWith(Cart value, $Res Function(Cart) then) =
      _$CartCopyWithImpl<$Res, Cart>;
  @useResult
  $Res call(
      {String checkoutUrl,
      String id,
      String currencyCode,
      CartCost cost,
      bool requiresShipping,
      CartBuyerIdentity? buyerIdentity,
      String? createdAt,
      CartDiscountAllocations? discountAllocations,
      CartDiscountCode? discountCodes,
      String? note,
      int totalQuantity,
      String? updatedAt,
      CartDeliveryGroup? deliveryGroups,
      List<CartLine> lines});

  $CartCostCopyWith<$Res> get cost;
  $CartBuyerIdentityCopyWith<$Res>? get buyerIdentity;
  $CartDiscountAllocationsCopyWith<$Res>? get discountAllocations;
  $CartDiscountCodeCopyWith<$Res>? get discountCodes;
  $CartDeliveryGroupCopyWith<$Res>? get deliveryGroups;
}

/// @nodoc
class _$CartCopyWithImpl<$Res, $Val extends Cart>
    implements $CartCopyWith<$Res> {
  _$CartCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? checkoutUrl = null,
    Object? id = null,
    Object? currencyCode = null,
    Object? cost = null,
    Object? requiresShipping = null,
    Object? buyerIdentity = freezed,
    Object? createdAt = freezed,
    Object? discountAllocations = freezed,
    Object? discountCodes = freezed,
    Object? note = freezed,
    Object? totalQuantity = null,
    Object? updatedAt = freezed,
    Object? deliveryGroups = freezed,
    Object? lines = null,
  }) {
    return _then(_value.copyWith(
      checkoutUrl: null == checkoutUrl
          ? _value.checkoutUrl
          : checkoutUrl // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      currencyCode: null == currencyCode
          ? _value.currencyCode
          : currencyCode // ignore: cast_nullable_to_non_nullable
              as String,
      cost: null == cost
          ? _value.cost
          : cost // ignore: cast_nullable_to_non_nullable
              as CartCost,
      requiresShipping: null == requiresShipping
          ? _value.requiresShipping
          : requiresShipping // ignore: cast_nullable_to_non_nullable
              as bool,
      buyerIdentity: freezed == buyerIdentity
          ? _value.buyerIdentity
          : buyerIdentity // ignore: cast_nullable_to_non_nullable
              as CartBuyerIdentity?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      discountAllocations: freezed == discountAllocations
          ? _value.discountAllocations
          : discountAllocations // ignore: cast_nullable_to_non_nullable
              as CartDiscountAllocations?,
      discountCodes: freezed == discountCodes
          ? _value.discountCodes
          : discountCodes // ignore: cast_nullable_to_non_nullable
              as CartDiscountCode?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      totalQuantity: null == totalQuantity
          ? _value.totalQuantity
          : totalQuantity // ignore: cast_nullable_to_non_nullable
              as int,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      deliveryGroups: freezed == deliveryGroups
          ? _value.deliveryGroups
          : deliveryGroups // ignore: cast_nullable_to_non_nullable
              as CartDeliveryGroup?,
      lines: null == lines
          ? _value.lines
          : lines // ignore: cast_nullable_to_non_nullable
              as List<CartLine>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CartCostCopyWith<$Res> get cost {
    return $CartCostCopyWith<$Res>(_value.cost, (value) {
      return _then(_value.copyWith(cost: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CartBuyerIdentityCopyWith<$Res>? get buyerIdentity {
    if (_value.buyerIdentity == null) {
      return null;
    }

    return $CartBuyerIdentityCopyWith<$Res>(_value.buyerIdentity!, (value) {
      return _then(_value.copyWith(buyerIdentity: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CartDiscountAllocationsCopyWith<$Res>? get discountAllocations {
    if (_value.discountAllocations == null) {
      return null;
    }

    return $CartDiscountAllocationsCopyWith<$Res>(_value.discountAllocations!,
        (value) {
      return _then(_value.copyWith(discountAllocations: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CartDiscountCodeCopyWith<$Res>? get discountCodes {
    if (_value.discountCodes == null) {
      return null;
    }

    return $CartDiscountCodeCopyWith<$Res>(_value.discountCodes!, (value) {
      return _then(_value.copyWith(discountCodes: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CartDeliveryGroupCopyWith<$Res>? get deliveryGroups {
    if (_value.deliveryGroups == null) {
      return null;
    }

    return $CartDeliveryGroupCopyWith<$Res>(_value.deliveryGroups!, (value) {
      return _then(_value.copyWith(deliveryGroups: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_CartCopyWith<$Res> implements $CartCopyWith<$Res> {
  factory _$$_CartCopyWith(_$_Cart value, $Res Function(_$_Cart) then) =
      __$$_CartCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String checkoutUrl,
      String id,
      String currencyCode,
      CartCost cost,
      bool requiresShipping,
      CartBuyerIdentity? buyerIdentity,
      String? createdAt,
      CartDiscountAllocations? discountAllocations,
      CartDiscountCode? discountCodes,
      String? note,
      int totalQuantity,
      String? updatedAt,
      CartDeliveryGroup? deliveryGroups,
      List<CartLine> lines});

  @override
  $CartCostCopyWith<$Res> get cost;
  @override
  $CartBuyerIdentityCopyWith<$Res>? get buyerIdentity;
  @override
  $CartDiscountAllocationsCopyWith<$Res>? get discountAllocations;
  @override
  $CartDiscountCodeCopyWith<$Res>? get discountCodes;
  @override
  $CartDeliveryGroupCopyWith<$Res>? get deliveryGroups;
}

/// @nodoc
class __$$_CartCopyWithImpl<$Res> extends _$CartCopyWithImpl<$Res, _$_Cart>
    implements _$$_CartCopyWith<$Res> {
  __$$_CartCopyWithImpl(_$_Cart _value, $Res Function(_$_Cart) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? checkoutUrl = null,
    Object? id = null,
    Object? currencyCode = null,
    Object? cost = null,
    Object? requiresShipping = null,
    Object? buyerIdentity = freezed,
    Object? createdAt = freezed,
    Object? discountAllocations = freezed,
    Object? discountCodes = freezed,
    Object? note = freezed,
    Object? totalQuantity = null,
    Object? updatedAt = freezed,
    Object? deliveryGroups = freezed,
    Object? lines = null,
  }) {
    return _then(_$_Cart(
      checkoutUrl: null == checkoutUrl
          ? _value.checkoutUrl
          : checkoutUrl // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      currencyCode: null == currencyCode
          ? _value.currencyCode
          : currencyCode // ignore: cast_nullable_to_non_nullable
              as String,
      cost: null == cost
          ? _value.cost
          : cost // ignore: cast_nullable_to_non_nullable
              as CartCost,
      requiresShipping: null == requiresShipping
          ? _value.requiresShipping
          : requiresShipping // ignore: cast_nullable_to_non_nullable
              as bool,
      buyerIdentity: freezed == buyerIdentity
          ? _value.buyerIdentity
          : buyerIdentity // ignore: cast_nullable_to_non_nullable
              as CartBuyerIdentity?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      discountAllocations: freezed == discountAllocations
          ? _value.discountAllocations
          : discountAllocations // ignore: cast_nullable_to_non_nullable
              as CartDiscountAllocations?,
      discountCodes: freezed == discountCodes
          ? _value.discountCodes
          : discountCodes // ignore: cast_nullable_to_non_nullable
              as CartDiscountCode?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      totalQuantity: null == totalQuantity
          ? _value.totalQuantity
          : totalQuantity // ignore: cast_nullable_to_non_nullable
              as int,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      deliveryGroups: freezed == deliveryGroups
          ? _value.deliveryGroups
          : deliveryGroups // ignore: cast_nullable_to_non_nullable
              as CartDeliveryGroup?,
      lines: null == lines
          ? _value._lines
          : lines // ignore: cast_nullable_to_non_nullable
              as List<CartLine>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Cart extends _Cart {
  _$_Cart(
      {required this.checkoutUrl,
      required this.id,
      required this.currencyCode,
      required this.cost,
      required this.requiresShipping,
      this.buyerIdentity,
      this.createdAt,
      this.discountAllocations,
      this.discountCodes,
      this.note,
      required this.totalQuantity,
      this.updatedAt,
      this.deliveryGroups,
      required final List<CartLine> lines})
      : _lines = lines,
        super._();

  factory _$_Cart.fromJson(Map<String, dynamic> json) => _$$_CartFromJson(json);

  @override
  final String checkoutUrl;
  @override
  final String id;
  @override
  final String currencyCode;
  @override
  final CartCost cost;
  @override
  final bool requiresShipping;
  @override
  final CartBuyerIdentity? buyerIdentity;
  @override
  final String? createdAt;
  @override
  final CartDiscountAllocations? discountAllocations;
  @override
  final CartDiscountCode? discountCodes;
  @override
  final String? note;
  @override
  final int totalQuantity;
  @override
  final String? updatedAt;
  @override
  final CartDeliveryGroup? deliveryGroups;
  final List<CartLine> _lines;
  @override
  List<CartLine> get lines {
    if (_lines is EqualUnmodifiableListView) return _lines;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_lines);
  }

  @override
  String toString() {
    return 'Cart(checkoutUrl: $checkoutUrl, id: $id, currencyCode: $currencyCode, cost: $cost, requiresShipping: $requiresShipping, buyerIdentity: $buyerIdentity, createdAt: $createdAt, discountAllocations: $discountAllocations, discountCodes: $discountCodes, note: $note, totalQuantity: $totalQuantity, updatedAt: $updatedAt, deliveryGroups: $deliveryGroups, lines: $lines)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Cart &&
            (identical(other.checkoutUrl, checkoutUrl) ||
                other.checkoutUrl == checkoutUrl) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.currencyCode, currencyCode) ||
                other.currencyCode == currencyCode) &&
            (identical(other.cost, cost) || other.cost == cost) &&
            (identical(other.requiresShipping, requiresShipping) ||
                other.requiresShipping == requiresShipping) &&
            (identical(other.buyerIdentity, buyerIdentity) ||
                other.buyerIdentity == buyerIdentity) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.discountAllocations, discountAllocations) ||
                other.discountAllocations == discountAllocations) &&
            (identical(other.discountCodes, discountCodes) ||
                other.discountCodes == discountCodes) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.totalQuantity, totalQuantity) ||
                other.totalQuantity == totalQuantity) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.deliveryGroups, deliveryGroups) ||
                other.deliveryGroups == deliveryGroups) &&
            const DeepCollectionEquality().equals(other._lines, _lines));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      checkoutUrl,
      id,
      currencyCode,
      cost,
      requiresShipping,
      buyerIdentity,
      createdAt,
      discountAllocations,
      discountCodes,
      note,
      totalQuantity,
      updatedAt,
      deliveryGroups,
      const DeepCollectionEquality().hash(_lines));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CartCopyWith<_$_Cart> get copyWith =>
      __$$_CartCopyWithImpl<_$_Cart>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CartToJson(
      this,
    );
  }
}

abstract class _Cart extends Cart {
  factory _Cart(
      {required final String checkoutUrl,
      required final String id,
      required final String currencyCode,
      required final CartCost cost,
      required final bool requiresShipping,
      final CartBuyerIdentity? buyerIdentity,
      final String? createdAt,
      final CartDiscountAllocations? discountAllocations,
      final CartDiscountCode? discountCodes,
      final String? note,
      required final int totalQuantity,
      final String? updatedAt,
      final CartDeliveryGroup? deliveryGroups,
      required final List<CartLine> lines}) = _$_Cart;
  _Cart._() : super._();

  factory _Cart.fromJson(Map<String, dynamic> json) = _$_Cart.fromJson;

  @override
  String get checkoutUrl;
  @override
  String get id;
  @override
  String get currencyCode;
  @override
  CartCost get cost;
  @override
  bool get requiresShipping;
  @override
  CartBuyerIdentity? get buyerIdentity;
  @override
  String? get createdAt;
  @override
  CartDiscountAllocations? get discountAllocations;
  @override
  CartDiscountCode? get discountCodes;
  @override
  String? get note;
  @override
  int get totalQuantity;
  @override
  String? get updatedAt;
  @override
  CartDeliveryGroup? get deliveryGroups;
  @override
  List<CartLine> get lines;
  @override
  @JsonKey(ignore: true)
  _$$_CartCopyWith<_$_Cart> get copyWith => throw _privateConstructorUsedError;
}
