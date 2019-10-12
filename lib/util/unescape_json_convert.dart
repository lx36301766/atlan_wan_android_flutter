
import 'package:html_unescape/html_unescape.dart';
import 'package:json_annotation/json_annotation.dart';

final HtmlUnescape htmlUnescape = HtmlUnescape();

class UnescapeJsonConvert implements JsonConverter<String, String> {
  const UnescapeJsonConvert();

  @override
  String fromJson(String json) {
    return htmlUnescape.convert(json);
  }

  @override
  String toJson(String json) => json;
}
