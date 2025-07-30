import 'package:shared_preferences/shared_preferences.dart';
import 'package:package_info_plus/package_info_plus.dart';

class VersionService {
  static const String _versionKey = 'app_version';
  static const String _buildNumberKey = 'build_number';
  static const String _lastUpdateCheckKey = 'last_update_check';
  static const String _firstLaunchKey = 'first_launch';

  /// Check if this is the first time the app is launched
  Future<bool> isFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirst = prefs.getBool(_firstLaunchKey) ?? true;

    if (isFirst) {
      await prefs.setBool(_firstLaunchKey, false);
    }

    return isFirst;
  }

  /// Check if the app has been updated since last launch
  Future<bool> hasAppUpdated() async {
    final prefs = await SharedPreferences.getInstance();
    final packageInfo = await PackageInfo.fromPlatform();

    final storedVersion = prefs.getString(_versionKey);
    final storedBuildNumber = prefs.getString(_buildNumberKey);

    final currentVersion = packageInfo.version;
    final currentBuildNumber = packageInfo.buildNumber;

    // Save current version info
    await prefs.setString(_versionKey, currentVersion);
    await prefs.setString(_buildNumberKey, currentBuildNumber);
    await prefs.setInt(
        _lastUpdateCheckKey, DateTime.now().millisecondsSinceEpoch);

    // Check if version or build number has changed
    if (storedVersion == null || storedBuildNumber == null) {
      return false; // First installation
    }

    return storedVersion != currentVersion ||
        storedBuildNumber != currentBuildNumber;
  }

  /// Get current app version info
  Future<Map<String, String>> getVersionInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();

    return {
      'appName': packageInfo.appName,
      'packageName': packageInfo.packageName,
      'version': packageInfo.version,
      'buildNumber': packageInfo.buildNumber,
    };
  }

  /// Get last update check timestamp
  Future<DateTime?> getLastUpdateCheck() async {
    final prefs = await SharedPreferences.getInstance();
    final timestamp = prefs.getInt(_lastUpdateCheckKey);

    if (timestamp == null) return null;

    return DateTime.fromMillisecondsSinceEpoch(timestamp);
  }

  /// Clear all version tracking data
  Future<void> clearVersionData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_versionKey);
    await prefs.remove(_buildNumberKey);
    await prefs.remove(_lastUpdateCheckKey);
    await prefs.remove(_firstLaunchKey);
  }
}
