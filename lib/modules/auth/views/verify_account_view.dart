import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:video_calling_app/common/asset_image.dart';
import 'package:video_calling_app/common/primary_filled_btn.dart';
import 'package:video_calling_app/common/primary_text_btn.dart';
import 'package:video_calling_app/constants/colors.dart';
import 'package:video_calling_app/constants/dimens.dart';
import 'package:video_calling_app/constants/strings.dart';
import 'package:video_calling_app/constants/styles.dart';
import 'package:video_calling_app/modules/auth/controllers/account_verification_controller.dart';
import 'package:video_calling_app/routes/route_management.dart';

class VerifyAccountView extends StatelessWidget {
  const VerifyAccountView({Key? key}) : super(key: key);

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
                _buildBody(),
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

  Widget _buildBody() => GetBuilder<AccountVerificationController>(
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
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          StringValues.verifyAccount,
                          style: AppStyles.style32Bold.copyWith(
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Dimens.boxHeight8,
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text:
                                  'An OTP has been sent to your email address',
                              style: AppStyles.style14Normal.copyWith(
                                color: ColorValues.darkGrayColor,
                              ),
                            ),
                            TextSpan(
                              text: ' ${logic.emailTextController.text}, ',
                              style: AppStyles.style14Bold.copyWith(
                                color: ColorValues.darkGrayColor,
                              ),
                            ),
                            TextSpan(
                              text: 'please enter OTP to proceed',
                              style: AppStyles.style14Normal.copyWith(
                                color: ColorValues.darkGrayColor,
                              ),
                            ),
                          ]),
                        ),
                        Dimens.boxHeight32,
                        TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintStyle: TextStyle(
                              color: ColorValues.grayColor,
                            ),
                            hintText: StringValues.otp,
                          ),
                          keyboardType: TextInputType.number,
                          maxLines: 1,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(6),
                          ],
                          style: AppStyles.style14Normal.copyWith(
                            color: Theme.of(Get.context!)
                                .textTheme
                                .bodyText1!
                                .color,
                          ),
                          controller: logic.otpTextController,
                          onEditingComplete: logic.focusNode.unfocus,
                        ),
                        Dimens.boxHeight32,
                        NxTextButton(
                          label: StringValues.loginToAccount,
                          onTap: () {
                            RouteManagement.goToBack();
                            RouteManagement.goToLoginView();
                          },
                        ),
                        Dimens.boxHeight16,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              StringValues.doNotHaveOtp,
                              style: AppStyles.style16Normal,
                            ),
                            Dimens.boxWidth4,
                            NxTextButton(
                              label: StringValues.getOtp,
                              onTap: () {
                                RouteManagement.goToBack();
                                RouteManagement.goToSendVerifyAccountOtpView();
                              },
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
                  onTap: () => logic.verifyAccount(),
                  label: StringValues.verifyAccount.toUpperCase(),
                  fontSize: Dimens.sixTeen,
                  borderRadius: 0.0,
                ),
              ),
            ],
          ),
        ),
      );
}
