import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_calling_app/common/primary_filled_btn.dart';
import 'package:video_calling_app/constants/colors.dart';
import 'package:video_calling_app/constants/dimens.dart';
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
          child: Center(
            child: SizedBox(
              width: Dimens.screenWidth,
              height: Dimens.screenHeight,
              child: GetBuilder<JoinChannelController>(
                builder: (con) => Stack(
                  children: [
                    Padding(
                      padding: Dimens.edgeInsets8,
                      child: Center(
                        child: TextFormField(
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
                          controller: con.channelIdTextController,
                          onEditingComplete: con.focusNode.unfocus,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: NxFilledButton(
                        label: 'Join',
                        onTap: () {
                          FocusManager.instance.primaryFocus!.unfocus();
                          if (con.channelIdTextController.text.isEmpty) return;
                          RouteManagement.goToCallingView(
                              channelId:
                                  con.channelIdTextController.text.trim());
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
