import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_avatar.g.dart';

@CopyWith()
@JsonSerializable()
class UserAvatar {
  UserAvatar({
    this.publicId,
    this.url,
  });

  factory UserAvatar.fromJson(Map<String, dynamic> json) =>
      _$UserAvatarFromJson(json);

  Map<String, dynamic> toJson() => _$UserAvatarToJson(this);

  @JsonKey(name: 'public_id')
  String? publicId;

  @JsonKey(name: 'url')
  String? url;
}
