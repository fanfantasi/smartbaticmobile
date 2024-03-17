import 'package:permission_handler/permission_handler.dart';

import 'package:flutter/services.dart';

class Permissions {
  static Future<bool> cameraAndMicrophonePermissionsGranted() async {
    PermissionStatus cameraPermissionStatus = await _getCameraPermission();
    PermissionStatus storagePermissionStatus = await _getStoragePermission();
    PermissionStatus microphonePermissionStatus =
        await _getMicrophonePermission();

    if (cameraPermissionStatus == PermissionStatus.granted &&
        storagePermissionStatus == PermissionStatus.granted &&
        microphonePermissionStatus == PermissionStatus.granted) {
      return true;
    } else {
      _handleCameraMicrophoneInvalidPermissions(
        cameraPermissionStatus,
        storagePermissionStatus,
        microphonePermissionStatus,
      );
      return false;
    }
  }

  static Future<bool> storageAndMicrophonePermissionsGranted() async {
    PermissionStatus storagePermissionStatus = await _getStoragePermission();
    PermissionStatus microphonePermissionStatus =
        await _getMicrophonePermission();
    if (storagePermissionStatus == PermissionStatus.granted &&
        microphonePermissionStatus == PermissionStatus.granted) {
      return true;
    } else {
      _handleStorageMicrophoneInvalidPermissions(
        storagePermissionStatus,
        microphonePermissionStatus,
      );
      return false;
    }
  }

  static Future<bool> storagePermissionsGranted() async {
    PermissionStatus storagePermissionStatus = await _getStoragePermission();
    return storagePermissionStatus == PermissionStatus.granted;
  }

  static Future<bool> microphonePermissionsGranted() async {
    PermissionStatus microphonePermissionStatus =
        await _getMicrophonePermission();
    if (microphonePermissionStatus == PermissionStatus.granted) {
      return true;
    } else {
      _handleMicrophoneInvalidPermissions(microphonePermissionStatus);
      return false;
    }
  }

  static Future<PermissionStatus> _getCameraPermission() async {
    PermissionStatus permission = await Permission.camera.request();
    return permission;
  }

  static Future<PermissionStatus> _getMicrophonePermission() async {
    PermissionStatus permission = await Permission.microphone.request();
    return permission;
  }

  static Future<PermissionStatus> _getStoragePermission() async {
    PermissionStatus permission = await Permission.storage.request();
    return permission;
  }

  static void _handleCameraMicrophoneInvalidPermissions(
    PermissionStatus cameraPermissionStatus,
    PermissionStatus storagePermissionStatus,
    PermissionStatus microphonePermissionStatus,
  ) {
    if (cameraPermissionStatus == PermissionStatus.denied &&
        storagePermissionStatus == PermissionStatus.denied &&
        microphonePermissionStatus == PermissionStatus.denied) {
      throw PlatformException(
          code: "PERMISSION_DENIED",
          message: "Access to camera and microphone denied",
          details: null);
    } else if (cameraPermissionStatus == PermissionStatus.restricted &&
        storagePermissionStatus == PermissionStatus.restricted &&
        microphonePermissionStatus == PermissionStatus.restricted) {
      throw PlatformException(
          code: "PERMISSION_DISABLED",
          message: "Location data is not available on device",
          details: null);
    }
  }

  static void _handleStorageMicrophoneInvalidPermissions(
    PermissionStatus storagePermissionStatus,
    PermissionStatus microphonePermissionStatus,
  ) {
    if (storagePermissionStatus == PermissionStatus.denied &&
        microphonePermissionStatus == PermissionStatus.denied) {
      throw PlatformException(
          code: "PERMISSION_DENIED",
          message: "Access to storage and microphone denied",
          details: null);
    } else if (storagePermissionStatus == PermissionStatus.restricted &&
        microphonePermissionStatus == PermissionStatus.restricted) {
      throw PlatformException(
          code: "PERMISSION_DISABLED",
          message: "Location data is not available on device",
          details: null);
    }
  }

  static void _handleMicrophoneInvalidPermissions(
    PermissionStatus microphonePermissionStatus,
  ) {
    if (microphonePermissionStatus == PermissionStatus.denied) {
      throw PlatformException(
          code: "PERMISSION_DENIED",
          message: "Access to storage and microphone denied",
          details: null);
    } else if (microphonePermissionStatus == PermissionStatus.restricted) {
      throw PlatformException(
          code: "PERMISSION_DISABLED",
          message: "Location data is not available on device",
          details: null);
    }
  }
}
