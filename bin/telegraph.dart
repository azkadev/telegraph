import 'dart:io';

import 'package:telegraph/telegraph.dart';
import 'package:telegraph/telegraph_core.dart';
import "package:general_lib/general_lib.dart";

void main(List<String> arguments) async {
  Telegraph telegraph = Telegraph();

  var res = await telegraph.getAccountInfo(
    access_token: "427c04d003a1c20a662a8d9461a49943f566cb21c65f70a88f5addf8eb37"
  );

  res.printPretty();

  exit(0);
}
