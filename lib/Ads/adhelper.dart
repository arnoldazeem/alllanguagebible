import 'dart:io';

class AdHelper {


  static String get bibleChapterBanner{
    if (Platform.isAndroid) {
      return "ca-app-pub-9817298262215349/5785666149";
    } else if (Platform.isIOS) {
      return "ca-app-pub-9817298262215349/6840059684";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }


  static String get bibleVerseBanner{
    if (Platform.isAndroid) {
      return "ca-app-pub-9817298262215349/2584787735";
    } else if (Platform.isIOS) {
      return "ca-app-pub-9817298262215349/8891507957";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get bibleSearchViewAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-9817298262215349/7852005403";
    } else if (Platform.isIOS) {
      return "ca-app-pub-9817298262215349/9912613417";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get englishBookBanner{
    if (Platform.isAndroid) {
      return "ca-app-pub-9817298262215349/3800283592";
    } else if (Platform.isIOS) {
      return "ca-app-pub-9817298262215349/4534031362";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get frenchBookBanner{
    if (Platform.isAndroid) {
      return "ca-app-pub-9817298262215349/1187945586";
    } else if (Platform.isIOS) {
      return "ca-app-pub-9817298262215349/5571780861";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get germanBookBanner{
    if (Platform.isAndroid) {
      return "ca-app-pub-9817298262215349/2309455567";
    } else if (Platform.isIOS) {
      return "ca-app-pub-9817298262215349/5206865070";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get chineseBookBanner{
    if (Platform.isAndroid) {
      return "ca-app-pub-9817298262215349/8279967542";
    } else if (Platform.isIOS) {
      return "ca-app-pub-9817298262215349/3482719862";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get spanishBookBanner{
    if (Platform.isAndroid) {
      return "ca-app-pub-9817298262215349/3430965542";
    } else if (Platform.isIOS) {
      return "ca-app-pub-9817298262215349/1172800035";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

}