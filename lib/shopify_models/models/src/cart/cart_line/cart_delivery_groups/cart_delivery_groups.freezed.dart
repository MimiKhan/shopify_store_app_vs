// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cart_delivery_groups.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CartDeliveryGroup _$CartDeliveryGroupFromJson(Map<String, dynamic> json) {
  return _CartDeliveryGroup.fromJson(json);
}

/// @nodoc
mixin _$CartDeliveryGroup {
  String get id => throw _privateConstructorUsedError;
  CartDeliveryOption? get deliveryOptions => throw _privateConstructorUsedError;
  MailingAddress? get deliveryAddress => throw _privateConstructorUsedError;
  DeliveryMethodType get selectedDeliveryOption =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CartDeliveryGroupCopyWith<CartDeliveryGroup> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CartDeliveryGroupCopyWith<$Res> {
  factory $CartDeliveryGroupCopyWith(
          CartDeliveryGroup value, $Res Function(CartDeliveryGroup) then) =
      _$CartDeliveryGroupCopyWithImpl<$Res, CartDeliveryGroup>;
  @useResult
  $Res call(
      {String id,
      CartDeliveryOption? deliveryOptions,
      MailingAddress? deliveryAddress,
      DeliveryMethodType selectedDeliveryOption});

  $CartDeliveryOptionCopyWith<$Res>? get deliveryOptions;
  $MailingAddressCopyWith<$Res>? get deliveryAddress;
}

/// @nodoc
class _$CartDeliveryGroupCopyWithImpl<$Res, $Val extends CartDeliveryGroup>
    implements $CartDeliveryGroupCopyWith<$Res> {
  _$CartDeliveryGroupCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? deliveryOptions = freezed,
    Object? deliveryAddress = freezed,
    Object? selectedDeliveryOption = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      deliveryOptions: freezed == deliveryOptions
          ? _value.deliveryOptions
          : deliveryOptions // ignore: cast_nullable_to_non_nullable
              as CartDeliveryOption?,
      deliveryAddress: freezed == deliveryAddress
          ? _value.deliveryAddress
          : deliveryAddress // ignore: cast_nullable_to_non_nullable
              as MailingAddress?,
      selectedDeliveryOption: null == selectedDeliveryOption
          ? _value.selectedDeliveryOption
          : selectedDeliveryOption // ignore: cast_nullable_to_non_nullable
              as DeliveryMethodType,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CartDeliveryOptionCopyWith<$Res>? get deliveryOptions {
    if (_value.deliveryOptions == null) {
      return null;
    }

    return $CartDeliveryOptionCopyWith<$Res>(_value.deliveryOptions!, (value) {
      return _then(_value.copyWith(deliveryOptions: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $MailingAddressCopyWith<$Res>? get deliveryAddress {
    if (_value.deliveryAddress == null) {
      return null;
    }

    return $MailingAddressCopyWith<$Res>(_value.deliveryAddress!, (value) {
      return _then(_value.copyWith(deliveryAddress: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_CartDeliveryGroupCopyWith<$Res>
    implements $CartDeliveryGroupCopyWith<$Res> {
  factory _$$_CartDeliveryGroupCopyWith(_$_CartDeliveryGroup value,
          $Res Function(_$_CartDeliveryGroup) then) =
      __$$_CartDeliveryGroupCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      CartDeliveryOption? deliveryOptions,
      MailingAddress? deliveryAddress,
      DeliveryMethodType selectedDeliveryOption});

  @override
  $CartDeliveryOptionCopyWith<$Res>? get deliveryOptions;
  @override
  $MailingAddressCopyWith<$Res>? get deliveryAddress;
}

/// @nodoc
class __$$_CartDeliveryGroupCopyWithImpl<$Res>
    extends _$CartDeliveryGroupCopyWithImpl<$Res, _$_CartDeliveryGroup>
    implements _$$_CartDeliveryGroupCopyWith<$Res> {
  __$$_CartDeliveryGroupCopyWithImpl(
      _$_CartDeliveryGroup _value, $Res Function(_$_CartDeliveryGroup) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? deliveryOptions = freezed,
    Object? deliveryAddress = freezed,
    Object? selectedDeliveryOption = null,
  }) {
    return _then(_$_CartDeliveryGroup(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      deliveryOptions: freezed == deliveryOptions
          ? _value.deliveryOptions
          : deliveryOptions // ignore: cast_nullable_to_non_nullable
              as CartDeliveryOption?,
      deliveryAddress: freezed == deliveryAddress
          ? _value.deliveryAddress
          : deliveryAddress // ignore: cast_nullable_to_non_nullable
              as MailingAddress?,
      selectedDeliveryOption: null == selectedDeliveryOption
          ? _value.selectedDeliveryOption
          : selectedDeliveryOption // ignore: cast_nullable_to_non_nullable
              as DeliveryMethodType,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CartDeliveryGroup extends _CartDeliveryGroup {
  _$_CartDeliveryGroup(
      {required this.id,
      this.deliveryOptions,
      this.deliveryAddress,
      required this.selectedDeliveryOption})
      : super._();

  factory _$_CartDeliveryGroup.fromJson(Map<String, dynamic> json) =>
      _$$_CartDeliveryGroupFromJson(json);

  @override
  final String id;
  @override
  final CartDeliveryOption? deliveryOptions;
  @override
  final MailingAddress? deliveryAddress;
  @override
  final DeliveryMethodType selectedDeliveryOption;

  @override
  String toString() {
    return 'CartDeliveryGroup(id: $id, deliveryOptions: $deliveryOptions, deliveryAddress: $deliveryAddress, selectedDeliveryOption: $selectedDeliveryOption)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CartDeliveryGroup &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.deliveryOptions, deliveryOptions) ||
                other.deliveryOptions == deliveryOptions) &&
            (identical(other.deliveryAddress, deliveryAddress) ||
                other.deliveryAddress == deliveryAddress) &&
            (identical(other.selectedDeliveryOption, selectedDeliveryOption) ||
                other.selectedDeliveryOption == selectedDeliveryOption));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, deliveryOptions,
      deliveryAddress, selectedDeliveryOption);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CartDeliveryGroupCopyWith<_$_CartDeliveryGroup> get copyWith =>
      __$$_CartDeliveryGroupCopyWithImpl<_$_CartDeliveryGroup>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CartDeliveryGroupToJson(
      this,
    );
  }
}

abstract class _CartDeliveryGroup extends CartDeliveryGroup {
  factory _CartDeliveryGroup(
          {required final String id,
          final CartDeliveryOption? deliveryOptions,
          final MailingAddress? deliveryAddress,
          required final DeliveryMethodType selectedDeliveryOption}) =
      _$_CartDeliveryGroup;
  _CartDeliveryGroup._() : super._();

  factory _CartDeliveryGroup.fromJson(Map<String, dynamic> json) =
      _$_CartDeliveryGroup.fromJson;

  @override
  String get id;
  @override
  CartDeliveryOption? get deliveryOptions;
  @override
  MailingAddress? get deliveryAddress;
  @override
  DeliveryMethodType get selectedDeliveryOption;
  @override
  @JsonKey(ignore: true)
  _$$_CartDeliveryGroupCopyWith<_$_CartDeliveryGroup> get copyWith =>
      throw _privateConstructorUsedError;
}
