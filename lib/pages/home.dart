import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_band/pages/bandPage.dart';
import 'package:music_band/pages/bookingPage.dart';
import 'package:music_band/pages/history.dart';
import 'package:music_band/pages/profile.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  PageController pageController;

  int pageIndex = 0;
  final List<Widget> _children = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController();
  }

  onPageChanged(int pageIndex){
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  onTap(int pageIndex) {
    pageController.jumpToPage(
      pageIndex,
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: PageView(
        children: <Widget>[
          BandPage(),
          History(),
          Profile(),
        ],
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: pageIndex,
        onTap: onTap,
        activeColor: Colors.teal,
        items: [
          BottomNavigationBarItem(
            title: Text('Bands',style: TextStyle(fontSize: 12.5,fontWeight: FontWeight.bold),),
            icon:Icon(Icons.library_music),
          ),
          BottomNavigationBarItem(
            title: Text('History',style: TextStyle(fontSize: 12.5,fontWeight: FontWeight.bold),),
            icon:Icon(Icons.history),
          ),
          BottomNavigationBarItem(
            title: Text('Profile',style: TextStyle(fontSize: 12.5,fontWeight: FontWeight.bold),),
            icon:Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}
