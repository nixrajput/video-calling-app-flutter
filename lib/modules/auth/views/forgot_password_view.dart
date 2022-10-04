import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_calling_app/common/asset_image.dart';
import 'package:video_calling_app/common/primary_filled_btn.dart';
import 'package:video_calling_app/common/primary_text_btn.dart';
import 'package:video_calling_app/constants/colors.dart';
import 'package:video_calling_app/constants/dimens.dart';
import 'package:video_calling_app/constants/strings.dart';
import 'package:video_calling_app/constants/styles.dart';
import 'package:video_calling_app/modules/auth/controllers/password_controller.dart';
import 'package:video_calling_app/routes/route_management.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: SizedBox(
            width: Dimens.screenWidth,
            height: Dimens.screenHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Dimens.boxHeight16,
                _buildImageHeader(),
                Dimens.boxHeight16,
                _buildForgotPasswordFields(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageHeader() => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          NxAssetImage(
            imgAsset: AssetValues.appIcon,
            maxHeight: Dimens.eighty,
          ),
          Text(
            StringValues.appName,
            textAlign: TextAlign.center,
            style: AppStyles.style24Bold.copyWith(
              color: ColorValues.primaryColor,
            ),
          ),
        ],
      );

  Widget _buildForgotPasswordFields() => GetBuilder<PasswordController>(
        builder: (logic) => Expanded(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: Dimens.edgeInsets0_16,
                  child: FocusScope(
                    node: logic.focusNode,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          StringValues.forgotPassword,
                          style: AppStyles.style32Bold,
                        ),
                        Dimens.boxHeight8,
                        Text(
                          'We will send an OTP on this email address.',
                          style: AppStyles.style14Normal.copyWith(
                            color: ColorValues.darkGrayColor,
                          ),
                        ),
                        Dimens.boxHeight32,
                        TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: StringValues.email,
                            hintStyle: TextStyle(
                              color: ColorValues.grayColor,
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          maxLines: 1,
                          style: AppStyles.style14Normal.copyWith(
                            color: Theme.of(Get.context!)
                                .textTheme
                                .bodyText1!
                                .color,
                          ),
                          controller: logic.emailTextController,
                          onEditingComplete: logic.focusNode.unfocus,
                        ),
                        Dimens.boxHeight32,
                        const NxTextButton(
                          label: StringValues.loginToAccount,
                          onTap: RouteManagement.goToLoginView,
                        ),
                        Dimens.boxHeight16,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              StringValues.alreadyHaveOtp,
                              style: AppStyles.style16Normal,
                            ),
                            Dimens.boxWidth4,
                            const NxTextButton(
                              label: StringValues.resetPassword,
                              onTap: RouteManagement.goToResetPasswordView,
                            ),
                          ],
                        ),
                        Dimens.boxHeight16,
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: NxFilledButton(
                  onTap: () => logic.sendResetPasswordOTP(),
                  label: StringValues.getOtp.toUpperCase(),
                  fontSize: Dimens.sixTeen,
                  borderRadius: 0.0,
                ),
              ),
            ],
          ),
        ),
      );
}
