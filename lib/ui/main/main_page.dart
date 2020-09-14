import 'package:flutter/material.dart';
import 'package:giphyclient/ui/detailed/detailed_page.dart';
import 'package:giphyclient/ui/featured/content_page.dart';
import 'package:giphyclient/widgets/custom_bottom_navigation_bar.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentPageIndex = 0;

  final List<Widget> _children = [
    ContentPage(),
    ContentPage(showSavedOnly: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentPageIndex],
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentPageIndex,
        items: [
          CustomBottomNavigationBarItem(text: Text("Feed")),
          CustomBottomNavigationBarItem(text: Text("Saved")),
        ],
        onTap: onTabTapped,
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }
}