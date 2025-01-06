// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:io';

import 'package:general_lib/general_lib.dart';
import 'package:telegraph/telegraph.dart';

void main(List<String> args) async {
  String file =
      "/home/galaxeus/Pictures/Karma-Kaveya-The-All-Electric-GT-Revolutionizing-Ultra-Luxury-3.jpg";
  Telegraph telegraph = Telegraph();
  try {
    final res = await telegraph.upload(
      telegraphFileDatas: [
        TelegraphFileData.file(
          File(file),
        ),
      ],
    );
    res.printPretty();
  } catch (e, stack) {
    print("error: ${e} ${stack}");
  }
  exit(0);
}
