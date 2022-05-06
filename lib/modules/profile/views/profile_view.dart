import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_calling_app/apis/services/auth_service.dart';
import 'package:video_calling_app/common/circular_asset_image.dart';
import 'package:video_calling_app/common/circular_network_image.dart';
import 'package:video_calling_app/common/custom_app_bar.dart';
import 'package:video_calling_app/common/primary_filled_btn.dart';
import 'package:video_calling_app/constants/dimens.dart';
import 'package:video_calling_app/constants/strings.dart';
import 'package:video_calling_app/constants/styles.dart';
import 'package:video_calling_app/modules/profile/controllers/profile_controller.dart';

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
            const NxAppBar(
              title: StringValues.profile,
            ),
            Expanded(
              child: Padding(
                padding: Dimens.edgeInsets8,
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
                          _buildProfileImage(logic),
                          Dimens.boxHeight16,
                          _buildUserDetails(logic),
                          Dimens.dividerWithHeight,
                          Dimens.boxHeight16,
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

  Widget _buildProfileImage(ProfileController logic) {
    if (logic.profileData.user != null &&
        logic.profileData.user!.avatar != null) {
      return NxCircleNetworkImage(
        imageUrl: logic.profileData.user!.avatar!.url!,
        radius: Dimens.sixtyFour,
      );
    }
    return NxCircleAssetImage(
      imgAsset: AssetValues.avatar,
      radius: Dimens.sixtyFour,
    );
  }

  Widget _buildUserDetails(ProfileController logic) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${logic.profileData.user!.fname} ${logic.profileData.user!.lname}',
            style: AppStyles.style20Bold,
          ),
          Text(
            "@${logic.profileData.user!.uname}",
            style: TextStyle(
              fontSize: Dimens.sixTeen,
              color: Theme.of(Get.context!).textTheme.subtitle1!.color,
            ),
          ),
          if (logic.profileData.user!.about != null) Dimens.boxHeight8,
          if (logic.profileData.user!.about != null)
            Text(
              logic.profileData.user!.about!,
              style: AppStyles.style14Normal,
            ),
          Dimens.boxHeight16,
        ],
      );

  Widget _buildActionButtons() => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          NxFilledButton(
            label: StringValues.logout,
            onTap: () {
              Get.find<AuthService>().logout();
            },
          ),
        ],
      );
}
