import 'dart:io';

import 'package:telegraph/telegraph.dart';
import 'package:telegraph/telegraph_core.dart';
import "package:general_lib/general_lib.dart";

void main(List<String> arguments) async {
  Telegraph telegraph = Telegraph();

  var res = await telegraph.getPage(
    // access_token: "6e98293f3a4fca325fc2b8ecfef07ad99a5f18ca2c93fc0f24a6c6ebc818",
    path: "Automation-BOT-08-09",
    return_content: false,
    // title: "slebew", 
    // content: [
    //   {
    //     "tag": "a", // Specifies the tag.
    //     "attrs": {
    //       "href": "https://github.com", // Attributes supports `href` and `src`.
    //     },
    //     "children": ["sa"], // Children can be another Node, parsed HTML, parsed MD, strings.
    //   },
    //   {
    //     "tag": "br",
    //   },
    //   {
    //     "tag": "p", // Paragraph
    //     "children": ["GitHub is where over 73 million developers shape the future of software, together."],
    //   },
    //   {
    //     "tag": "img", // Image
    //     "attrs": {
    //       // Attributes supports `href` and `src`.
    //       "src": "https://github.githubassets.com/images/modules/site/social-cards/github-social.png",
    //     },
    //   },
    //   {
    //     "tag": "br",
    //   },
    //   {
    //     "tag": "pre", // Paragraph
    //     "children": [
    //       "GitHub is where over 73 million developers shape the future of software, together.",
    //     ],
    //   },
    //   {
    //     "tag": "br",
    //   },
    //   {
    //     "tag": "a", // Paragraph
    //     "attrs": {          "href": "https://github.githubassets.com/images/modules/site/social-cards/github-social.png",

    //       // Attributes supports `href` and `src`.
    //       "src": "https://github.githubassets.com/images/modules/site/social-cards/github-social.png",
    //     },
    //     "children": [
    //       "GitHub is where over 73 million developers shape the future of software, together.",
    //     ],
    //   },
    // ],
    // path: "slasapsp-10-27",
  );

  res.printPretty();

  exit(0);
}
