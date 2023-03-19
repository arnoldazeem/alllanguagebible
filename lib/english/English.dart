import 'dart:convert';

import 'package:all_language_bible/common/bibleSearchPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../Ads/adhelper.dart';
import '../common/ChapterListPage.dart';

const colororange = const Color(0xFFFF8800);
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
        color: const Color(0xFFFF8800),
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
                              ) => BibleSearchPage(datare: data)
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
        const Divider(height: 5, color: colororange),
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChapterListPage(book: data[index])),
              );
            },
            child: Card(
              color: colorgrey,
              child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.orange[700],
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
