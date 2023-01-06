import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../Ads/adhelper.dart';
import 'ChapterReaderPage.dart';

class ChapterListPage extends StatefulWidget {
  final dynamic book;
  // const ChapterListPage({Key? key, book}) : super(key: key);
  // receive data from the FirstScreen as a parameter
  const ChapterListPage({super.key, required this.book});

  @override
  _ChapterListPageState createState() => _ChapterListPageState();
}

class _ChapterListPageState extends State<ChapterListPage> {

  late BannerAd _bottomBannerAd;
  bool _isBottomBannerAdLoaded = false;

  @override
  void initState() {
    super.initState();
    _createBottomBannerAd();
  }

  @override
  void dispose() {
    super.dispose();
    _bottomBannerAd.dispose();
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
        title: Text(widget.book["name"], style: const TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(5.0),
        separatorBuilder: (context, index) =>
        const Divider(height: 5, color: Color(0xFFDADADA)),
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.book["chapters"].length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ChapterReaderPage(book: widget.book, initialChapter: index)),
              );
            },
            child: Card(
                color: const Color(0xFFDADADA),
                child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.orange[700],
                      child: Text(
                        '${index + 1}',
                        style: const TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text('${widget.book["name"]} ${index + 1}',
                        style: const TextStyle(
                          fontFamily: 'Montserrat',
                          color: Color(0xFF003366),
                          fontWeight: FontWeight.bold,
                        )))),
          );
        },
      ),
    );
  }

  void _createBottomBannerAd() {
    _bottomBannerAd = BannerAd(
      adUnitId: AdHelper.bibleVerseBannerAdUnitId,
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
