import 'package:json_annotation/json_annotation.dart';
import 'package:video_calling_app/apis/models/entities/user_avatar.dart';

part 'user_details.g.dart';

@JsonSerializable()
class UserDetails {
  UserDetails({
    required this.id,
    required this.fname,
    required this.lname,
    required this.email,
    required this.uname,
    this.avatar,
    this.gender,
    this.dob,
    this.about,
    required this.profession,
    required this.role,
    required this.accountType,
    required this.accountStatus,
    required this.isVerified,
    required this.createdAt,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) =>
      _$UserDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$UserDetailsToJson(this);

  @JsonKey(name: '_id')
  String id;

  @JsonKey(name: 'fname')
  String fname;

  @JsonKey(name: 'lname')
  String lname;

  @JsonKey(name: 'email')
  String email;

  @JsonKey(name: 'uname')
  String uname;

  @JsonKey(name: 'avatar')
  UserAvatar? avatar;

  @JsonKey(name: 'gender')
  String? gender;

  @JsonKey(name: 'dob')
  String? dob;

  @JsonKey(name: 'about')
  String? about;

  @JsonKey(name: 'profession')
  String profession;

  @JsonKey(name: 'role')
  String role;

  @JsonKey(name: 'accountType')
  String accountType;

  @JsonKey(name: 'accountStatus')
  String accountStatus;

  @JsonKey(name: 'isVerified')
  bool isVerified;

  @JsonKey(name: 'createdAt')
  DateTime createdAt;
}
