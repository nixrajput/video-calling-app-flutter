import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_calling_app/common/asset_image.dart';
import 'package:video_calling_app/common/primary_filled_btn.dart';
import 'package:video_calling_app/common/primary_text_btn.dart';
import 'package:video_calling_app/constants/colors.dart';
import 'package:video_calling_app/constants/dimens.dart';
import 'package:video_calling_app/constants/strings.dart';
import 'package:video_calling_app/constants/styles.dart';
import 'package:video_calling_app/modules/auth/controllers/login_controller.dart';
import 'package:video_calling_app/routes/route_management.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

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
                _buildLoginFields(),
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

  Widget _buildLoginFields() => GetBuilder<LoginController>(
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
                          StringValues.login,
                          style: AppStyles.style32Bold,
                        ),
                        Dimens.boxHeight32,
                        TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: StringValues.emailUname,
                            hintStyle: TextStyle(
                              color: ColorValues.grayColor,
                            ),
                          ),
                          keyboardType: TextInputType.text,
                          maxLines: 1,
                          style: AppStyles.style14Normal.copyWith(
                            color: Theme.of(Get.context!)
                                .textTheme
                                .bodyText1!
                                .color,
                          ),
                          controller: logic.emailUnameTextController,
                          onEditingComplete: logic.focusNode.nextFocus,
                        ),
                        Dimens.boxHeight16,
                        TextFormField(
                          obscureText: logic.showPassword,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            suffixIcon: InkWell(
                              onTap: logic.toggleViewPassword,
                              child: Icon(
                                logic.showPassword
                                    ? CupertinoIcons.eye
                                    : CupertinoIcons.eye_slash,
                              ),
                            ),
                            hintText: StringValues.password,
                            hintStyle: const TextStyle(
                              color: ColorValues.grayColor,
                            ),
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          maxLines: 1,
                          style: AppStyles.style14Normal.copyWith(
                            color: Theme.of(Get.context!)
                                .textTheme
                                .bodyText1!
                                .color,
                          ),
                          controller: logic.passwordTextController,
                          onEditingComplete: logic.focusNode.unfocus,
                        ),
                        Dimens.boxHeight32,
                        const NxTextButton(
                          label: StringValues.forgotPassword,
                          onTap: RouteManagement.goToForgotPasswordView,
                        ),
                        Dimens.boxHeight16,
                        const NxTextButton(
                          label: StringValues.verifyAccount,
                          onTap: RouteManagement.goToSendVerifyAccountOtpView,
                        ),
                        Dimens.boxHeight16,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              StringValues.doNotHaveAccount,
                              style: AppStyles.style16Normal,
                            ),
                            Dimens.boxWidth4,
                            const NxTextButton(
                              label: StringValues.register,
                              onTap: RouteManagement.goToRegisterView,
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
                  onTap: () => logic.login(),
                  label: StringValues.login.toUpperCase(),
                  fontSize: Dimens.sixTeen,
                  borderRadius: 0.0,
                ),
              ),
            ],
          ),
        ),
      );
}
