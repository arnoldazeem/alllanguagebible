import 'dart:io';

class AdHelper {


  static String get englishBookBanner{
    if (Platform.isAndroid) {
      return "ca-app-pub-9817298262215349/8037591285";
    } else if (Platform.isIOS) {
      return "ca-app-pub-9817298262215349/4534031362";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get bibleChapterBanner{
    if (Platform.isAndroid) {
      return "ca-app-pub-9817298262215349/8744739111";
    } else if (Platform.isIOS) {
      return "ca-app-pub-9817298262215349/6840059684";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }


  static String get bibleVerseBanner{
    if (Platform.isAndroid) {
      return "ca-app-pub-9817298262215349/4261997806";
    } else if (Platform.isIOS) {
      return "ca-app-pub-9817298262215349/8891507957";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }


  static String get frenchBookBanner{
    if (Platform.isAndroid) {
      return "ca-app-pub-9817298262215349/7271304529";
    } else if (Platform.isIOS) {
      return "ca-app-pub-9817298262215349/5571780861";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }


  static String get germanBookBanner{
    if (Platform.isAndroid) {
      return "ca-app-pub-9817298262215349/1440964167";
    } else if (Platform.isIOS) {
      return "ca-app-pub-9817298262215349/5206865070";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }


  static String get chineseBookBanner{
    if (Platform.isAndroid) {
      return "ca-app-pub-9817298262215349/6501719154";
    } else if (Platform.isIOS) {
      return "ca-app-pub-9817298262215349/3482719862";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }


  static String get spanishBookBanner{
    if (Platform.isAndroid) {
      return "ca-app-pub-9817298262215349/1210111441";
    } else if (Platform.isIOS) {
      return "ca-app-pub-9817298262215349/1172800035";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }




  static String get bibleSearchViewAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/6300978111";
    } else if (Platform.isIOS) {
      //   ca-app-pub-9817298262215349/4089729764
      return "ca-app-pub-3940256099942544/2934735716";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }





}