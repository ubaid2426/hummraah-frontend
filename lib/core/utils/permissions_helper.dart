// lib/utils/permissions_helper.dart
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';

class PermissionsHelper {
  static Future<bool> requestLocationPermission() async {
    final status = await Permission.location.request();
    return status.isGranted;
  }

  static Future<bool> requestNotificationPermission() async {
    final status = await Permission.notification.request();
    return status.isGranted;
  }

  static Future<bool> requestStoragePermission() async {
    if (await Permission.storage.request().isGranted) {
      return true;
    }
    
    // For Android 13+
    final photos = await Permission.photos.request();
    final videos = await Permission.videos.request();
    return photos.isGranted || videos.isGranted;
  }

  static Future<bool> requestMicrophonePermission() async {
    final status = await Permission.microphone.request();
    return status.isGranted;
  }

  static Future<Map<Permission, PermissionStatus>> requestMultiplePermissions(
    List<Permission> permissions,
  ) async {
    return await permissions.request();
  }

  static Future<bool> checkLocationPermission() async {
    final status = await Permission.location.status;
    return status.isGranted;
  }

  static Future<bool> checkNotificationPermission() async {
    final status = await Permission.notification.status;
    return status.isGranted;
  }

  // static Future<void> openAppSettings() async {
  //   await openAppSettings();
  // }

  static String getPermissionMessage(Permission permission) {
    switch (permission) {
      case Permission.location:
        return 'Location permission is needed to show prayer times and Qibla direction';
      case Permission.notification:
        return 'Notification permission is needed to remind you of prayer times';
      case Permission.storage:
      case Permission.photos:
      case Permission.videos:
        return 'Storage permission is needed to download guides and duas';
      case Permission.microphone:
        return 'Microphone permission is needed for voice assistance';
      default:
        return 'This permission is needed for app functionality';
    }
  }
}