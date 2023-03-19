import 'dart:developer';

import 'package:all_language_bible/common/verses_reader_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../Ads/adhelper.dart';

class SearchReaderPage extends StatefulWidget {
  const SearchReaderPage(
      {Key? key, this.book, required this.initialChapter, this.keyword})
      : super(key: key);

  // can be null
  final String? keyword;
  final dynamic book;
  final int initialChapter;

  @override
  State<StatefulWidget> createState() =>
      _SearchReaderState(this.initialChapter);
}

class _SearchReaderState extends State<SearchReaderPage> {
  _SearchReaderState(this.chapterIndex);

  int chapterIndex;
  late PageController _pageController;

  late BannerAd _bottomBannerAd;
  bool _isBottomBannerAdLoaded = false;
  List<dynamic> verse = [];

  @override
  void initState() {
    super.initState();
    _createBottomBannerAd();
    _pageController = PageController(initialPage: chapterIndex);
    widget.book["chapters"].forEach((verses) {
      verse.add(verses);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _bottomBannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomAppBar(
          color: const Color(0xFFFF8800),
          child: SizedBox(
            height: _bottomBannerAd.size.height.toDouble(),
            width: _bottomBannerAd.size.width.toDouble(),
            child: AdWidget(ad: _bottomBannerAd),
          ),
        ),
        appBar: AppBar(
            title: Text('${widget.book["name"]} ${chapterIndex}',
                style: const TextStyle(color: Colors.white)),
            iconTheme: const IconThemeData(
              color: Colors.white, //change your color here
            )),
        body: Container(
            // for zooming
            child: InteractiveViewer(
                child: PageView(
          scrollDirection: Axis.vertical,
          controller: _pageController,
          children:  [
        //       widget.book["chapters"].forEach((verses) {
        //       verse.add(verses);
        //       }),
            VersesReaderWidget(verses: verse, keyword: widget.keyword)
          ],
        ))));
  }

  void _createBottomBannerAd() {
    _bottomBannerAd = BannerAd(
      adUnitId: AdHelper.bibleSearchViewAdUnitId,
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
