import 'dart:io';

class AdHelper {
  // 테스트용 id
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/6300978111';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
    }
    throw UnsupportedError("Unsupported platform");
  }

  static String get nativeAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/2247696110';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/3986624511';
    }
    throw UnsupportedError("Unsupported platform");
  }

  // // 서비스용 id
  // static String get bannerAdUnitId {
  //   if (Platform.isAndroid) {
  //     return "ca-app-pub-8792702490232026/1030658792";
  //   } else if (Platform.isIOS) {
  //     return "ca-app-pub-8792702490232026/5841483410";
  //   } else {
  //     throw UnsupportedError("Unsupported platform");
  //   }
  // }

  // static String get nativeAdUnitId {
  //   if (Platform.isAndroid) {
  //     return "ca-app-pub-8792702490232026/5244633336";
  //   } else if (Platform.isIOS) {
  //     return "ca-app-pub-8792702490232026/3602332882";
  //   } else {
  //     throw UnsupportedError("Unsupported platform");
  //   }
  // }
}
