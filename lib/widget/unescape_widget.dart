import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';

final HtmlUnescape htmlUnescape = HtmlUnescape();

class UnescapeText extends Text {
  UnescapeText(
    String data, {
    Key key,
    TextStyle style,
    StrutStyle strutStyle,
    TextAlign textAlign,
    TextDirection textDirection,
    Locale locale,
    bool softWrap,
    TextOverflow overflow,
    double textScaleFactor,
    int maxLines,
    String semanticsLabel,
    TextWidthBasis textWidthBasis,
  }) : super(
          htmlUnescape.convert(data),
          key: key,
          style: style,
          strutStyle: strutStyle,
          textAlign: textAlign,
          textDirection: textDirection,
          locale: locale,
          softWrap: softWrap,
          overflow: overflow,
          textScaleFactor: textScaleFactor,
          maxLines: maxLines,
          semanticsLabel: semanticsLabel,
          textWidthBasis: textWidthBasis,
        );
}

class UnescapeTab extends Tab {
  UnescapeTab({
    Key key,
    String text,
    Widget icon,
    Widget child,
  }) : super(
          key: key,
          text: htmlUnescape.convert(text),
          icon: icon,
          child: child,
        );
}
