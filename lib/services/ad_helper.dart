import 'package:package_info_plus/package_info_plus.dart';

//TODO: This needs improvement.

class AdUnitId {
  static late String packageName;
  static late String version;
  static final String testAdUnitId = 'ca-app-pub-3940256099942544/6300978111';

  /// Gets package name
  void getPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    packageName = packageInfo.packageName;
    version = packageInfo.version;
  }

  /// Home Page Banner AD ID
  static String get homePageBanner {
    if (packageName == 'com.oran.spaceportal') {
      // REAL ID
      return 'ca-app-pub-4037518144985807/2040144982';
    } else {
      // TEST ID
      return testAdUnitId;
    }
  }

  /// APOD Page Banner AD ID
  static String get apodPageBanner {
    if (packageName == 'com.oran.spaceportal') {
      // REAL ID
      return 'ca-app-pub-4037518144985807/5020621415';
    } else {
      // TEST AD
      return testAdUnitId;
    }
  }

  /// Launch Page Banner AD ID
  static String get launchPageBanner {
    if (packageName == 'com.oran.spaceportal') {
      // REAL ID
      return 'ca-app-pub-4037518144985807/6781592935';
    } else {
      // TEST AD
      return testAdUnitId;
    }
  }

  /// Single Launch Page Banner AD ID
  static String get singleLaunchPageBanner {
    if (packageName == 'com.oran.spaceportal') {
      // REAL ID
      return 'ca-app-pub-4037518144985807/3012085927';
    } else {
      // TEST AD
      return testAdUnitId;
    }
  }

  /// Article Page Banner AD ID
  static String get articlePageBanner {
    if (packageName == 'com.oran.spaceportal') {
      // REAL ID
      return 'ca-app-pub-4037518144985807/7056925101';
    } else {
      // TEST AD
      return testAdUnitId;
    }
  }
}
