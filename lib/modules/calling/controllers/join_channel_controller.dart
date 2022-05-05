import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class JoinChannelController extends GetxController {
  static JoinChannelController get find => Get.find();

  final channelIdTextController = TextEditingController();

  final FocusScopeNode focusNode = FocusScopeNode();
}
