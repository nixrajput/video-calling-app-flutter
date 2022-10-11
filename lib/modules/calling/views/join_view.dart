import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_calling_app/common/custom_app_bar.dart';
import 'package:video_calling_app/common/primary_filled_btn.dart';
import 'package:video_calling_app/constants/colors.dart';
import 'package:video_calling_app/constants/dimens.dart';
import 'package:video_calling_app/constants/strings.dart';
import 'package:video_calling_app/constants/styles.dart';
import 'package:video_calling_app/modules/calling/controllers/join_channel_controller.dart';
import 'package:video_calling_app/routes/route_management.dart';

class JoinView extends StatelessWidget {
  const JoinView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: SizedBox(
            width: Dimens.screenWidth,
            height: Dimens.screenHeight,
            child: GetBuilder<JoinChannelController>(
              builder: (logic) {
                return Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        NxAppBar(
                          title: StringValues.join,
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
                                    TextFormField(
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: 'Channel ID',
                                        hintStyle: TextStyle(
                                          color: ColorValues.grayColor,
                                        ),
                                      ),
                                      keyboardType: TextInputType.emailAddress,
                                      maxLines: 1,
                                      style: AppStyles.style16Normal.copyWith(
                                        color: Theme.of(Get.context!)
                                            .textTheme
                                            .bodyText1!
                                            .color,
                                      ),
                                      controller: logic.channelIdTextController,
                                      onEditingComplete: FocusManager
                                          .instance.primaryFocus!.unfocus,
                                    ),
                                    Dimens.boxHeight8,
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
                        )
                      ],
                    ),
                    Positioned(
                      bottom: Dimens.zero,
                      left: Dimens.zero,
                      right: Dimens.zero,
                      child: NxFilledButton(
                        label: StringValues.join.toUpperCase(),
                        borderRadius: 0.0,
                        onTap: () {
                          FocusManager.instance.primaryFocus!.unfocus();
                          if (logic.channelIdTextController.text.isEmpty) {
                            return;
                          }
                          RouteManagement.goToCallingView(
                            channelId:
                                logic.channelIdTextController.text.trim(),
                            enableAudio: logic.micToggle,
                            enableVideo: logic.cameraToggle,
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
