import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_calling_app/apis/services/auth_service.dart';
import 'package:video_calling_app/common/primary_filled_btn.dart';

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
              const Text('home'),
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
