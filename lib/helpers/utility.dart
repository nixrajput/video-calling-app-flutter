import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_calling_app/common/asset_image.dart';
import 'package:video_calling_app/constants/colors.dart';
import 'package:video_calling_app/constants/dimens.dart';
import 'package:video_calling_app/constants/strings.dart';
import 'package:video_calling_app/constants/styles.dart';

const asciiStart = 33;
const asciiEnd = 126;
const numericStart = 48;
const numericEnd = 57;

abstract class AppUtility {
  static final storage = GetStorage();

  static void showLoadingDialog() {
    closeDialog();
    Get.dialog<void>(
      WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: CupertinoTheme(
              data: CupertinoTheme.of(Get.context!).copyWith(
                brightness: Brightness.dark,
                primaryColor: Colors.white,
              ),
              child: const CircularProgressIndicator(),
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  static buildAppLogo({double? fontSize, bool? isCentered = false}) => Text(
        StringValues.appName.toUpperCase(),
        style: AppStyles.style24Bold.copyWith(
          fontSize: fontSize,
          letterSpacing: Dimens.four,
        ),
        textAlign: isCentered == true ? TextAlign.center : TextAlign.start,
      );

  static void showError(String message) {
    closeSnackBar();
    closeDialog();
    closeBottomSheet();
    if (message.isEmpty) return;
    Get.rawSnackbar(
      messageText: Text(
        message,
      ),
      mainButton: TextButton(
        onPressed: () {
          if (Get.isSnackbarOpen) {
            Get.back<void>();
          }
        },
        child: const Text(
          StringValues.okay,
        ),
      ),
      backgroundColor: const Color(0xFF503E9D),
      margin: Dimens.edgeInsets16,
      borderRadius: Dimens.fifteen,
      snackStyle: SnackStyle.FLOATING,
    );
  }

  static void showSimpleDialog(Widget child,
      {bool barrierDismissible = false}) {
    closeSnackBar();
    closeDialog();
    Get.dialog(
      MediaQuery.removeViewInsets(
        context: Get.context!,
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: Dimens.screenHeight,
            maxWidth: Dimens.hundred * 6,
          ),
          child: Padding(
            padding: Dimens.edgeInsets16,
            child: Align(
              alignment: Alignment.center,
              child: Material(
                type: MaterialType.card,
                color: Theme.of(Get.context!).dialogBackgroundColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(Dimens.eight),
                ),
                child: child,
              ),
            ),
          ),
        ),
      ),
      barrierDismissible: barrierDismissible,
      barrierColor: ColorValues.blackColor.withOpacity(0.75),
    );
  }

