import 'dart:convert';

import 'package:all_language_bible/common/bibleSearchPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../Ads/adhelper.dart';
import '../common/ChapterListPage.dart';

const colorred = const Color(0xFFC8102E);
const colorAppbar = const Color(0xFF012169);
const colorgrey = const Color(0xFFDADADA);

class english extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<english> {
  List<dynamic> data = [];
  String title = 'The Books of the Bible';
  late BannerAd _bottomBannerAd;
  bool _isBottomBannerAdLoaded = false;

  @override
  void initState() {
    super.initState();
    _createBottomBannerAd();
    loadBibleData().then((String d) => {
      setState(() {
        data = jsonDecode(d);
      })
    });
  }

  @override
  void dispose() {
    super.dispose();
    _bottomBannerAd.dispose();
  }

  Future<String> loadBibleData() async {
    return await rootBundle.loadString('assets/en_kjv.json');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: colorAppbar,
        child: Container(
          height: _bottomBannerAd.size.height.toDouble(),
          width: _bottomBannerAd.size.width.toDouble(),
          child: AdWidget(ad: _bottomBannerAd),
        ),
      ),
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(title, style: const TextStyle(color: Colors.white)),
        backgroundColor: colorAppbar,
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (
                              context,
                              // data is sent here for search
                              ) => BibleSearchPage(datare: data, appBarcolor: colorAppbar, bottomBarcolor: colorAppbar, lableColor: colorred)

                  ));
                },
                child: const Icon(
                  Icons.search,
                  size: 26.0,
                ),
              )),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(5.0),
        itemCount: data.length,
        separatorBuilder: (context, index) =>
        const Divider(height: 5, color: colorAppbar),
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  // send color to change selected language
                  builder: (context) => ChapterListPage(book: data[index], appBarcolor: colorAppbar, bottomBarcolor: colorAppbar, lableColor: colorred)),

              );
            },
            child: Card(
              color: colorgrey,
              child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: colorred,
                    child: Text(data[index]["abbrev"],
                        style: const TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  title: Text(data[index]["name"],
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        color: Color(0xFF003366),
                        fontWeight: FontWeight.bold,
                      ))),
            ),
          );
        },
      ),
    );
  }

  void _createBottomBannerAd() {
    _bottomBannerAd = BannerAd(
      adUnitId: AdHelper.englishBookBanner,
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBottomBannerAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    );
    _bottomBannerAd.load();
  }
}
