// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cart_buyer_identity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CartBuyerIdentity _$CartBuyerIdentityFromJson(Map<String, dynamic> json) {
  return _CartBuyerIdentity.fromJson(json);
}

/// @nodoc
mixin _$CartBuyerIdentity {
  String? get email => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  ShopifyUser? get customer => throw _privateConstructorUsedError;
  MailingAddress get deliveryAddressPreferences =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CartBuyerIdentityCopyWith<CartBuyerIdentity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CartBuyerIdentityCopyWith<$Res> {
  factory $CartBuyerIdentityCopyWith(
          CartBuyerIdentity value, $Res Function(CartBuyerIdentity) then) =
      _$CartBuyerIdentityCopyWithImpl<$Res, CartBuyerIdentity>;
  @useResult
  $Res call(
      {String? email,
      String? phone,
      ShopifyUser? customer,
      MailingAddress deliveryAddressPreferences});

  $ShopifyUserCopyWith<$Res>? get customer;
  $MailingAddressCopyWith<$Res> get deliveryAddressPreferences;
}

/// @nodoc
class _$CartBuyerIdentityCopyWithImpl<$Res, $Val extends CartBuyerIdentity>
    implements $CartBuyerIdentityCopyWith<$Res> {
  _$CartBuyerIdentityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = freezed,
    Object? phone = freezed,
    Object? customer = freezed,
    Object? deliveryAddressPreferences = null,
  }) {
    return _then(_value.copyWith(
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      customer: freezed == customer
          ? _value.customer
          : customer // ignore: cast_nullable_to_non_nullable
              as ShopifyUser?,
      deliveryAddressPreferences: null == deliveryAddressPreferences
          ? _value.deliveryAddressPreferences
          : deliveryAddressPreferences // ignore: cast_nullable_to_non_nullable
              as MailingAddress,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ShopifyUserCopyWith<$Res>? get customer {
    if (_value.customer == null) {
      return null;
    }

    return $ShopifyUserCopyWith<$Res>(_value.customer!, (value) {
      return _then(_value.copyWith(customer: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $MailingAddressCopyWith<$Res> get deliveryAddressPreferences {
    return $MailingAddressCopyWith<$Res>(_value.deliveryAddressPreferences,
        (value) {
      return _then(_value.copyWith(deliveryAddressPreferences: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_CartBuyerIdentityCopyWith<$Res>
    implements $CartBuyerIdentityCopyWith<$Res> {
  factory _$$_CartBuyerIdentityCopyWith(_$_CartBuyerIdentity value,
          $Res Function(_$_CartBuyerIdentity) then) =
      __$$_CartBuyerIdentityCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? email,
      String? phone,
      ShopifyUser? customer,
      MailingAddress deliveryAddressPreferences});

  @override
  $ShopifyUserCopyWith<$Res>? get customer;
  @override
  $MailingAddressCopyWith<$Res> get deliveryAddressPreferences;
}

/// @nodoc
class __$$_CartBuyerIdentityCopyWithImpl<$Res>
    extends _$CartBuyerIdentityCopyWithImpl<$Res, _$_CartBuyerIdentity>
    implements _$$_CartBuyerIdentityCopyWith<$Res> {
  __$$_CartBuyerIdentityCopyWithImpl(
      _$_CartBuyerIdentity _value, $Res Function(_$_CartBuyerIdentity) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = freezed,
    Object? phone = freezed,
    Object? customer = freezed,
    Object? deliveryAddressPreferences = null,
  }) {
    return _then(_$_CartBuyerIdentity(
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      customer: freezed == customer
          ? _value.customer
          : customer // ignore: cast_nullable_to_non_nullable
              as ShopifyUser?,
      deliveryAddressPreferences: null == deliveryAddressPreferences
          ? _value.deliveryAddressPreferences
          : deliveryAddressPreferences // ignore: cast_nullable_to_non_nullable
              as MailingAddress,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CartBuyerIdentity extends _CartBuyerIdentity {
  _$_CartBuyerIdentity(
      {this.email,
      this.phone,
      this.customer,
      required this.deliveryAddressPreferences})
      : super._();

  factory _$_CartBuyerIdentity.fromJson(Map<String, dynamic> json) =>
      _$$_CartBuyerIdentityFromJson(json);

  @override
  final String? email;
  @override
  final String? phone;
  @override
  final ShopifyUser? customer;
  @override
  final MailingAddress deliveryAddressPreferences;

  @override
  String toString() {
    return 'CartBuyerIdentity(email: $email, phone: $phone, customer: $customer, deliveryAddressPreferences: $deliveryAddressPreferences)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CartBuyerIdentity &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.customer, customer) ||
                other.customer == customer) &&
            (identical(other.deliveryAddressPreferences,
                    deliveryAddressPreferences) ||
                other.deliveryAddressPreferences ==
                    deliveryAddressPreferences));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, email, phone, customer, deliveryAddressPreferences);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CartBuyerIdentityCopyWith<_$_CartBuyerIdentity> get copyWith =>
      __$$_CartBuyerIdentityCopyWithImpl<_$_CartBuyerIdentity>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CartBuyerIdentityToJson(
      this,
    );
  }
}

abstract class _CartBuyerIdentity extends CartBuyerIdentity {
  factory _CartBuyerIdentity(
          {final String? email,
          final String? phone,
          final ShopifyUser? customer,
          required final MailingAddress deliveryAddressPreferences}) =
      _$_CartBuyerIdentity;
  _CartBuyerIdentity._() : super._();

  factory _CartBuyerIdentity.fromJson(Map<String, dynamic> json) =
      _$_CartBuyerIdentity.fromJson;

  @override
  String? get email;
  @override
  String? get phone;
  @override
  ShopifyUser? get customer;
  @override
  MailingAddress get deliveryAddressPreferences;
  @override
  @JsonKey(ignore: true)
  _$$_CartBuyerIdentityCopyWith<_$_CartBuyerIdentity> get copyWith =>
      throw _privateConstructorUsedError;
}
