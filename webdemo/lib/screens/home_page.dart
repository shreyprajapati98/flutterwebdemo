import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:webdemo/widgets/web_scrollbar.dart';
import 'package:webdemo/widgets/bottom_bar.dart';
import 'package:webdemo/widgets/carousel.dart';
import 'package:webdemo/widgets/destination_heading.dart';
import 'package:webdemo/widgets/explore_drawer.dart';
import 'package:webdemo/widgets/featured_heading.dart';
import 'package:webdemo/widgets/featured_tiles.dart';
import 'package:webdemo/widgets/floating_quick_access_bar.dart';
import 'package:webdemo/widgets/responsive.dart';
import 'package:webdemo/widgets/top_bar_contents.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const String route = '/';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController _scrollController;
  double _scrollPosition = 0;
  double _opacity = 0;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      extendBodyBehindAppBar: true,
      appBar: ResponsiveWidget.isSmallScreen(context)
          ? AppBar(
              backgroundColor:
                  Theme.of(context).bottomAppBarColor.withOpacity(_opacity),
              elevation: 0,
              centerTitle: true,
              actions: [
                IconButton(
                  icon: Icon(Icons.brightness_6),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {
                  
                    print(Theme.of(context).brightness);
                  },
                ),
              ],
              title: Text(
                'EXPLORE',
                style: TextStyle(
                  color: Colors.blueGrey[100],
                  fontSize: 20,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400,
                  letterSpacing: 3,
                ),
              ),
            )
          : PreferredSize(
              preferredSize: Size(screenSize.width, 1000),
              child: TopBarContents(_opacity),
            ),
      drawer: ExploreDrawer(),
      body: WebScrollbar(
        color: Colors.blueGrey,
        backgroundColor: Colors.blueGrey.withOpacity(0.3),
        width: 10,
        heightFraction: 0.3,
        controller: _scrollController,
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: ClampingScrollPhysics(),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    child: SizedBox(
                      height: screenSize.height * 0.45,
                      width: screenSize.width,
                      child: Image.asset(
                        'assets/images/cover.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      FloatingQuickAccessBar(screenSize: screenSize),
                      Container(
                        child: Column(
                          children: [
                            FeaturedHeading(
                              screenSize: screenSize,
                            ),
                            FeaturedTiles(screenSize: screenSize)
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
              // SizedBox(height: screenSize.height / 8),
              DestinationHeading(screenSize: screenSize),
              DestinationCarousel(),
              SizedBox(height: screenSize.height / 10),
              BottomBar(),
            ],
          ),
        ),
      ),
    );
  }
}
