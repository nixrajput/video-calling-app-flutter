import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_calling_app/apis/services/auth_service.dart';
import 'package:video_calling_app/common/asset_image.dart';
import 'package:video_calling_app/common/circular_asset_image.dart';
import 'package:video_calling_app/common/circular_network_image.dart';
import 'package:video_calling_app/common/custom_app_bar.dart';
import 'package:video_calling_app/common/primary_filled_btn.dart';
import 'package:video_calling_app/common/primary_outlined_btn.dart';
import 'package:video_calling_app/constants/dimens.dart';
import 'package:video_calling_app/constants/strings.dart';
import 'package:video_calling_app/constants/styles.dart';
import 'package:video_calling_app/helpers/utils.dart';
import 'package:video_calling_app/modules/profile/controllers/profile_controller.dart';
import 'package:video_calling_app/routes/route_management.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

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
                leading: Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      NxAssetImage(
                        imgAsset: AssetValues.appName,
                        width: Dimens.hundred * 1.2,
                        fit: BoxFit.cover,
                      ),
                      GetBuilder<ProfileController>(
                        builder: (logic) => InkWell(
                          onTap: RouteManagement.goToProfileView,
                          child: _buildProfileImage(logic),
                        ),
                      ),
                    ],
                  ),
                ),
                showBackBtn: false,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Expanded(child: SizedBox()),
                      Text(
                        "Your meeting ID is:",
                        style: AppStyles.style16Normal,
                        textAlign: TextAlign.center,
                      ),
                      Dimens.boxHeight8,
                      Text(
                        AppUtils.formatMeetingId(
                            Get.find<AuthService>().channelId.toString()),
                        style: AppStyles.style24Bold,
                        textAlign: TextAlign.center,
                      ),
                      const Expanded(child: SizedBox()),
                      Dimens.boxHeight16,
                      const NxFilledButton(
                        label: StringValues.start,
                        onTap: RouteManagement.goToStartView,
                      ),
                      Dimens.boxHeight16,
                      const NxOutlinedButton(
                        label: StringValues.join,
                        onTap: RouteManagement.goToJoinView,
                      ),
                      Dimens.boxHeight16,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileImage(ProfileController logic) {
    if (logic.profileData.user != null &&
        logic.profileData.user!.avatar != null) {
      return NxCircleNetworkImage(
        imageUrl: logic.profileData.user!.avatar!.url!,
        radius: Dimens.twentyFour,
      );
    }
    return NxCircleAssetImage(
      imgAsset: AssetValues.avatar,
      radius: Dimens.twentyFour,
    );
  }
}
