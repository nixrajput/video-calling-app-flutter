import 'package:agora_rtc_engine/rtc_local_view.dart' as rtc_local_view;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as rtc_remote_view;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_calling_app/common/primary_icon_btn.dart';
import 'package:video_calling_app/constants/colors.dart';
import 'package:video_calling_app/constants/dimens.dart';
import 'package:video_calling_app/helpers/utils.dart';
import 'package:video_calling_app/modules/calling/controllers/channel_controller.dart';

class CallingView extends StatefulWidget {
  const CallingView({Key? key}) : super(key: key);

  @override
  State<CallingView> createState() => _CallingViewState();
}

class _CallingViewState extends State<CallingView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<ChannelController>(
          builder: (logic) {
            if (logic.isConnecting) {
              return const Center(child: CircularProgressIndicator());
            }

            return _renderVideoOnScreen(logic);
          },
        ),
      ),
    );
  }

  Widget _renderVideoOnScreen(ChannelController logic) {
    return GestureDetector(
      onTap: logic.toggleShowControls,
      child: Stack(
        children: [
          if (logic.participants.isNotEmpty) _renderRemoteVideo(logic),
          if (logic.participants.length < 3) _renderLocalVideo(logic),
          if (logic.showControls)
            Align(
              alignment: Alignment.bottomCenter,
              child: _floatingControlBar(logic),
            ),
        ],
      ),
    );
  }

  Widget _renderRemoteVideo(ChannelController logic) {
    if (logic.participants.length == 1) {
      return Expanded(
        child: rtc_remote_view.SurfaceView(
          uid: logic.participants.first,
          channelId: logic.channelId,
          zOrderOnTop: true,
          zOrderMediaOverlay: true,
        ),
      );
    }
    if (logic.participants.length == 2) {
      return Column(
        children: [
          Expanded(
            child: rtc_remote_view.SurfaceView(
              uid: logic.participants[0],
              channelId: logic.channelId,
              zOrderOnTop: true,
              zOrderMediaOverlay: true,
            ),
          ),
          Dimens.boxHeight4,
          Expanded(
            child: rtc_remote_view.SurfaceView(
              uid: logic.participants[1],
              channelId: logic.channelId,
              zOrderOnTop: true,
              zOrderMediaOverlay: true,
            ),
          )
        ],
      );
    }
    if (logic.participants.length == 3) {
      return Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: rtc_remote_view.SurfaceView(
                    uid: logic.participants[0],
                    channelId: logic.channelId,
                    zOrderOnTop: true,
                    zOrderMediaOverlay: true,
                  ),
                ),
                Dimens.boxWidth4,
                Expanded(
                  child: rtc_remote_view.SurfaceView(
                    uid: logic.participants[1],
                    channelId: logic.channelId,
                    zOrderOnTop: true,
                    zOrderMediaOverlay: true,
                  ),
                )
              ],
            ),
          ),
          Dimens.boxHeight4,
          _renderLocalVideo(logic),
        ],
      );
    }
    if (logic.participants.length == 4) {
      return Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: rtc_remote_view.SurfaceView(
                    uid: logic.participants[0],
                    channelId: logic.channelId,
                    zOrderOnTop: true,
                    zOrderMediaOverlay: true,
                  ),
                ),
                Dimens.boxWidth4,
                Expanded(
                  child: rtc_remote_view.SurfaceView(
                    uid: logic.participants[1],
                    channelId: logic.channelId,
                    zOrderOnTop: true,
                    zOrderMediaOverlay: true,
                  ),
                ),
              ],
            ),
          ),
          Dimens.boxHeight4,
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: rtc_remote_view.SurfaceView(
                    uid: logic.participants[2],
                    channelId: logic.channelId,
                    zOrderOnTop: true,
                    zOrderMediaOverlay: true,
                  ),
                ),
                Dimens.boxWidth4,
                _renderLocalVideo(logic),
              ],
            ),
          ),
        ],
      );
    }
    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: rtc_remote_view.SurfaceView(
                  uid: logic.participants[0],
                  channelId: logic.channelId,
                  zOrderOnTop: true,
                  zOrderMediaOverlay: true,
                ),
              ),
              Dimens.boxWidth4,
              Expanded(
                child: rtc_remote_view.SurfaceView(
                  uid: logic.participants[1],
                  channelId: logic.channelId,
                  zOrderOnTop: true,
                  zOrderMediaOverlay: true,
                ),
              ),
            ],
          ),
        ),
        Dimens.boxHeight4,
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: rtc_remote_view.SurfaceView(
                  uid: logic.participants[2],
                  channelId: logic.channelId,
                  zOrderOnTop: true,
                  zOrderMediaOverlay: true,
                ),
              ),
              Dimens.boxWidth4,
              _renderLocalVideo(logic),
            ],
          ),
        ),
        Dimens.boxHeight4,
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            height: Dimens.hundred * 1.4,
            child: Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: logic.participants
                    .skip(3)
                    .map((uid) => Padding(
                          padding: const EdgeInsets.only(right: 4.0),
                          child: SizedBox(
                            width: Dimens.screenWidth * 0.3,
                            child: rtc_remote_view.SurfaceView(
                              uid: uid,
                              channelId: logic.channelId,
                              zOrderOnTop: true,
                              zOrderMediaOverlay: true,
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _renderLocalVideo(ChannelController logic) {
    if (logic.participants.isEmpty) {
      return SizedBox(
        width: Dimens.screenWidth,
        height: Dimens.screenHeight,
        child: const rtc_local_view.SurfaceView(
          zOrderOnTop: true,
          zOrderMediaOverlay: true,
        ),
      );
    }
    if (logic.participants.isNotEmpty && logic.participants.length > 2) {
      return const Expanded(
        child: rtc_local_view.SurfaceView(
          zOrderOnTop: true,
          zOrderMediaOverlay: true,
        ),
      );
    }
    return Positioned(
      top: 8.0,
      right: 8.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Dimens.eight),
        child: SizedBox(
          width: Dimens.hundred * 1.2,
          height: Dimens.hundred * 1.6,
          child: const rtc_local_view.SurfaceView(
            zOrderOnTop: true,
            zOrderMediaOverlay: true,
          ),
        ),
      ),
    );
  }

  AnimatedContainer _floatingControlBar(ChannelController logic) =>
      AnimatedContainer(
        color: Colors.transparent,
        width: Dimens.screenWidth,
        padding: Dimens.edgeInsets16_8,
        duration: const Duration(milliseconds: 500),
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
                //onTap: () => logic.toggleMuteVideo(),
                onTap: () {
                  logic.participants.add(AppUtils.randomIntNumeric(8));
                  logic.update();
                },
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

  @override
  bool get wantKeepAlive => true;
}
