import 'package:flutter_simple_updates/interface/IConverter.dart';
import 'package:html2md/html2md.dart' as html2md;

/// Converts HTML to Markdown using [html2md](https://pub.dev/packages/html2md)
class HTMLtoMarkDownConverter implements IConverter {
  const HTMLtoMarkDownConverter();
  @override
  String convert(String html) {
    return html2md.convert(html);
  }
}
