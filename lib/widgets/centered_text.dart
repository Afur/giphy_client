import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CenteredText extends StatelessWidget {
  final String text;

  CenteredText(this.text);

  @override
  Widget build(BuildContext context) => Center(
        child: Text(text, style: TextStyle(color: Colors.white)),
      );
}
