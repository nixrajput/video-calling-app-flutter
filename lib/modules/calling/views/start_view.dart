import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_calling_app/apis/services/auth_service.dart';
import 'package:video_calling_app/common/custom_app_bar.dart';
import 'package:video_calling_app/common/primary_filled_btn.dart';
import 'package:video_calling_app/constants/colors.dart';
import 'package:video_calling_app/constants/dimens.dart';
import 'package:video_calling_app/constants/strings.dart';
import 'package:video_calling_app/constants/styles.dart';
import 'package:video_calling_app/helpers/utility.dart';
import 'package:video_calling_app/modules/calling/controllers/start_channel_controller.dart';
import 'package:video_calling_app/routes/route_management.dart';

class StartView extends StatelessWidget {
  const StartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: Dimens.screenWidth,
          height: Dimens.screenHeight,
          child: GetBuilder<StartChannelController>(
            builder: (logic) {
              return Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      NxAppBar(
                        title: StringValues.start,
                        padding: Dimens.edgeInsets8_16,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Expanded(child: SizedBox()),
                            Padding(
                              padding: Dimens.edgeInsets8_16,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Meeting ID",
                                        style: AppStyles.style18Normal,
                                      ),
                                      Text(
                                        AppUtility.formatMeetingId(
                                            Get.find<AuthService>()
                                                .channelId
                                                .toString()),
                                        style: AppStyles.style20Bold,
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Camera",
                                        style: AppStyles.style18Normal,
                                      ),
                                      Switch(
                                        onChanged: (value) {
                                          logic.enableVideo(value);
                                        },
                                        value: !logic.cameraToggle,
                                        activeColor: ColorValues.primaryColor,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Audio",
                                        style: AppStyles.style18Normal,
                                      ),
                                      Switch(
                                        onChanged: (value) {
                                          logic.enableAudio(value);
                                        },
                                        value: !logic.micToggle,
                                        activeColor: ColorValues.primaryColor,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const Expanded(child: SizedBox()),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: Dimens.zero,
                    left: Dimens.zero,
                    right: Dimens.zero,
                    child: NxFilledButton(
                      label: StringValues.start.toUpperCase(),
                      borderRadius: 0.0,
                      onTap: () => RouteManagement.goToCallingView(
                        enableAudio: logic.micToggle,
                        enableVideo: logic.cameraToggle,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
