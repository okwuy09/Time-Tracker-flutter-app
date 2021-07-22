import 'package:flutter/material.dart';
import 'package:time_flutter_course/common_widgets/custom_raised_button.dart';

class SocialSignInButton extends CustomRaisedButton{
  SocialSignInButton ({
    String text,
    @required String assetName,
    @required Color textColor,
    Color color,
    VoidCallback onPressed,
  }) : super (
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(assetName),
        Text(text,
        style: TextStyle(color: textColor, fontSize: 12.0 ),
        ),
        Opacity(
          opacity: 0.0,
          child: Image.asset(assetName),
        ),
      ],
    ),
    color: color,
    onPressed: onPressed,
  );
}