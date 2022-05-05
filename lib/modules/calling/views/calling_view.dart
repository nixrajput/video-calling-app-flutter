import 'package:agora_rtc_engine/rtc_local_view.dart' as rtc_local_view;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_calling_app/common/primary_icon_btn.dart';
import 'package:video_calling_app/constants/colors.dart';
import 'package:video_calling_app/constants/dimens.dart';
import 'package:video_calling_app/modules/calling/controllers/calling_controller.dart';

class CallingView extends StatelessWidget {
  const CallingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CallingController>(
        builder: (logic) {
          if (logic.isConnecting) {
            return const Center(child: CircularProgressIndicator());
          }

          return _renderVideoOnScreen(logic);
        },
      ),
    );
  }

  Widget _renderVideoOnScreen(CallingController logic) {
    return GestureDetector(
      onTap: logic.toggleShowControls,
      child: Stack(
        children: [
          if (logic.participants.isEmpty)
            SizedBox(
              width: Dimens.screenWidth,
              height: Dimens.screenHeight,
              child: const Expanded(
                child: rtc_local_view.SurfaceView(
                  zOrderOnTop: true,
                  zOrderMediaOverlay: true,
                ),
              ),
            ),
          if (logic.showControls)
            Align(
              alignment: Alignment.bottomCenter,
              child: _floatingControlBar(logic),
            ),
        ],
      ),
    );
  }

  AnimatedContainer _floatingControlBar(CallingController logic) =>
      AnimatedContainer(
        color: Colors.transparent,
        width: Dimens.screenWidth,
        padding: Dimens.edgeInsets16_8,
        duration: const Duration(milliseconds: 1000),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              backgroundColor: logic.micToggle
                  ? ColorValues.whiteColor
                  : ColorValues.errorColor,
              radius: Dimens.twentyFour,
              child: NxIconButton(
                icon: logic.micToggle ? Icons.mic : Icons.mic_off,
                iconColor: logic.micToggle
                    ? Theme.of(Get.context!).iconTheme.color
                    : ColorValues.whiteColor,
                onTap: () => logic.toggleMuteAudio(),
              ),
            ),
            CircleAvatar(
              backgroundColor: logic.cameraToggle
                  ? ColorValues.whiteColor
                  : ColorValues.errorColor,
              radius: Dimens.twentyFour,
              child: NxIconButton(
                icon: logic.cameraToggle
                    ? Icons.videocam_outlined
                    : Icons.videocam_off_outlined,
                iconColor: logic.cameraToggle
                    ? Theme.of(Get.context!).iconTheme.color
                    : ColorValues.whiteColor,
                onTap: () => logic.toggleMuteVideo(),
              ),
            ),
            CircleAvatar(
              backgroundColor: ColorValues.errorColor,
              radius: Dimens.twentyFour,
              child: NxIconButton(
                icon: Icons.close,
                iconColor: ColorValues.whiteColor,
                onTap: () => logic.leaveChannel(),
              ),
            ),
          ],
        ),
      );
}
