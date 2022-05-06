import 'package:flutter/material.dart';
import 'package:video_calling_app/common/custom_app_bar.dart';
import 'package:video_calling_app/common/primary_filled_btn.dart';
import 'package:video_calling_app/constants/dimens.dart';
import 'package:video_calling_app/constants/strings.dart';
import 'package:video_calling_app/constants/styles.dart';
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const NxAppBar(
                title: StringValues.start,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Expanded(child: SizedBox()),
                    Text(
                      "Options",
                      style: AppStyles.style16Bold,
                    ),
                    const Expanded(child: SizedBox()),
                    const NxFilledButton(
                      label: StringValues.start,
                      borderRadius: 0.0,
                      onTap: RouteManagement.goToCallingView,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
