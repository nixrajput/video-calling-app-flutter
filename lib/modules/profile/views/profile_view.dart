import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_calling_app/apis/models/entities/user_avatar.dart';
import 'package:video_calling_app/apis/services/auth_service.dart';
import 'package:video_calling_app/common/circular_asset_image.dart';
import 'package:video_calling_app/common/circular_network_image.dart';
import 'package:video_calling_app/common/custom_app_bar.dart';
import 'package:video_calling_app/common/primary_filled_btn.dart';
import 'package:video_calling_app/common/primary_icon_btn.dart';
import 'package:video_calling_app/common/primary_outlined_btn.dart';
import 'package:video_calling_app/common/primary_text_btn.dart';
import 'package:video_calling_app/constants/dimens.dart';
import 'package:video_calling_app/constants/strings.dart';
import 'package:video_calling_app/constants/styles.dart';
import 'package:video_calling_app/helpers/utility.dart';
import 'package:video_calling_app/modules/profile/controllers/edit_profile_picture_controller.dart';
import 'package:video_calling_app/modules/profile/controllers/profile_controller.dart';
import 'package:video_calling_app/routes/route_management.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        width: Dimens.screenWidth,
        height: Dimens.screenHeight,
        child: Column(
          children: [
            NxAppBar(
              title: StringValues.profile,
              padding: Dimens.edgeInsets8_16,
            ),
            Expanded(
              child: Padding(
                padding: Dimens.edgeInsets8_16,
                child: GetBuilder<ProfileController>(
                  builder: (logic) {
                    if (logic.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GetBuilder<EditProfilePictureController>(
                            builder: (con) => GestureDetector(
                              onTap: () => _showProfilePictureDialog(logic),
                              child: _buildProfileImage(
                                  logic.profileDetails!.user!.avatar),
                            ),
                          ),
                          Dimens.boxHeight16,
                          _buildUserDetails(logic),
                          Dimens.dividerWithHeight,
                          Dimens.boxHeight8,
                          _buildActionButtons(),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }

  Widget _buildProfileImage(UserAvatar? avatar, {double? size}) {
    if (avatar != null && avatar.url != null) {
      return NxCircleNetworkImage(
        imageUrl: avatar.url!,
        radius: size ?? Dimens.eighty,
      );
    }
    return NxCircleAssetImage(
      imgAsset: AssetValues.avatar,
      radius: size ?? Dimens.eighty,
    );
  }

  Widget _buildUserDetails(ProfileController logic) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${logic.profileDetails!.user!.fname} ${logic.profileDetails!.user!.lname}',
            style: AppStyles.style20Bold,
          ),
          Text(
            "@${logic.profileDetails!.user!.uname}",
            style: TextStyle(
              fontSize: Dimens.sixTeen,
              color: Theme.of(Get.context!).textTheme.subtitle1!.color,
            ),
          ),
          Dimens.boxHeight16,
        ],
      );

  Widget _buildActionButtons() => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const NxTextButton(
            label: StringValues.changePassword,
            onTap: RouteManagement.goToChangePasswordView,
          ),
          Dimens.boxHeight16,
          const NxTextButton(
            label: StringValues.changeName,
            onTap: RouteManagement.goToEditNameView,
          ),
          Dimens.boxHeight16,
          const NxTextButton(
            label: StringValues.changeUsername,
            onTap: RouteManagement.goToEditUsernameView,
          ),
          Dimens.boxHeight16,
          NxFilledButton(
            label: StringValues.logout.toUpperCase(),
            onTap: () {
              Get.find<AuthService>().logout();
              RouteManagement.goToLoginView();
            },
          ),
        ],
      );

  void _showProfilePictureDialog(ProfileController logic) {
    AppUtility.showSimpleDialog(
      GetBuilder<EditProfilePictureController>(
        builder: (con) => Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: Dimens.edgeInsets16.copyWith(
                bottom: Dimens.zero,
              ),
              child: Row(
                children: [
                  Text(
                    'Profile Picture',
                    style: AppStyles.style18Bold,
                  ),
                  const Spacer(),
                  NxIconButton(
                    icon: Icons.close,
                    iconSize: Dimens.thirtyTwo,
                    iconColor:
                        Theme.of(Get.context!).textTheme.bodyText1!.color,
                    onTap: AppUtility.closeDialog,
                  ),
                ],
              ),
            ),
            Dimens.dividerWithHeight,
            Dimens.boxHeight8,
            _buildProfileImage(
              logic.profileDetails!.user?.avatar,
              size: Dimens.screenWidth * 0.4,
            ),
            Dimens.boxHeight16,
            Dimens.dividerWithHeight,
            Dimens.boxHeight16,
            Padding(
              padding: Dimens.edgeInsets0_16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: NxOutlinedButton(
                        width: Dimens.hundred,
                        height: Dimens.thirtySix,
                        label: 'Change',
                        borderColor:
                            Theme.of(Get.context!).textTheme.bodyText1!.color,
                        labelStyle: AppStyles.style14Normal.copyWith(
                          color:
                              Theme.of(Get.context!).textTheme.bodyText1!.color,
                        ),
                        onTap: () {
                          AppUtility.closeDialog();
                          con.chooseImage();
                        }),
                  ),
                  Dimens.boxWidth16,
                  Expanded(
                    child: NxOutlinedButton(
                      width: Dimens.hundred,
                      height: Dimens.thirtySix,
                      label: 'Remove',
                      borderColor:
                          Theme.of(Get.context!).textTheme.bodyText1!.color,
                      labelStyle: AppStyles.style14Normal.copyWith(
                        color:
                            Theme.of(Get.context!).textTheme.bodyText1!.color,
                      ),
                      onTap: () {
                        AppUtility.closeDialog();
                        con.removeProfilePicture();
                      },
                    ),
                  ),
                ],
              ),
            ),
            Dimens.boxHeight24,
          ],
        ),
      ),
    );
  }
}
