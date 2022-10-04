import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_calling_app/apis/models/entities/user_avatar.dart';
import 'package:video_calling_app/common/circular_asset_image.dart';
import 'package:video_calling_app/common/circular_network_image.dart';
import 'package:video_calling_app/common/primary_icon_btn.dart';
import 'package:video_calling_app/constants/colors.dart';
import 'package:video_calling_app/constants/dimens.dart';
import 'package:video_calling_app/constants/strings.dart';
import 'package:video_calling_app/helpers/utility.dart';
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
    var lastExitTime = DateTime.now();
    return WillPopScope(
      onWillPop: () async {
        if (DateTime.now().difference(lastExitTime) >=
            const Duration(seconds: 2)) {
          AppUtility.showSnackBar(
            'Press the back button again exit',
            '',
            duration: 2,
          );
          lastExitTime = DateTime.now();

          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: GetBuilder<ChannelController>(
            builder: (logic) {
              if (!logic.initialized || logic.isConnecting || !logic.isJoined) {
                return const Center(child: CircularProgressIndicator());
              }

              return _renderVideoOnScreen(logic);
            },
          ),
        ),
      ),
    );
  }

  Widget _renderVideoOnScreen(ChannelController logic) {
    return GestureDetector(
      onTap: logic.toggleShowControls,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (logic.participants.isNotEmpty) _renderRemoteVideo(logic),
          if (logic.participants.length <= 2) _renderLocalVideo(logic),
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
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: logic.rtcEngine,
          canvas: VideoCanvas(uid: logic.participants[0]),
          connection: RtcConnection(channelId: logic.channelId),
          useFlutterTexture: false,
          useAndroidSurfaceView: false,
        ),
      );
    }
    if (logic.participants.length == 2) {
      return Column(
        children: [
          SizedBox(
            width: Dimens.screenWidth,
            height: (Dimens.screenHeight * 0.5) - Dimens.fourteen,
            child: AgoraVideoView(
              controller: VideoViewController.remote(
                rtcEngine: logic.rtcEngine,
                canvas: VideoCanvas(uid: logic.participants[0]),
                connection: RtcConnection(channelId: logic.channelId),
                useFlutterTexture: false,
                useAndroidSurfaceView: false,
              ),
            ),
          ),
          Dimens.boxHeight4,
          SizedBox(
            width: Dimens.screenWidth,
            height: (Dimens.screenHeight * 0.5) - Dimens.fourteen,
            child: AgoraVideoView(
              controller: VideoViewController.remote(
                rtcEngine: logic.rtcEngine,
                canvas: VideoCanvas(uid: logic.participants[1]),
                connection: RtcConnection(channelId: logic.channelId),
                useFlutterTexture: false,
                useAndroidSurfaceView: false,
              ),
            ),
          )
        ],
      );
    }
    if (logic.participants.length == 3) {
      return Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: (Dimens.screenWidth * 0.5) - Dimens.two,
                height: (Dimens.screenHeight * 0.5) - Dimens.fourteen,
                child: AgoraVideoView(
                  controller: VideoViewController.remote(
                    rtcEngine: logic.rtcEngine,
                    canvas: VideoCanvas(uid: logic.participants[0]),
                    connection: RtcConnection(channelId: logic.channelId),
                    useFlutterTexture: false,
                    useAndroidSurfaceView: false,
                  ),
                ),
              ),
              Dimens.boxWidth4,
              SizedBox(
                width: (Dimens.screenWidth * 0.5) - Dimens.two,
                height: (Dimens.screenHeight * 0.5) - Dimens.fourteen,
                child: AgoraVideoView(
                  controller: VideoViewController.remote(
                    rtcEngine: logic.rtcEngine,
                    canvas: VideoCanvas(uid: logic.participants[1]),
                    connection: RtcConnection(channelId: logic.channelId),
                    useFlutterTexture: false,
                    useAndroidSurfaceView: false,
                  ),
                ),
              )
            ],
          ),
          Dimens.boxHeight4,
          SizedBox(
            width: Dimens.screenWidth,
            height: (Dimens.screenHeight * 0.5) - Dimens.fourteen,
            child: _renderLocalVideo(logic),
          ),
        ],
      );
    }
    if (logic.participants.length == 4) {
      return Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: (Dimens.screenWidth * 0.5) - Dimens.two,
                height: (Dimens.screenHeight * 0.5) - Dimens.fourteen,
                child: AgoraVideoView(
                  controller: VideoViewController.remote(
                    rtcEngine: logic.rtcEngine,
                    canvas: VideoCanvas(uid: logic.participants[0]),
                    connection: RtcConnection(channelId: logic.channelId),
                    useFlutterTexture: false,
                    useAndroidSurfaceView: false,
                  ),
                ),
              ),
              Dimens.boxWidth4,
              SizedBox(
                width: (Dimens.screenWidth * 0.5) - Dimens.two,
                height: (Dimens.screenHeight * 0.5) - Dimens.fourteen,
                child: AgoraVideoView(
                  controller: VideoViewController.remote(
                    rtcEngine: logic.rtcEngine,
                    canvas: VideoCanvas(uid: logic.participants[1]),
                    connection: RtcConnection(channelId: logic.channelId),
                    useFlutterTexture: false,
                    useAndroidSurfaceView: false,
                  ),
                ),
              ),
            ],
          ),
          Dimens.boxHeight4,
          Row(
            children: [
              SizedBox(
                width: (Dimens.screenWidth * 0.5) - Dimens.two,
                height: (Dimens.screenHeight * 0.5) - Dimens.fourteen,
                child: AgoraVideoView(
                  controller: VideoViewController.remote(
                    rtcEngine: logic.rtcEngine,
                    canvas: VideoCanvas(uid: logic.participants[2]),
                    connection: RtcConnection(channelId: logic.channelId),
                    useFlutterTexture: false,
                    useAndroidSurfaceView: false,
                  ),
                ),
              ),
              Dimens.boxWidth4,
              SizedBox(
                width: (Dimens.screenWidth * 0.5) - Dimens.two,
                height: (Dimens.screenHeight * 0.5) - Dimens.fourteen,
                child: _renderLocalVideo(logic),
              ),
            ],
          ),
        ],
      );
    }
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: (Dimens.screenWidth * 0.5) - Dimens.two,
              height: (Dimens.screenHeight * 0.5) - Dimens.eighty,
              child: AgoraVideoView(
                controller: VideoViewController.remote(
                  rtcEngine: logic.rtcEngine,
                  canvas: VideoCanvas(uid: logic.participants[0]),
                  connection: RtcConnection(channelId: logic.channelId),
                  useFlutterTexture: false,
                  useAndroidSurfaceView: false,
                ),
              ),
            ),
            Dimens.boxWidth4,
            SizedBox(
              width: (Dimens.screenWidth * 0.5) - Dimens.two,
              height: (Dimens.screenHeight * 0.5) - Dimens.eighty,
              child: AgoraVideoView(
                controller: VideoViewController.remote(
                  rtcEngine: logic.rtcEngine,
                  canvas: VideoCanvas(uid: logic.participants[1]),
                  connection: RtcConnection(channelId: logic.channelId),
                  useFlutterTexture: false,
                  useAndroidSurfaceView: false,
                ),
              ),
            ),
          ],
        ),
        Dimens.boxHeight4,
        Row(
          children: [
            SizedBox(
              width: (Dimens.screenWidth * 0.5) - Dimens.two,
              height: (Dimens.screenHeight * 0.5) - Dimens.eighty,
              child: AgoraVideoView(
                controller: VideoViewController.remote(
                  rtcEngine: logic.rtcEngine,
                  canvas: VideoCanvas(uid: logic.participants[2]),
                  connection: RtcConnection(channelId: logic.channelId),
                  useFlutterTexture: false,
                  useAndroidSurfaceView: false,
                ),
              ),
            ),
            Dimens.boxWidth4,
            SizedBox(
              width: (Dimens.screenWidth * 0.5) - Dimens.two,
              height: (Dimens.screenHeight * 0.5) - Dimens.eighty,
              child: _renderLocalVideo(logic),
            ),
          ],
        ),
        Dimens.boxHeight4,
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            height: (Dimens.hundred * 1.4) - Dimens.twelve,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: logic.participants
                  .skip(4)
                  .map((uid) => Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: SizedBox(
                          width: Dimens.screenWidth * 0.3,
                          child: AgoraVideoView(
                            controller: VideoViewController.remote(
                              rtcEngine: logic.rtcEngine,
                              canvas: VideoCanvas(uid: uid),
                              connection:
                                  RtcConnection(channelId: logic.channelId),
                              useFlutterTexture: false,
                              useAndroidSurfaceView: false,
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildProfileImage(UserAvatar? avatar, {double? size}) {
    if (avatar != null && avatar.url != null) {
      return NxCircleNetworkImage(
        imageUrl: avatar.url!,
        radius: size ?? Dimens.thirtyTwo,
      );
    }
    return NxCircleAssetImage(
      imgAsset: AssetValues.avatar,
      radius: size ?? Dimens.thirtyTwo,
    );
  }

  Widget _renderLocalVideo(ChannelController logic) {
    if (logic.participants.isEmpty) {
      return SizedBox(
        width: Dimens.screenWidth,
        height: Dimens.screenHeight,
        child: logic.videoMuted
            ? Container(
                color: Colors.transparent,
                width: Dimens.screenWidth,
                height: Dimens.screenHeight,
                child: Center(
                  child: _buildProfileImage(
                    logic.profile.profileDetails!.user!.avatar,
                    size: Dimens.sixtyFour,
                  ),
                ),
              )
            : AgoraVideoView(
                controller: VideoViewController(
                  rtcEngine: logic.rtcEngine,
                  canvas: const VideoCanvas(uid: 0),
                  useFlutterTexture: false,
                  useAndroidSurfaceView: false,
                ),
              ),
      );
    }
    if (logic.participants.length > 2) {
      return logic.videoMuted
          ? Center(
              child: _buildProfileImage(
                logic.profile.profileDetails!.user!.avatar,
                size: Dimens.twenty,
              ),
            )
          : AgoraVideoView(
              controller: VideoViewController(
                rtcEngine: logic.rtcEngine,
                canvas: const VideoCanvas(uid: 0),
                useFlutterTexture: false,
                useAndroidSurfaceView: false,
              ),
            );
    }
    return Positioned(
      top: Dimens.eight,
      right: Dimens.eight,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Dimens.eight),
        child: Container(
          color: Theme.of(Get.context!).dialogBackgroundColor,
          width: Dimens.hundred * 1.2,
          height: Dimens.hundred * 1.6,
          child: logic.videoMuted
              ? Center(
                  child: _buildProfileImage(
                    logic.profile.profileDetails!.user!.avatar,
                    size: Dimens.twenty,
                  ),
                )
              : AgoraVideoView(
                  controller: VideoViewController(
                    rtcEngine: logic.rtcEngine,
                    canvas: const VideoCanvas(uid: 0),
                    useFlutterTexture: false,
                    useAndroidSurfaceView: false,
                  ),
                ),
        ),
      ),
    );
  }

  Widget _floatingControlBar(ChannelController logic) => GestureDetector(
        onTap: () {},
        child: AnimatedContainer(
          color: Colors.transparent,
          width: Dimens.screenWidth,
          padding: Dimens.edgeInsets16,
          duration: const Duration(milliseconds: 500),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                backgroundColor: !logic.audioMuted
                    ? ColorValues.whiteColor
                    : ColorValues.errorColor,
                radius: Dimens.thirtyTwo,
                child: NxIconButton(
                  icon: !logic.audioMuted ? Icons.mic : Icons.mic_off,
                  iconColor: !logic.audioMuted
                      ? Theme.of(Get.context!).iconTheme.color
                      : ColorValues.whiteColor,
                  onTap: () => logic.toggleMuteAudio(),
                ),
              ),
              CircleAvatar(
                backgroundColor: !logic.videoMuted
                    ? ColorValues.whiteColor
                    : ColorValues.errorColor,
                radius: Dimens.thirtyTwo,
                child: NxIconButton(
                  icon: !logic.videoMuted
                      ? Icons.videocam_outlined
                      : Icons.videocam_off_outlined,
                  iconColor: !logic.videoMuted
                      ? Theme.of(Get.context!).iconTheme.color
                      : ColorValues.whiteColor,
                  onTap: () => logic.toggleMuteVideo(),
                  // onTap: () {
                  //   logic.participants.add(AppUtility.randomIntNumeric(8));
                  //   logic.update();
                  // },
                ),
              ),
              CircleAvatar(
                backgroundColor: ColorValues.errorColor,
                radius: Dimens.thirtyTwo,
                child: NxIconButton(
                  icon: Icons.close,
                  iconColor: ColorValues.whiteColor,
                  onTap: () => logic.leaveChannel(),
                ),
              ),
            ],
          ),
        ),
      );

  @override
  bool get wantKeepAlive => true;
}
