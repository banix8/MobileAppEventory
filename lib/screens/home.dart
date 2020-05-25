import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:Eventory/screens/favorites.dart'; //destinations
import 'package:Eventory/screens/providers.dart';
import 'package:Eventory/screens/search.dart';
import 'package:Eventory/screens/profile.dart';
import 'package:Eventory/screens/settings.dart';
import 'package:Eventory/screens/walkthrough.dart';



class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController _pageController;
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()=>Future.value(false),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title:    Center(
            child: Image.asset('assets/header.png'),
          ),
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.info_outline,
                size: 22.0,
              ),
              onPressed: (){
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context){
                      return Walkthrough();
                    },
                  ),
                );
              },
              tooltip: "Create New Event",
            ),
          ],
        ),

        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: onPageChanged,
          children: <Widget>[
            Home(),
            FavoriteScreen(),
            SearchScreen(),
            Profile(),
            SettingsScreen(),
         
          ],
        ),

        bottomNavigationBar: BottomAppBar(
          child: new Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(width:7),
              IconButton(
                icon: Icon(
                  Icons.home,
                  size: 24.0,
                ),
                color: _page == 0
                    ? Theme.of(context).accentColor
                    : Theme
                    .of(context)
                    .textTheme.caption.color,
                onPressed: ()=>_pageController.jumpToPage(0),
              ),

              IconButton(
                icon:Icon(
                  Icons.favorite,
                  size: 24.0,
                ),
                color: _page == 1
                    ? Theme.of(context).accentColor
                    : Theme
                    .of(context)
                    .textTheme.caption.color,
                onPressed: ()=>_pageController.jumpToPage(1),
              ),

              IconButton(
                icon: Icon(
                  Icons.search,
                  size: 24.0,
                  color: Theme.of(context).primaryColor,
                ),
                color: _page == 2
                    ? Theme.of(context).accentColor
                    : Theme
                    .of(context)
                    .textTheme.caption.color,
                onPressed: ()=>_pageController.jumpToPage(2),
              ),

              IconButton(
                icon: Icon(
                  Icons.person,
                  size: 24.0,
                ),
                color: _page == 3
                    ? Theme.of(context).accentColor
                    : Theme
                    .of(context)
                    .textTheme.caption.color,
                onPressed: ()=>_pageController.jumpToPage(3),
              ),

              IconButton(
                icon: Icon(
                  Icons.settings,
                  size: 24.0,
                ),
                color: _page == 4
                    ? Theme.of(context).accentColor
                    : Theme
                    .of(context)
                    .textTheme.caption.color,
                onPressed: ()=>_pageController.jumpToPage(4),
              ),

              SizedBox(width:7),
            ],
          ),
          color: Theme.of(context).primaryColor,
          shape: CircularNotchedRectangle(),
        ),
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          elevation: 4.0,
          child: Icon(
            Icons.search,
          ),
          onPressed: ()=>_pageController.jumpToPage(2),
        ),

      ),
    );
  }

  void navigationTapped(int page) {
    _pageController.jumpToPage(page);
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }
}
