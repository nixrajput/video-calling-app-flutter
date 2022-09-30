import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:video_calling_app/apis/models/entities/user_avatar.dart';

part 'user.g.dart';

@CopyWith()
@JsonSerializable()
class User {
  User({
    required this.id,
    required this.fname,
    required this.lname,
    required this.email,
    required this.uname,
    this.profession,
    this.avatar,
    required this.isPrivate,
    required this.followingStatus,
    required this.accountStatus,
    required this.isVerified,
    this.deviceId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @JsonKey(name: '_id')
  final String id;

  @JsonKey(name: 'fname')
  final String fname;

  @JsonKey(name: 'lname')
  final String lname;

  @JsonKey(name: 'email')
  final String email;

  @JsonKey(name: 'uname')
  final String uname;

  @JsonKey(name: 'avatar')
  final UserAvatar? avatar;

  @JsonKey(name: 'followingStatus')
  String followingStatus;

  @JsonKey(name: 'accountStatus')
  final String accountStatus;

  @JsonKey(name: 'profession')
  final String? profession;

  @JsonKey(name: 'isPrivate')
  bool isPrivate;

  @JsonKey(name: 'isVerified')
  bool isVerified;

  @JsonKey(name: 'deviceId')
  String? deviceId;

  @JsonKey(name: 'createdAt')
  final DateTime createdAt;

  @JsonKey(name: 'updatedAt')
  final DateTime updatedAt;
}
