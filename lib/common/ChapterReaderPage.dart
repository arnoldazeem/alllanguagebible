import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../Ads/adhelper.dart';
import 'VersesReaderWidget.dart';

class ChapterReaderPage extends StatefulWidget {
  const ChapterReaderPage(
      {Key? key, this.book, required this.initialChapter, this.keyword})
      : super(key: key);

  // can be null
  final String? keyword;
  final dynamic book;
  final int initialChapter;

  @override
  State<StatefulWidget> createState() =>
      _ChapterReaderState(this.initialChapter);
}

class _ChapterReaderState extends State<ChapterReaderPage> {
  _ChapterReaderState(this.chapterIndex);

  int chapterIndex;
  late PageController _pageController;

  late BannerAd _bottomBannerAd;
  bool _isBottomBannerAdLoaded = false;

  @override
  void initState() {
    super.initState();
    _createBottomBannerAd();
    _pageController = PageController(initialPage: chapterIndex);
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
            title: Text('${widget.book["name"]} ${chapterIndex + 1}',
                style: const TextStyle(color: Colors.white)),
            iconTheme: const IconThemeData(
              color: Colors.white, //change your color here
            )),
        body: Container(
          // for zooming
            child: InteractiveViewer(
                child: PageView(
                  scrollDirection: Axis.horizontal,

                  children: widget.book["chapters"]
                      .map<Widget>((verses) =>
                  // keyword is optional again because of search using same class
                  VersesReaderWidget(verses: verses, keyword: widget.keyword))
                      .toList(),

                  onPageChanged: (int index) {
                    setState(() {
                      chapterIndex = index;
                    });
                  },
                  controller: _pageController,
                ))));
  }

  void _createBottomBannerAd() {
    _bottomBannerAd = BannerAd(
      adUnitId: AdHelper.bookBannerAdUnitId,
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