  static void showNoInternetDialog() {
    closeDialog();
    Get.dialog<void>(
      WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: Colors.black26,
          body: Padding(
            padding: Dimens.edgeInsets16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                NxAssetImage(
                  imgAsset: AssetValues.error,
                  width: Dimens.hundred * 2,
                  height: Dimens.hundred * 2,
                ),
                Dimens.boxHeight8,
                Text(
                  'No Internet!',
                  textAlign: TextAlign.center,
                  style: AppStyles.style24Bold.copyWith(
                    color: ColorValues.whiteColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  static void showBottomSheet(List<Widget> children, {double? borderRadius}) {
    closeBottomSheet();
    Get.bottomSheet(
      Padding(
        padding: Dimens.edgeInsets8_0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: children,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRadius ?? Dimens.zero),
          topRight: Radius.circular(borderRadius ?? Dimens.zero),
        ),
      ),
      barrierColor:
          Theme.of(Get.context!).textTheme.bodyText1!.color!.withAlpha(90),
      backgroundColor: Theme.of(Get.context!).bottomSheetTheme.backgroundColor,
    );
  }

  static void showOverlay(Function func) {
    Get.showOverlay(
      loadingWidget: const CupertinoActivityIndicator(),
      opacityColor: Theme.of(Get.context!).bottomSheetTheme.backgroundColor!,
      opacity: 0.5,
      asyncFunction: () async {
        await func();
      },
    );
  }

  static void showSnackBar(String message, String type, {int? duration}) {
    closeSnackBar();
    Get.showSnackbar(
      GetSnackBar(
        margin: EdgeInsets.only(
          top: Dimens.sixTeen,
          left: Dimens.sixTeen,
          right: Dimens.sixTeen,
        ),
        borderRadius: Dimens.four,
        padding: Dimens.edgeInsets16,
        snackStyle: SnackStyle.FLOATING,
        snackPosition: SnackPosition.TOP,
        messageText: Text(
          message,
          style: TextStyle(
            color: Theme.of(Get.context!).scaffoldBackgroundColor,
          ),
        ),
        icon: Icon(
          type == StringValues.error
              ? CupertinoIcons.clear_circled_solid
              : type == StringValues.success
                  ? CupertinoIcons.check_mark_circled_solid
                  : CupertinoIcons.info_circle_fill,
          color: type == StringValues.error
              ? ColorValues.errorColor
              : type == StringValues.success
                  ? ColorValues.successColor
                  : type == StringValues.warning
                      ? ColorValues.warningColor
                      : Theme.of(Get.context!).iconTheme.color,
        ),
        shouldIconPulse: false,
        backgroundColor: Theme.of(Get.context!).snackBarTheme.backgroundColor!,
        duration: Duration(seconds: duration ?? 2),
      ),
    );
  }

  /// Close any open snack bar.
  static void closeSnackBar() {
    if (Get.isSnackbarOpen) Get.back<void>();
  }

  /// Close any open dialog.
  static void closeDialog() {
    if (Get.isDialogOpen ?? false) Get.back<void>();
  }

  /// Close any open bottom sheet.
  static void closeBottomSheet() {
    if (Get.isBottomSheetOpen ?? false) Get.back<void>();
  }

  static void closeFocus() {
    if (FocusManager.instance.primaryFocus!.hasFocus) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  static Future<void> saveLoginDataToLocalStorage(token, int expiresAt) async {
    if (token!.isNotEmpty && expiresAt > 0) {
      final data = jsonEncode({
        StringValues.token: token,
        StringValues.expiresAt: expiresAt,
      });

      await storage.write(StringValues.loginData, data);
      printLog(StringValues.authDetailsSaved);
    } else {
      printLog(StringValues.authDetailsNotSaved);
    }
  }

  static Future<void> saveChannelDataToLocalStorage() async {
    var channelId = randomNumeric(10);
    var agoraUid = randomIntNumeric(8).toUnsigned(32);

    final data = jsonEncode({
      StringValues.channelId: channelId,
      StringValues.agoraUid: agoraUid,
    });

    await storage.write(StringValues.channelData, data);
    printLog(StringValues.channelDataSaved);
  }

  static Future<dynamic> readChannelDataFromLocalStorage() async {
    if (storage.hasData(StringValues.channelData)) {
      final data = await storage.read(StringValues.channelData);
      var decodedData = jsonDecode(data);
      printLog(StringValues.channelDataFound);
      return decodedData;
    }
    printLog(StringValues.channelDataNotFound);
    return null;
  }

  static Future<dynamic> readLoginDataFromLocalStorage() async {
    if (storage.hasData(StringValues.loginData)) {
      final data = await storage.read(StringValues.loginData);
      var decodedData = jsonDecode(data) as Map<String, dynamic>;
      printLog(StringValues.authDetailsFound);
      return decodedData;
    }
    printLog(StringValues.authDetailsNotFound);
    return null;
  }

  static Future<void> saveProfileDataToLocalStorage(response) async {
    if (response != null) {
      final data = jsonEncode(response);

      await storage.write(StringValues.profileData, data);
      printLog(StringValues.profileDetailsSaved);
    } else {
      printLog(StringValues.profileDetailsNotSaved);
    }
  }

  static Future<dynamic> readProfileDataFromLocalStorage() async {
    if (storage.hasData(StringValues.profileData)) {
      final data = await storage.read(StringValues.profileData);
      var decodedData = jsonDecode(data);
      printLog(StringValues.profileDetailsFound);
      return decodedData;
    }
    printLog(StringValues.profileDetailsNotFound);
    return null;
  }

  static Future<void> clearLoginDataFromLocalStorage() async {
    await storage.remove(StringValues.loginData);
    await storage.remove(StringValues.profileData);
    await storage.remove(StringValues.channelData);
    printLog(StringValues.authDetailsRemoved);
  }

  static void printLog(message) {
    debugPrint(
        "=======================================================================");
    debugPrint(message.toString());
    debugPrint(
        "=======================================================================");
  }

  static Future<dynamic> selectSingleImage({ImageSource? imageSource}) async {
    final imagePicker = ImagePicker();
    final imageCropper = ImageCropper();
    final pickedImage = await imagePicker.pickImage(
      maxWidth: 1920.0,
      maxHeight: 1920.0,
      source: imageSource ?? ImageSource.gallery,
    );

    if (pickedImage != null) {
      var croppedFile = await imageCropper.cropImage(
        maxWidth: 1920,
        maxHeight: 1920,
        sourcePath: pickedImage.path,
        aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
        cropStyle: CropStyle.circle,
        uiSettings: [
          AndroidUiSettings(
            toolbarColor: Theme.of(Get.context!).scaffoldBackgroundColor,
            toolbarTitle: StringValues.cropImage,
            toolbarWidgetColor: Theme.of(Get.context!).colorScheme.primary,
            backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor,
          ),
          IOSUiSettings(
            title: StringValues.cropImage,
            minimumAspectRatio: 1.0,
          ),
        ],
        compressQuality: 70,
      );

      return File(croppedFile!.path);
    }

    return null;
  }

  /// Generates a random integer where [from] <= [to].
  static int randomBetween(int from, int to) {
    if (from > to) throw Exception('$from cannot be > $to');
    var rand = Random();
    return ((to - from) * rand.nextDouble()).toInt() + from;
  }

  /// Generates a random string of [length] with characters
  /// between ascii [from] to [to].
  /// Defaults to characters of ascii '!' to '~'.
  static String randomString(int length,
      {int from = asciiStart, int to = asciiEnd}) {
    return String.fromCharCodes(
        List.generate(length, (index) => randomBetween(from, to)));
  }

  /// Generates a random string of [length] with only numeric characters.
  static int randomNumeric(int length) =>
      int.parse(randomString(length, from: numericStart, to: numericEnd));

  static int randomIntNumeric(int length) =>
      int.parse(randomString(length, from: numericStart, to: numericEnd));

  static String formatMeetingId(String id) {
    final meetingId = id.replaceAllMapped(
        RegExp(r'(\d{3})(\d{3})(\d+)'), (Match m) => "${m[1]} ${m[2]} ${m[3]}");
    return meetingId;
  }
}
