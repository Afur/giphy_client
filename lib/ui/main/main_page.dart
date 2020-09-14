import 'package:flutter/material.dart';
import 'package:giphyclient/generated/l10n.dart';
import 'package:giphyclient/ui/content/content_page.dart';
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
          CustomBottomNavigationBarItem(text: Text(S.of(context).feed)),
          CustomBottomNavigationBarItem(text: Text(S.of(context).saved)),
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