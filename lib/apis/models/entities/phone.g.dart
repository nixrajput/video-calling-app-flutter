// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phone.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PhoneCWProxy {
  Phone countryCode(String? countryCode);

  Phone phoneNo(String? phoneNo);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Phone(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Phone(...).copyWith(id: 12, name: "My name")
  /// ````
  Phone call({
    String? countryCode,
    String? phoneNo,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPhone.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPhone.copyWith.fieldName(...)`
class _$PhoneCWProxyImpl implements _$PhoneCWProxy {
  final Phone _value;

  const _$PhoneCWProxyImpl(this._value);

  @override
  Phone countryCode(String? countryCode) => this(countryCode: countryCode);

  @override
  Phone phoneNo(String? phoneNo) => this(phoneNo: phoneNo);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Phone(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Phone(...).copyWith(id: 12, name: "My name")
  /// ````
  Phone call({
    Object? countryCode = const $CopyWithPlaceholder(),
    Object? phoneNo = const $CopyWithPlaceholder(),
  }) {
    return Phone(
      countryCode: countryCode == const $CopyWithPlaceholder()
          ? _value.countryCode
          // ignore: cast_nullable_to_non_nullable
          : countryCode as String?,
      phoneNo: phoneNo == const $CopyWithPlaceholder()
          ? _value.phoneNo
          // ignore: cast_nullable_to_non_nullable
          : phoneNo as String?,
    );
  }
}

extension $PhoneCopyWith on Phone {
  /// Returns a callable class that can be used as follows: `instanceOfPhone.copyWith(...)` or like so:`instanceOfPhone.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PhoneCWProxy get copyWith => _$PhoneCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Phone _$PhoneFromJson(Map<String, dynamic> json) => Phone(
      countryCode: json['countryCode'] as String?,
      phoneNo: json['phoneNo'] as String?,
    );

Map<String, dynamic> _$PhoneToJson(Phone instance) => <String, dynamic>{
      'countryCode': instance.countryCode,
      'phoneNo': instance.phoneNo,
    };
