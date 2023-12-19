// ignore_for_file: non_constant_identifier_names

class TelegraphUtils {
  static String parseMarkdown({required String content}) {
    String markdown_text = content.replaceAllMapped(
      RegExp(
        "<del>(.*)</del>",
        caseSensitive: false,
        multiLine: true,
      ),
      (match) {
        return "<s>${match.group(1)}</s>";
      },
    );

    return markdown_text;
  }

  static String parseHtml({required String content}) {
    return content;
  }

  static domToNode() {}
}
