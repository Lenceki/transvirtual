import 'dart:convert';
import 'dart:math';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:trans_virtual/data/app_dio.dart';
import 'package:trans_virtual/domain/model/user_login.dart';
import 'package:trans_virtual/domain/repository_type/auth_repo_type.dart';

class AuthRepo implements AuthRepoType {

  final dio = appDio();

  UserLogin? currentUser;

  Future<Box> getBox() async {
    return await Hive.openBox('AuthRepo');
  }

  @override
  Future<UserLogin> login(String username, String password) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final deviceInfo =  DeviceInfoPlugin();
    var deviceName = "unknown";
    var deviceSerial = "unknown";
    var deviceManufacturer = "unknown";
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        final androidInfo = await deviceInfo.androidInfo;
        deviceName = androidInfo.model;
        deviceSerial = androidInfo.serialNumber;
        deviceManufacturer = androidInfo.manufacturer;
      case TargetPlatform.iOS:
        final iosInfo = await deviceInfo.iosInfo;
        deviceName = iosInfo.model;
        deviceSerial = iosInfo.identifierForVendor ?? "unknown";
        deviceManufacturer = "Apple Inc.";
      default:
        break;
    }

    // Token from firebase cloud messaging
    String fcmToken = getRandString(50);

    var response = await dio.post('/General/Login', data: {
      "username": username,
      "password": password,
      "deviceDetails": {
        "deviceManufacturer": deviceManufacturer,
        "deviceName": deviceName,
        "versionSource": packageInfo.packageName,
        "deviceSerial": deviceSerial,
        "currentVersion": packageInfo.buildNumber,
        "fcmToken": fcmToken
      } });

    var box = await getBox();
    await box.add(response.data);
    currentUser = UserLogin.fromJson(response.data);
    return currentUser!;
  }

  @override
  Future<void> logout() async {
    final id = currentUser?.currentUserShortName;
    if (id == null) return;
    var box = await getBox();

    await box.deleteAt(0);
    currentUser = null;
  }

  String getRandString(int len) {
    var random = Random.secure();
    var values = List<int>.generate(len, (i) =>  random.nextInt(255));
    return base64UrlEncode(values);
  }

  @override
  Future<UserLogin?> autoLogin() async {
    var box = await getBox();
    if (box.isEmpty || box.getAt(0) == null) {
      return null;
    }
    currentUser = UserLogin.fromJson(Map<String, dynamic>.from(box.getAt(0)!));
    return currentUser!;
  }




}