import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final Color indicatorColor;
  final Color activeColor;
  final Color inactiveColor;
  final bool shadow;
  int currentIndex;
  IconData iconData;
  final ValueChanged<int> onTap;
  final List<CustomBottomNavigationBarItem> items;

  CustomBottomNavigationBar({
    Key key,
    @required this.onTap,
    @required this.items,
    this.activeColor,
    this.inactiveColor = Colors.grey,
    this.indicatorColor,
    this.shadow = true,
    this.currentIndex = 0,
  }) : super(key: key);

  @override
  State createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  static const double BAR_HEIGHT = 50;
  static const double INDICATOR_HEIGHT = 4;

  List<CustomBottomNavigationBarItem> get items => widget.items;

  double width = 0;
  Color activeColor;
  Duration duration = Duration(milliseconds: 170);

  double _getIndicatorPosition(int index) {
    var isLtr = Directionality.of(context) == TextDirection.ltr;
    if (isLtr)
      return lerpDouble(-1.0, 1.0, index / (items.length - 1));
    else
      return lerpDouble(1.0, -1.0, index / (items.length - 1));
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    activeColor = Color(0xfffa1a8e);

    return Container(
      height: BAR_HEIGHT + MediaQuery.of(context).viewPadding.bottom,
      width: width,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Color(0xff24cafc), Color(0xffce47c7)]),
        boxShadow: widget.shadow
            ? [
                BoxShadow(color: Colors.black12, blurRadius: 10),
              ]
            : null,
      ),
      child: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Positioned(
            top: INDICATOR_HEIGHT,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: items.map((item) {
                var index = items.indexOf(item);
                return GestureDetector(
                  onTap: () => _select(index, item),
                  child: _buildItemWidget(item, index == widget.currentIndex),
                );
              }).toList(),
            ),
          ),
          Positioned(
            bottom: 0,
            width: width,
            child: AnimatedAlign(
              alignment:
                  Alignment(_getIndicatorPosition(widget.currentIndex), 0),
              curve: Curves.linear,
              duration: duration,
              child: Container(
                color: widget.indicatorColor ?? activeColor,
                width: width / items.length,
                height: INDICATOR_HEIGHT,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _select(int index, CustomBottomNavigationBarItem item) {
    widget.currentIndex = index;
    widget.onTap(widget.currentIndex);

    setState(() {});
  }

  Widget _buildText(CustomBottomNavigationBarItem item) {
    return DefaultTextStyle.merge(
      child: item.text,
      style: TextStyle(color: Colors.white),
    );
  }

  Widget _buildItemWidget(CustomBottomNavigationBarItem item, bool isSelected) {
    return Container(
      height: BAR_HEIGHT,
      width: width / items.length,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[_buildText(item)],
      ),
    );
  }
}

class CustomBottomNavigationBarItem {
  final Text text;

  CustomBottomNavigationBarItem({
    @required this.text,
  });
}
