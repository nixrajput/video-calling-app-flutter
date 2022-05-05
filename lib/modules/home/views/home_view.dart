import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_calling_app/apis/services/auth_service.dart';
import 'package:video_calling_app/common/primary_filled_btn.dart';
import 'package:video_calling_app/constants/dimens.dart';
import 'package:video_calling_app/constants/styles.dart';
import 'package:video_calling_app/routes/route_management.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                Get.find<AuthService>().channelId.toString(),
                style: AppStyles.style20Bold,
              ),
              Dimens.boxHeight16,
              const NxFilledButton(
                label: 'Start Meeting',
                onTap: RouteManagement.goToCallingView,
              ),
              Dimens.boxHeight16,
              NxFilledButton(
                label: 'Join Meeting',
                onTap: () {},
              ),
              Dimens.boxHeight32,
              NxFilledButton(
                label: 'Logout',
                onTap: () {
                  Get.find<AuthService>().logout();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
