import 'package:all_language_bible/chinese/chinese.dart';
import 'package:all_language_bible/common/search_reader.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../Ads/adhelper.dart';

/**
 * This contains the page were the results of the chapter is shown
 * you then tap on the results to go the verses reader page
 * SearchReaderPage(
    book: data![index],
    initialChapter:
    int.parse(data![index]['index']),
    keyword: keyword)));
 */

const colorgray = Color(0xFFDADADA);
// const colororange = Color(0xFFFF8800);

class BibleSearchPage extends StatefulWidget {
  final List<dynamic> datare;
  final Color appBarcolor;
  final Color bottomBarcolor;
  final Color lableColor;

  const BibleSearchPage(
      {super.key,
      required this.datare,
      required this.appBarcolor,
      required this.bottomBarcolor,
      required this.lableColor});

  @override
  _BibleSearchPageState createState() => _BibleSearchPageState();
}

class _BibleSearchPageState extends State<BibleSearchPage> {
  late String keyword = "";
  List<dynamic> dataReturned = [];
  List<dynamic>? data = [];
  late int chapterIndex;
  late PageController _pageController;
  bool _isBottomBannerAdLoaded = false;
  late BannerAd _bottomBannerAd;

  @override
  void initState() {
    // TODO: implement initState
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
        color: widget.bottomBarcolor,
        shape: const CircularNotchedRectangle(),
        child: Container(
          margin: const EdgeInsets.only(left: 12.0, right: 12.0),
          height: 60.0,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.of(context).pop(true),
              ),
            ],
          ),
        ),
      ),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: Container(
          child: Container(
            height: _bottomBannerAd.size.height.toDouble(),
            width: _bottomBannerAd.size.width.toDouble(),
            child: AdWidget(ad: _bottomBannerAd),
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Center(
              child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                  labelStyle: TextStyle(color: colorAppbar),
                  border: OutlineInputBorder(),
                  // when it is focused
                  focusedBorder: const OutlineInputBorder(
                    borderSide:  BorderSide(color: colorAppbar),
                  )
                  , labelText: 'Bible Verse'),
              onChanged: (value) {
                keyword = value;
                setState(() {
                  // If the search term is empty, clear the search results
                  if (keyword.isEmpty) {
                    data = [];
                  } else {
                    data = searchJson(keyword, widget.datare);
                  }
                });
              },
            ),
          ),
          Container(
            child: ListView.separated(
              padding: const EdgeInsets.all(5.0),
              itemCount: data?.length ?? 0,
              separatorBuilder: (context, index) =>
                   Divider(height: 5,  color: widget.appBarcolor),
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  // on click to view results
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                // keyword is optional only considered when search value is present
                                SearchReaderPage(
                                    book: data![index],
                                    initialChapter:
                                        int.parse(data![index]['index']),
                                    keyword: keyword, appBarcolor: widget.appBarcolor, bottomBarcolor: widget.bottomBarcolor, lableColor: widget.lableColor)));
                  },
                  child: Card(
                    color: colorgray,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: widget.lableColor,
                        child: Text(data![index]["abbrev"],
                            style: const TextStyle(
                              fontFamily: 'Montserrat',
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      title: Text(data![index]["name"],
                          style: const TextStyle(
                            fontFamily: 'Montserrat',
                            color: Color(0xFF003366),
                            fontWeight: FontWeight.bold,
                          )),
                      subtitle: Text(data![index]["index"].toString()),
                    ),
                  ),
                );
              },
            ),
          )
          // for zooming
        ],
      ))), // The search area here
    );
  }

  List<dynamic> searchJson(String searchTerm, List<dynamic> json) {
    List<dynamic> results = [];
    Map<int, bool> chaptersAdded =
        {}; // hash map to store the indices of chapters that have already been added
    for (var book in json) {
      int chapterIndex = 1;
      for (var chapter in book['chapters']) {
        for (var verse in chapter) {
          if (verse.toLowerCase().contains(searchTerm.toLowerCase())) {
            if (!chaptersAdded.containsKey(chapterIndex)) {
              // check if chapter has already been added
              dynamic result = {
                'abbrev': book['abbrev'],
                'name': book['name'],
                'index': chapterIndex.toString(),
                'chapters': chapter
              };
              results.add(result);
              chaptersAdded[chapterIndex] =
                  true; // add chapter index to hash map
              break;
            }
            break;
          }
        }
        chapterIndex++;
      }
    }
    return results;
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
