// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_avatar.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UserAvatarCWProxy {
  UserAvatar publicId(String? publicId);

  UserAvatar url(String? url);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UserAvatar(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UserAvatar(...).copyWith(id: 12, name: "My name")
  /// ````
  UserAvatar call({
    String? publicId,
    String? url,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUserAvatar.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUserAvatar.copyWith.fieldName(...)`
class _$UserAvatarCWProxyImpl implements _$UserAvatarCWProxy {
  final UserAvatar _value;

  const _$UserAvatarCWProxyImpl(this._value);

  @override
  UserAvatar publicId(String? publicId) => this(publicId: publicId);

  @override
  UserAvatar url(String? url) => this(url: url);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UserAvatar(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UserAvatar(...).copyWith(id: 12, name: "My name")
  /// ````
  UserAvatar call({
    Object? publicId = const $CopyWithPlaceholder(),
    Object? url = const $CopyWithPlaceholder(),
  }) {
    return UserAvatar(
      publicId: publicId == const $CopyWithPlaceholder()
          ? _value.publicId
          // ignore: cast_nullable_to_non_nullable
          : publicId as String?,
      url: url == const $CopyWithPlaceholder()
          ? _value.url
          // ignore: cast_nullable_to_non_nullable
          : url as String?,
    );
  }
}

extension $UserAvatarCopyWith on UserAvatar {
  /// Returns a callable class that can be used as follows: `instanceOfUserAvatar.copyWith(...)` or like so:`instanceOfUserAvatar.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UserAvatarCWProxy get copyWith => _$UserAvatarCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAvatar _$UserAvatarFromJson(Map<String, dynamic> json) => UserAvatar(
      publicId: json['public_id'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$UserAvatarToJson(UserAvatar instance) =>
    <String, dynamic>{
      'public_id': instance.publicId,
      'url': instance.url,
    };
